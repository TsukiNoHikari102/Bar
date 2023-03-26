package com.Bar.blog.models;
import lombok.Data;

import javax.persistence.*;
@Entity
@Table(name = "components")
@Data
public class Component {
    @Id
    @Column(name = "title")
    private String title;
    @Column(name = "count")
    private int count;
    @Column(name = "request")
    private boolean request;
    public Component(String title) {
        this.title = title;
    }
    public Component() {
        super();
    }
}