package com.p2pbank.backend.config;


import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.domain.AuditorAware;

import java.util.Optional;

@Configuration
public class SecurityAuditorAware {

    @Bean
    public AuditorAware<String> auditorProvider() {
        return () -> {
            // 실제로는 로그인한 사용자 ID 가져와야 함 (ex: Spring Security)
            return Optional.of("system"); // 일단은 임시로 "system"
        };
    }
}
