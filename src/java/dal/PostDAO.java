/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.io.InputStream;
import java.sql.Blob;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import model.Post;
import model.User;
import org.apache.catalina.connector.Response;

/**
 *
 * @author Quoc Anh
 */
public class PostDAO extends DBconnector {

    public void insertPost_forUser(Post p) {
        String sqlforPost = "INSERT INTO `postes`(`Title`, `Description`, `Address`, `PhoneNumber`, `Area`, `NumberOfRoom`, `AvailableRoom`, `Price`, `PostDate`, `UserID`, `CityID`) "
                + "VALUES (?,?,?,?,?,?,?,?,?,?,?)";

        java.sql.Date sqlDate = java.sql.Date.valueOf(p.getDate());

        try {
            PreparedStatement st = conn.prepareStatement(sqlforPost);

            st.setString(1, p.getTitle());
            st.setString(2, p.getDescription());
            st.setString(3, p.getAddress());
            st.setString(4, p.getPhoneNumber());
            st.setDouble(5, p.getArea());
            st.setInt(6, p.getNumberOfRoom());
            st.setInt(7, p.getAvailableRoom());
            st.setInt(8, p.getPrice());
            st.setDate(9, sqlDate);
            st.setInt(10, p.getUserID());
            st.setInt(11, p.getCityID());

            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Could not add post for user");
            System.out.println(e);
        }
    }

    public void insertImage_forUser(Post u) {
        String sqlforImage = "INSERT INTO `image`(`Image`, `PostID`) VALUES (?,?)";
        String querryNewestId = "SELECT MAX(PostID) FROM postes";
        try {
            PreparedStatement st = conn.prepareStatement(sqlforImage);
            Statement stm = conn.createStatement();
            ResultSet rs = stm.executeQuery(querryNewestId);
            if (rs.next()) {
                int newestID = rs.getInt(1);
                st.setBlob(1, u.getUrl());
                st.setInt(2, newestID);
            }
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Could not add image for user");
            System.out.println(e);
        }
    }
    
    public int getNewestID(){
        int id = 0;
        String querryNewestId = "SELECT MAX(PostID) FROM postes";
        try {
            Statement stm = conn.createStatement();
            ResultSet rs = stm.executeQuery(querryNewestId);
            if (rs.next()) {
                int newestID = rs.getInt(1);
                return newestID;
            }
        } catch (SQLException e) {
            System.out.println("Could not add image for user");
            System.out.println(e);
        }
        return id;
    }

    public Blob getImage(int postID) {
        String query = "SELECT `Image` FROM `image` WHERE PostID = ?";
        try {
            PreparedStatement st = conn.prepareStatement(query);
            st.setInt(1, postID);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Blob blob = rs.getBlob("image");
                return blob;
            }
        } catch (SQLException e) {
            System.out.println("Could not get the image");
            System.out.println(e);
        }
        return null;
    }

    public ArrayList<Post> getListPostByAddress(String infor) {
        String query = "SELECT * FROM `postes` WHERE 1";

        ArrayList<Post> postList = new ArrayList<>();
        try {
            PreparedStatement st = conn.prepareStatement(query);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                while (rs.next()) {
                    Date dbDate = rs.getDate(10);
                    LocalDate localDate = dbDate.toLocalDate();
                    Blob blob = getImage(rs.getInt(1));
                    InputStream inputStream = blob.getBinaryStream();

                    Post post = new Post(rs.getInt(1), rs.getString(2), rs.getString(3),
                            rs.getString(4), rs.getString(5), rs.getDouble(6), rs.getInt(7),
                            rs.getInt(8), rs.getInt(9), localDate, rs.getInt(11), rs.getInt(12), inputStream);

                    postList.add(post);
                }
                
                Iterator<Post> iterator = postList.iterator();
    
                while (iterator.hasNext()) {
                    Post post = iterator.next();
                    if (!post.getAddress().toLowerCase().contains(infor)) {
                        iterator.remove();
                    }
                }
                
                return postList;
            }
        } catch (SQLException e) {
            System.out.println("Could not get any post when finding by address");
            System.out.println(e);
        }

        return null;
    }

    public ArrayList<Post> getListPostByCityAndPrice(int cityID, String price) {
        String query = "SELECT * FROM `postes` WHERE 1";

        // Prepare the price range variables
        int minPrice = 0;
        int maxPrice = Integer.MAX_VALUE;
        price = price.trim();
        if (price != null && !price.equals("all")) {
            String[] priceRange = price.split("-");
            if (priceRange.length == 2) {
                minPrice = Integer.parseInt(priceRange[0]);
                maxPrice = Integer.parseInt(priceRange[1]);
            }
        }

        ArrayList<Post> postList = new ArrayList<>();
        try {
            PreparedStatement st = conn.prepareStatement(query);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                while (rs.next()) {
                    int postPrice = rs.getInt(9);
                    if (postPrice >= minPrice && postPrice <= maxPrice) {
                        Date dbDate = rs.getDate(10);
                        LocalDate localDate = dbDate.toLocalDate();
                        Blob blob = getImage(rs.getInt(1));
                        InputStream inputStream = blob.getBinaryStream();

                        Post post = new Post(rs.getInt(1), rs.getString(2), rs.getString(3),
                                rs.getString(4), rs.getString(5), rs.getDouble(6), rs.getInt(7),
                                rs.getInt(8), postPrice, localDate, rs.getInt(11), rs.getInt(12), inputStream);

                        postList.add(post);
                    }
                }
                Iterator<Post> iterator = postList.iterator();
    
                while (iterator.hasNext()) {
                    Post post = iterator.next();
                    if (post.getCityID() != cityID) {
                        iterator.remove();
                    }
                }
                
                return postList;
            }
        } catch (SQLException e) {
            System.out.println("Could not get any post when finding by city and price");
            System.out.println(e);
        }

        return null;
    }
    
    public ArrayList<Post> getListPostByCityAndPriceHaveLimit(int cityID, String price,int limit, int postID) {
        String query = "SELECT * FROM `postes` WHERE 1";

        // Prepare the price range variables
        int minPrice = 0;
        int maxPrice = Integer.MAX_VALUE;
        price = price.trim();
        if (price != null && !price.equals("all")) {
            String[] priceRange = price.split("-");
            if (priceRange.length == 2) {
                minPrice = Integer.parseInt(priceRange[0]);
                maxPrice = Integer.parseInt(priceRange[1]);
            }
        }

        ArrayList<Post> postList = new ArrayList<>();
        try {
            PreparedStatement st = conn.prepareStatement(query);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                while (rs.next()) {
                    int postPrice = rs.getInt(9);
                    if (postPrice >= minPrice && postPrice <= maxPrice && rs.getInt(1) != postID) {
                        Date dbDate = rs.getDate(10);
                        LocalDate localDate = dbDate.toLocalDate();
                        Blob blob = getImage(rs.getInt(1));
                        InputStream inputStream = blob.getBinaryStream();

                        Post post = new Post(rs.getInt(1), rs.getString(2), rs.getString(3),
                                rs.getString(4), rs.getString(5), rs.getDouble(6), rs.getInt(7),
                                rs.getInt(8), postPrice, localDate, rs.getInt(11), rs.getInt(12), inputStream);

                        postList.add(post);
                        
                    }
                }
                Iterator<Post> iterator = postList.iterator();
    
                while (iterator.hasNext()) {
                    Post post = iterator.next();
                    if (post.getCityID() != cityID) {
                        iterator.remove();
                    }
                }
                if (postList.size() > 5 ){
                    List<Post> firstFive = postList.subList(0, 5);
                    ArrayList<Post> firstFiveCopy = new ArrayList<>(firstFive);
                    return firstFiveCopy;
                }
                
                return postList;
            }
        } catch (SQLException e) {
            System.out.println("Could not get any post when finding by city and price");
            System.out.println(e);
        }

        return null;
    }

    public ArrayList<Post> getListPostByTitle(String infor) {
        String query = "SELECT * FROM `postes` WHERE 1";

        ArrayList<Post> postList = new ArrayList<>();
        try {
            PreparedStatement st = conn.prepareStatement(query);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                while (rs.next()) {
                    Date dbDate = rs.getDate(10);
                    LocalDate localDate = dbDate.toLocalDate();
                    Blob blob = getImage(rs.getInt(1));
                    InputStream inputStream = blob.getBinaryStream();

                    Post post = new Post(rs.getInt(1), rs.getString(2), rs.getString(3),
                            rs.getString(4), rs.getString(5), rs.getDouble(6), rs.getInt(7),
                            rs.getInt(8), rs.getInt(9), localDate, rs.getInt(11), rs.getInt(12), inputStream);

                    postList.add(post);
                }
                
                Iterator<Post> iterator = postList.iterator();
    
                while (iterator.hasNext()) {
                    Post post = iterator.next();
                    if (!post.getTitle().toLowerCase().contains(infor)) {
                        iterator.remove();
                    }
                }
                return postList;
            }
        } catch (SQLException e) {
            System.out.println("Could not get any post when finding by title");
            System.out.println(e);
        }
        return null;
    }

    public Post getPostByID(int postID) {
        String query = "SELECT * FROM `postes` WHERE PostID = ?";

        try {
            PreparedStatement st = conn.prepareStatement(query);
            st.setInt(1, postID);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Date dbDate = rs.getDate(10);
                LocalDate localDate = dbDate.toLocalDate();
                Blob blob = getImage(rs.getInt(1));
                InputStream inputStream = blob.getBinaryStream();

                Post post = new Post(rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getString(5), rs.getDouble(6), rs.getInt(7),
                        rs.getInt(8), rs.getInt(9), localDate, rs.getInt(11), rs.getInt(12), inputStream);

                return post;
            }
        } catch (SQLException e) {
            System.out.println("Could not get the post with ID: " + postID);
            System.out.println(e);
        }
        return null;
    }

    public ArrayList<Post> getNewestPosts(int limit) {
        String query = "SELECT * FROM `postes` ORDER BY PostDate DESC LIMIT ?";

        ArrayList<Post> postList = new ArrayList<>();
        try {
            PreparedStatement st = conn.prepareStatement(query);
            st.setInt(1, limit);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Date dbDate = rs.getDate(10);
                LocalDate localDate = dbDate.toLocalDate();
                Blob blob = getImage(rs.getInt(1));
                InputStream inputStream = blob.getBinaryStream();

                Post post = new Post(rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getString(5), rs.getDouble(6), rs.getInt(7),
                        rs.getInt(8), rs.getInt(9), localDate, rs.getInt(11), rs.getInt(12), inputStream);

                postList.add(post);
            }
        } catch (SQLException e) {
            System.out.println("Could not get any post");
            System.out.println(e);
        }

        return postList;
    }

    public ArrayList<Post> getPriciestPosts(int limit) {
        String query = "SELECT * FROM `postes` ORDER BY Price DESC LIMIT ?";

        ArrayList<Post> postList = new ArrayList<>();
        try {
            PreparedStatement st = conn.prepareStatement(query);
            st.setInt(1, limit);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Date dbDate = rs.getDate(10);
                LocalDate localDate = dbDate.toLocalDate();
                Blob blob = getImage(rs.getInt(1));
                InputStream inputStream = blob.getBinaryStream();

                Post post = new Post(rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getString(5), rs.getDouble(6), rs.getInt(7),
                        rs.getInt(8), rs.getInt(9), localDate, rs.getInt(11), rs.getInt(12), inputStream);

                postList.add(post);
            }
        } catch (SQLException e) {
            System.out.println("Could not get any post");
            System.out.println(e);
        }

        return postList;
    }

    public ArrayList<Post> getAllListPost() {
        String query = "SELECT * FROM `postes` WHERE 1";

        ArrayList<Post> postList = new ArrayList<>();
        try {
            PreparedStatement st = conn.prepareStatement(query);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Date dbDate = rs.getDate(10);
                LocalDate localDate = dbDate.toLocalDate();
                Blob blob = getImage(rs.getInt(1));
                InputStream inputStream = blob.getBinaryStream();

                Post post = new Post(rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getString(5), rs.getDouble(6), rs.getInt(7),
                        rs.getInt(8), rs.getInt(9), localDate, rs.getInt(11), rs.getInt(12), inputStream);

                postList.add(post);
            }
        } catch (SQLException e) {
            System.out.println("Could not get any post");
            System.out.println(e);
        }

        return postList;
    }

    public boolean deletePostByID(int id) {
        String query = "DELETE FROM `postes` WHERE PostID = ?";
        try {
            PreparedStatement st = conn.prepareStatement(query);
            st.setInt(1, id);
            st.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Could not delete this post");
            System.out.println(e);
            return false;
        }
    }
    
    public void updatePost_forUser(Post p) {
        String sqlforPost = "INSERT INTO `postes`(`Title`, `Description`, `Address`, `PhoneNumber`, `Area`, `NumberOfRoom`, `AvailableRoom`, `Price`, `PostDate`, `UserID`, `CityID`) "
                + "VALUES (?,?,?,?,?,?,?,?,?,?,?)";
        String query = "UPDATE `postes` SET `Title`=?,`Description`=?,"
                + "`Address`=?,`PhoneNumber`=?,`Area`=?,`NumberOfRoom`=?,"
                + "`AvailableRoom`=?,`Price`=?,`PostDate`=?,`CityID`=? "
                + "WHERE PostID = ?";

        java.sql.Date sqlDate = java.sql.Date.valueOf(p.getDate());

        try {
            PreparedStatement st = conn.prepareStatement(query);

            st.setString(1, p.getTitle());
            st.setString(2, p.getDescription());
            st.setString(3, p.getAddress());
            st.setString(4, p.getPhoneNumber());
            st.setDouble(5, p.getArea());
            st.setInt(6, p.getNumberOfRoom());
            st.setInt(7, p.getAvailableRoom());
            st.setInt(8, p.getPrice());
            st.setDate(9, sqlDate);
            st.setInt(10, p.getCityID());
            st.setInt(11, p.getPostID());

            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Could not update post for user");
            System.out.println(e);
        }
    }

    public void updateImage_forUser(Post p) {
        String query = "UPDATE `image` SET `Image`=? WHERE PostID = ?";
        try {
            PreparedStatement st = conn.prepareStatement(query);
            st.setBlob(1, p.getUrl());
            st.setInt(2, p.getPostID());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Could not update image for user");
            System.out.println(e);
        }
    }
}
