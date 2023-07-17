/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Quoc Anh
 */
import java.util.HashMap;

public class City {

    private HashMap<String, Integer> cityIndexMap;

    public City() {
        cityIndexMap = new HashMap<>();
        cityIndexMap.put("Can Tho", 1);
        cityIndexMap.put("TP Ho Chi Minh", 2);
        cityIndexMap.put("Ha Noi", 3);
        cityIndexMap.put("Hai Phong", 4);
        cityIndexMap.put("Da Nang", 5);
        cityIndexMap.put("An Giang", 6);
        cityIndexMap.put("Binh Duong", 7);
        cityIndexMap.put("Ba Ria - Vung Tau", 8);
        cityIndexMap.put("Bac Giang", 9);
        cityIndexMap.put("Bac Kan", 10);
        cityIndexMap.put("Bac Lieu", 11);
        cityIndexMap.put("Bac Ninh", 12);
        cityIndexMap.put("Ben Tre", 13);
        cityIndexMap.put("Binh Phuoc", 14);
        cityIndexMap.put("Binh Thuận", 15);
        cityIndexMap.put("Binh Dinh", 16);
        cityIndexMap.put("Ca Mau", 17);
        cityIndexMap.put("Cao Bang", 18);
        cityIndexMap.put("Gia Lai", 19);
        cityIndexMap.put("Ha Giang", 20);
        cityIndexMap.put("Ha Nam", 21);
        cityIndexMap.put("Ha Tinh", 22);
        cityIndexMap.put("Hue", 23);
        cityIndexMap.put("Hai Duong", 24);
        cityIndexMap.put("Hau Giang", 25);
        cityIndexMap.put("Hoa Binh", 26);
        cityIndexMap.put("Hung Yen", 27);
        cityIndexMap.put("Khanh Hoa", 28);
        cityIndexMap.put("Kien Giang", 29);
        cityIndexMap.put("Kon Tum", 30);
        cityIndexMap.put("Lai Chau", 31);
        cityIndexMap.put("Lam Dong", 32);
        cityIndexMap.put("Lang Son", 33);
        cityIndexMap.put("Lao Cai", 34);
        cityIndexMap.put("Long An", 35);
        cityIndexMap.put("Nam Dinh", 36);
        cityIndexMap.put("Nghe An", 37);
        cityIndexMap.put("Ninh Binh", 38);
        cityIndexMap.put("Ninh Thuan", 39);
        cityIndexMap.put("Phu Tho", 40);
        cityIndexMap.put("Phu Yen", 41);
        cityIndexMap.put("Quang Binh", 42);
        cityIndexMap.put("Quang Nam", 43);
        cityIndexMap.put("Quang Ngai", 44);
        cityIndexMap.put("Quang Ninh", 45);
        cityIndexMap.put("Quang Tri", 46);
        cityIndexMap.put("Soc Trang", 47);
        cityIndexMap.put("Son La", 48);
        cityIndexMap.put("Tay Ninh", 49);
        cityIndexMap.put("Thai Binh", 50);
        cityIndexMap.put("Thai Nguyen", 51);
        cityIndexMap.put("Thanh Hoa", 52);
        cityIndexMap.put("Tien Giang", 53);
        cityIndexMap.put("Tra Vinh", 54);
        cityIndexMap.put("Tuyen Quang", 55);
        cityIndexMap.put("Vinh Long", 56);
        cityIndexMap.put("Vinh Phuc", 57);
        cityIndexMap.put("Yen Bai", 58);
        cityIndexMap.put("Dak Lak", 59);
        cityIndexMap.put("Dak Nong", 60);
        cityIndexMap.put("Dien Bien", 61);
        cityIndexMap.put("Dong Nai", 62);
        cityIndexMap.put("Dong Thap", 63);
    }

    public int getID(String city) {
        return cityIndexMap.getOrDefault(city, -1);
    }

    public String getCity(int id) {
        for (String key : cityIndexMap.keySet()) {
            if (cityIndexMap.get(key) == id) {
                return key;
            }
        }
        return null;
    }

}
