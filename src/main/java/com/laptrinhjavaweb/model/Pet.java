package com.laptrinhjavaweb.model;

import java.sql.Timestamp;
import java.util.Base64;

public class Pet extends AbstractClass<Pet>{
    private int petId;
    private String name;
    private double price;
    private String type;
    private String breed;
    private int age;
    private String gender;
    private String description;
    private byte[] image;
    private String addedBy;
    private Timestamp createdAt;
    private String base64Image;


    // Getters and Setters
    
    public int getPetId() {
        return petId;
    }

    public void setPetId(int petId) {
        this.petId = petId;
    }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public double getPrice() {return price;}
    public void setPrice(double price) {this.price = price;}

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public String getBreed() { return breed; }
    public void setBreed(String breed) { this.breed = breed; }

    public int getAge() { return age; }
    public void setAge(int age) { this.age = age; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getAddedBy() { return addedBy; }
    public void setAddedBy(String addedBy) { this.addedBy = addedBy; }

    public byte[] getImage() { return image; }
    public void setImage(byte[] image) { this.image = image; }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    public String getBase64Image() {
        return base64Image;
    }

    public void setBase64Image(String base64Image) {
        this.base64Image = base64Image;
    }
    
    public String convertImageToBase64() {
        if (image != null && image.length > 0) {
            return Base64.getEncoder().encodeToString(image);
        }
        return null;
    }
}
