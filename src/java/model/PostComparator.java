/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Quoc Anh
 */
import java.util.Comparator;


public class PostComparator implements Comparator<Post> {
    @Override
    public int compare(Post post1, Post post2) {
        // Compare based on the price field
        return Integer.compare(post1.getPrice(), post2.getPrice());
    }
}


