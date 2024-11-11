package com.unla.tienda_service.dtos;

import io.spring.guides.gs_producing_web_service.ProductParseErrorSoap;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductBulkUploadResponse {
    private String status;
    private String message;
    private List<ProductParseErrorSoap> errors = new ArrayList<>();

    // Constructor adicional para mantener compatibilidad con código existente
    public ProductBulkUploadResponse(String status, String message) {
        this.status = status;
        this.message = message;
        this.errors = new ArrayList<>();
    }
}
