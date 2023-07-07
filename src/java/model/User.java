/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 *
 * @author Quoc Anh
 */
public final class User {

    private int userId;
    private String fullName;
    private String userName;
    private String password;
    private String userType;
    private String phoneNumber;
    private String email;

    public User(int userId, String fullName, String userName, String password, String userType, String phoneNumber, String email) {
        this.userId = userId;
        this.fullName = fullName;
        this.userName = userName;
        this.password = str2md5(password);
        this.userType = userType;
        this.phoneNumber = phoneNumber;
        this.email = email;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
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

}
