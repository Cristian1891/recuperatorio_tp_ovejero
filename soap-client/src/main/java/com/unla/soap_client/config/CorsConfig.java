package com.unla.soap_client.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;

@Configuration
public class CorsConfig {

    @Bean
    public CorsFilter corsFilter() {
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        CorsConfiguration config = new CorsConfiguration();

        // Permite cualquier origen en desarrollo - en producción deberías especificar los orígenes permitidos
        config.addAllowedOrigin("http://localhost:5173"); // Tu origen de React

        // Permite las credenciales
        config.setAllowCredentials(true);

        // Permite los métodos HTTP específicos
        config.addAllowedMethod("GET");
        config.addAllowedMethod("POST");
        config.addAllowedMethod("PUT");
        config.addAllowedMethod("DELETE");
        config.addAllowedMethod("OPTIONS");

        // Permite todos los headers
        config.addAllowedHeader("*");

        // Aplica esta configuración a todas las rutas
        source.registerCorsConfiguration("/**", config);

        return new CorsFilter(source);
    }
}
