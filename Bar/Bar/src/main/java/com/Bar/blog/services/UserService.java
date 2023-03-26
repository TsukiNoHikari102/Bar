package com.Bar.blog.services;
import com.Bar.blog.models.User;
import com.Bar.blog.models.enums.Role;
import com.Bar.blog.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import java.util.*;
import java.security.Principal;
import java.util.stream.Collectors;

@Service
@Slf4j
@RequiredArgsConstructor
public class UserService implements CommandLineRunner {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    public boolean createUser(User user) {
        if (userRepository.findByEmail(user.getEmail()) != null){
            return false;
        }
        else{
            user.getRoles().add(Role.ROLE_VISITOR);
        }
        user.setActive(true);
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        log.info("Saving new User: {}", user);
        userRepository.save(user);
        return true;
    }
    public List<User> list() {
        var listUser = userRepository.findAll();
        if (listUser.size() == 1){
            return null;
        }
        listUser.remove(userRepository.findByEmail("admin@mail.ru"));
        return listUser;
    }
    public void changeUserRoles(User user, Map<String, String> form) {
        Set<String> roles = Arrays.stream(Role.values())
                .map(Role::name)
                .collect(Collectors.toSet());
        user.getRoles().clear();
        for (String key : form.values()) {//.keySet()
            if (roles.contains(key)) {
                user.getRoles().add(Role.valueOf(key));
            }
        }
        userRepository.save(user);
    }
    public void deleteUser(Long id) {
        userRepository.deleteById(id);
        log.info("Delete user.");
    }
    @Override
    public void run(String... args) throws Exception
    {
        if (userRepository.findByEmail("admin@mail.ru") == null){
            User admin = new User();
            admin.setEmail("admin@mail.ru");
            admin.setActive(true);
            admin.setName("admin");
            admin.setPassword(passwordEncoder.encode("admin"));
            admin.getRoles().add(Role.ROLE_ADMIN);
            userRepository.save(admin);
        }
    }
    public User getUserByPrincipal(Principal principal) {
        return userRepository.findByEmail(principal.getName());
    }
}