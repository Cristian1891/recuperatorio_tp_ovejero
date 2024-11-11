package com.unla.tienda_service.dtos;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductParseError {
    private int lineNumber;
    private String codigo;
    private String color;
    private String talle;
    private String errorMessage;
}
