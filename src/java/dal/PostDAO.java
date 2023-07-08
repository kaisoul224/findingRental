/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Blob;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import model.Post;
import model.User;
import org.apache.catalina.connector.Response;

/**
 *
 * @author Quoc Anh
 */
public class PostDAO extends DBconnector{
    public void insertPost_forUser(Post u) {
        String sqlforPost = "INSERT INTO `postes`(`Title`, `Description`, `Address`, `PhoneNumber`, `Area`, `NumberOfRoom`, `AvailableRoom`, `PostDate`, `UserID`)"
                + "VALUES (?,?,?,?,?,?,?,?,?)";
        
        java.sql.Date sqlDate = java.sql.Date.valueOf(u.getDate());

        try {
            PreparedStatement st = conn.prepareStatement(sqlforPost);

            st.setString(1, u.getTitle());
            st.setString(2, u.getDescription());
            st.setString(3, u.getAddress());
            st.setString(4, u.getPhoneNumber());
            st.setDouble(5, u.getArea());
            st.setInt(6, u.getNumberOfRoom());
            st.setInt(7, u.getAvailableRoom());
            st.setDate(8, sqlDate);
            st.setInt(9, u.getUserID());
            
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

    public Blob getImage(int PostID) {
        String query = "SELECT MAX(PostID) FROM postes";
        try {
            PreparedStatement st = conn.prepareStatement(query);
            st.setInt(1, PostID);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Blob blob = rs.getBlob("image");
                return blob;
               
            }
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Could not add image for user");
            System.out.println(e);
        }
        return null;
    }
    

}
