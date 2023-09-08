/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.io.InputStream;
import java.time.LocalDate;

/**
 *
 * @author Quoc Anh
 */
public class Post {
    private int postID;
    private String title;
    private String description;
    private String address;
    private String phoneNumber;
    private double area;
    private int numberOfRoom;
    private int availableRoom;
    private int price;
    private LocalDate date;
    private int userID;
    private int cityID;
    private InputStream url;

    public Post() {
    }
    
    public Post(int postID, String title, String description, String address, String phoneNumber, double area, int numberOfRoom, int availableRoom, int price, LocalDate date, int userID, int cityID, InputStream url) {
        this.postID = postID;
        this.title = title;
        this.description = description;
        this.address = address;
        this.phoneNumber = phoneNumber;
        this.area = area;
        this.numberOfRoom = numberOfRoom;
        this.availableRoom = availableRoom;
        this.price = price;
        this.date = date;
        this.userID = userID;
        this.cityID = cityID;
        this.url = url;
    }
    
    
    
    // Override equals() method
    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null || getClass() != obj.getClass()) {
            return false;
        }
        Post otherPost = (Post) obj;
        return this.postID == otherPost.postID;
    }
    


    public int getPostID() {
        return postID;
    }

    public void setPostID(int postID) {
        this.postID = postID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public double getArea() {
        return area;
    }

    public void setArea(double area) {
        this.area = area;
    }

    public int getNumberOfRoom() {
        return numberOfRoom;
    }

    public void setNumberOfRoom(int numberOfRoom) {
        this.numberOfRoom = numberOfRoom;
    }

    public int getAvailableRoom() {
        return availableRoom;
    }

    public void setAvailableRoom(int availableRoom) {
        this.availableRoom = availableRoom;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public LocalDate getDate() {
        return date;
    }
    
    public String getDateString() {
        return date.toString();
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getCityID() {
        return cityID;
    }

    public void setCityID(int cityID) {
        this.cityID = cityID;
    }
    

    public InputStream getUrl() {
        return url;
    }

    public void setUrl(InputStream url) {
        this.url = url;
    }

    
    
}
