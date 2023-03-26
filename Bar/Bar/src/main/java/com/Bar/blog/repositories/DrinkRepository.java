package com.Bar.blog.repositories;
import com.Bar.blog.models.Component;
import com.Bar.blog.models.Drink;
import org.springframework.data.jpa.repository.JpaRepository;

import javax.transaction.Transactional;
import java.util.List;

public interface DrinkRepository extends JpaRepository<Drink, Long> {
    Drink findByTitle(String title);
    List<Drink> findByAvailable(boolean available);
    @Transactional
    void deleteByTitle(String title);
}