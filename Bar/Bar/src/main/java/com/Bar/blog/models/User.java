package com.Bar.blog.models;
import com.Bar.blog.models.enums.Role;
import lombok.Data;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import javax.persistence.*;
import java.util.*;
@Entity
@Table(name = "users")
@Data
public class User implements UserDetails {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;
    @Column(name = "email", unique = true)
    private String email;
    @Column(name = "name")
    private String name;
    @Column(name = "active")
    private boolean active;
    @Column(name = "password", length = 1000)
    private String password;
    @ElementCollection(targetClass = Role.class, fetch = FetchType.EAGER)
    @CollectionTable(name = "user_role", joinColumns = @JoinColumn(name = "user_id"))
    @Enumerated(EnumType.STRING)
    private Set<Role> roles = new HashSet<>();
    public boolean isAdmin() {
        return roles.contains(Role.ROLE_ADMIN);
    }
    public boolean isBarmen() {
        return roles.contains(Role.ROLE_BARMEN);
    }
    public boolean isProvider() {
        return roles.contains(Role.ROLE_PROVIDER);
    }
    public boolean isVisitor() {
        return roles.contains(Role.ROLE_VISITOR);
    }
    public String stringRole() {
        Role role = roles.iterator().next();
        if (role == Role.ROLE_ADMIN)
            return "Админ";
        else if (role == Role.ROLE_BARMEN)
            return "Бармен";
        else if (role == Role.ROLE_PROVIDER)
            return "Поставщик";
        else
            return "Посетитель";
    }
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return roles;
    }
    @Override
    public String getUsername() {
        return email;
    }
    @Override
    public boolean isAccountNonExpired() {
        return true;
    }
    @Override
    public boolean isAccountNonLocked() {
        return true;
    }
    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }
    @Override
    public boolean isEnabled() {
        return active;
    }
}