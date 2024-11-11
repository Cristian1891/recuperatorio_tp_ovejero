package com.unla.tienda_service.converter;

import com.unla.tienda_service.dtos.ProductBulkDTO;
import com.unla.tienda_service.dtos.ProductParseError;
import io.spring.guides.gs_producing_web_service.ProductParseErrorSoap;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class ProductBulkUploadConverter {


    public io.spring.guides.gs_producing_web_service.ProductBulkDTO convertToSoapProduct(ProductBulkDTO dto) {
        io.spring.guides.gs_producing_web_service.ProductBulkDTO soapDto =
                new io.spring.guides.gs_producing_web_service.ProductBulkDTO();

        soapDto.setCodigo(dto.getCodigo());
        soapDto.setNombre(dto.getNombre());
        soapDto.setColor(dto.getColor());
        soapDto.setTalle(dto.getTalle());
        soapDto.setFoto(dto.getFoto());

        // Convertir tiendas asignadas
        io.spring.guides.gs_producing_web_service.TiendasAsignadasType tiendasType =
                new io.spring.guides.gs_producing_web_service.TiendasAsignadasType();

        dto.getTiendasAsignadas().forEach(tienda ->
                tiendasType.getTienda().add(tienda.getCodigo()));

        soapDto.setTiendasAsignadas(tiendasType);
        return soapDto;
    }

    public io.spring.guides.gs_producing_web_service.ProductParseErrorSoap convertToSoapError(ProductParseError error) {
        io.spring.guides.gs_producing_web_service.ProductParseErrorSoap soapError =
                new io.spring.guides.gs_producing_web_service.ProductParseErrorSoap();

        soapError.setLineNumber(error.getLineNumber());
        soapError.setCodigo(error.getCodigo());
        soapError.setColor(error.getColor());
        soapError.setTalle(error.getTalle());
        soapError.setErrorMessage(error.getErrorMessage());

        return soapError;
    }

    // Mantener el método existente convertProductParseErrorListToSoap
    public List<ProductParseErrorSoap> convertProductParseErrorListToSoap(List<ProductParseError> errors) {
        return errors.stream()
                .map(this::convertToSoapError)
                .collect(Collectors.toList());
    }



}
