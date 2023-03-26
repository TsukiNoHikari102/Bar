package com.Bar.blog.repositories;
import com.Bar.blog.models.User;
import org.springframework.data.jpa.repository.JpaRepository;

import javax.transaction.Transactional;

public interface UserRepository extends JpaRepository<User, Long> {
    User findByEmail(String email);
}