package com.Bar.blog.models.enums;
import org.springframework.security.core.GrantedAuthority;

public enum Role implements GrantedAuthority {
    ROLE_BARMEN, ROLE_PROVIDER, ROLE_VISITOR, ROLE_ADMIN;
    @Override
    public String getAuthority() {
        return name();
    }
}