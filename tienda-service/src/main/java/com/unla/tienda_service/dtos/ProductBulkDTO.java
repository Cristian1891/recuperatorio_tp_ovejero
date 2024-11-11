package com.unla.tienda_service.dtos;


import com.unla.tienda_service.model.Tienda;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductBulkDTO {
    private String codigo;
    private String nombre;
    private String color;
    private String talle;
    private String foto;
    private List<Tienda> tiendasAsignadas;
}
