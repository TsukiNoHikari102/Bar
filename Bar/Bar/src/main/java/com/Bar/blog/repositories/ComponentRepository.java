package com.Bar.blog.repositories;
import com.Bar.blog.models.Component;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
public interface ComponentRepository extends JpaRepository<Component, Long> {
    Component findByTitle(String title);
    List<Component> findByRequest(boolean request);
}