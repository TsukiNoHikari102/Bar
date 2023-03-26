package com.Bar.blog.models;
import lombok.Data;
import javax.persistence.*;
import java.util.HashMap;
import java.util.Map;
@Entity
@Table(name = "drinks")
@Data
public class Drink {
    @Id
    @Column(name = "title")
    private String title;
    @Column(name = "description")
    private String description;
    @Column(name = "price")
    private int price;
    @Column(name = "available")
    private boolean available;
    @OneToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "drink")
    private Image image;
    @ElementCollection(fetch = FetchType.LAZY)
    @CollectionTable(name = "drink_components", joinColumns = @JoinColumn(name = "drink_title"))
    @MapKeyColumn(name = "key")
    @Column(name = "value")
    private Map<Component, Integer> components = new HashMap<>();
    public void addComponentToDrink(Component component, int count) {
        components.put(component, count);
    }
}