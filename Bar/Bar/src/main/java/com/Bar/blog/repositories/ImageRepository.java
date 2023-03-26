package com.Bar.blog.repositories;
import com.Bar.blog.models.Image;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ImageRepository extends JpaRepository<Image, Long> {}