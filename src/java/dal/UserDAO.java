/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;

/**
 *
 * @author Quoc Anh
 */
public class UserDAO extends DBconnector {

    public ArrayList<User> getAllList() {
        ArrayList<User> userList = new ArrayList<>();
        String query = "SELECT * FROM `users`";
        try {
            Statement stm = conn.createStatement();
            ResultSet rs = stm.executeQuery(query);
            while (rs.next()) {
                User user = new User(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5),rs.getString(6),rs.getString(7));
                userList.add(user);
            }
        } catch (SQLException ex) {
            System.out.println("Could not get all list user");
            Logger.getLogger(DBconnector.class.getName()).log(Level.SEVERE, null, ex);
        }
        return userList;
    }

    
    
    public void insert_forAdmin(User u) {
        String sql = "INSERT INTO `users`(`fullName`, `Username`, `Password`, `UserType`, `PhoneNumber`, `Email`) VALUES (?,?,?,?,?,?)";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, u.getFullName());
            st.setString(2, u.getUserName());
            st.setString(3, u.getPassword());
            st.setString(4, u.getUserType());
            st.setString(5, u.getPhoneNumber());
            st.setString(6, u.getEmail());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Could not add user for admin");
            System.out.println(e);
        }
    }
  
    public void insert_forUser(User u) {
        String sql = "INSERT INTO `users`(`fullName`, `Username`, `Password`, `UserType`, `PhoneNumber`, `Email`) VALUES (?,?,?,?,?,?)";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, u.getFullName());
            st.setString(2, u.getUserName());
            st.setString(3, u.getPassword());
            st.setString(4, u.getUserType());
            st.setString(5, u.getPhoneNumber());
            st.setString(6, u.getEmail());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Could not add user for admin");
            System.out.println(e);
        }
    }
    
     public User getUserById(int id) {
        String query = "SELECT * FROM `users` where userID = ?";
        try {
            PreparedStatement st = conn.prepareStatement(query);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                User us = new User(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7));
                return us;
            }
        } catch (SQLException ex) {
            System.out.println("Could ot get user by this id");
            Logger.getLogger(DBconnector.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
     
     public User getUserByUsername(String username) {
        String query = "SELECT * FROM `users` WHERE Username = ?";
        try {
            PreparedStatement st = conn.prepareStatement(query);
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                User us = new User(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7));
                return us;
            }
        } catch (SQLException ex) {
            System.out.println("Could not get user by this username");
            Logger.getLogger(DBconnector.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
     
     public boolean delete(int id){
         String sql = "DELETE FROM `users` WHERE userID =?";
         
         try{
             PreparedStatement st = conn.prepareStatement(sql);
             st.setInt(1, id);
             st.executeUpdate();
             return true;
         }catch(SQLException e){
             System.out.println("Could not delete this user");
            System.out.println(e);
            return false;
         }
         
     }
     
    public void update_forAdmin(User uNew) {
        String query = "UPDATE `users` SET "
                + ",`fullName`=?"
                + ",`Username`=?"
                + ",`Password`=?"
                + ",`UserType`=?"
                + ",`PhoneNumber`=?"
                + ",`Email`=? "
                + "WHERE userID = ?";

        try {
            PreparedStatement st = conn.prepareStatement(query);
            st.setString(1, uNew.getFullName());
            st.setString(2, uNew.getUserName());
            st.setString(3, uNew.getPassword());
            st.setString(4, uNew.getUserType());
            st.setString(5, uNew.getPhoneNumber());
            st.setString(6, uNew.getEmail());
            st.setInt(6, uNew.getUserId());

            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Could not Update this user");
            System.out.println(e);
        }

    }
    
    public void update_forUser(User uNew) {
        String query = "UPDATE `users` SET "
                + "`fullName`=?,"
                + "`Username`=?,"
                + "`PhoneNumber`=?,"
                + "`Email`=? "
                + "WHERE userID = ?";

        try {
            PreparedStatement st = conn.prepareStatement(query);
            st.setString(1, uNew.getFullName());
            st.setString(2, uNew.getUserName());
            st.setString(3, uNew.getPhoneNumber());
            st.setString(4, uNew.getEmail());
            st.setInt(5, uNew.getUserId());

            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Could not Update this user");
            System.out.println(e);
        }

    }
     
    public User check(String username, String password) {
        String query = "SELECT * FROM `users` WHERE Username = ? and Password = ?";
        try {
            PreparedStatement st = conn.prepareStatement(query);
            st.setString(1, username);
            st.setString(2, str2md5(password));
            ResultSet u = st.executeQuery();
            if (u.next()) {
                User user = new User(u.getInt(1), u.getString(2), u.getString(3), u.getString(4), u.getString(5), u.getString(6), u.getString(7));
                return user;
            }

        } catch (SQLException e) {
            System.out.println("Could not find this user");
            System.out.println(e);
        }
        return null;
    }
    
    
    private final char[] HEX_DIGITS = { '0', '1', '2', '3', '4',
            '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };

    private String str2md5(String str) {
        try {
            MessageDigest algorithm = MessageDigest.getInstance("MD5");
            algorithm.reset();
            algorithm.update(str.getBytes());
            byte[] bytes = algorithm.digest();
            StringBuilder hexString = new StringBuilder();
            for (byte b : bytes) {
                hexString.append(HEX_DIGITS[b >> 4 & 0xf]);
                hexString.append(HEX_DIGITS[b & 0xf]);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }
    
    public void changePassWord(String username, String newPassword) {
        String query = "UPDATE `users` SET "
                + "`Password`=?"
                + "WHERE Username = ?";
        try {
            PreparedStatement st = conn.prepareStatement(query);
            st.setString(1, str2md5(newPassword));
            st.setString(2, username);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
            System.out.println("Could not change Password");
        }
    }
    

}
