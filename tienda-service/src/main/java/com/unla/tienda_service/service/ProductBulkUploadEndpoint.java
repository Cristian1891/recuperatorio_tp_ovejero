package com.unla.tienda_service.service;

import com.unla.tienda_service.converter.ProductBulkUploadConverter;
import com.unla.tienda_service.dtos.ProductBulkUploadResponse;
import io.spring.guides.gs_producing_web_service.ProductBulkUploadRequest;
import io.spring.guides.gs_producing_web_service.ProductParseErrorSoap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ws.server.endpoint.annotation.Endpoint;
import org.springframework.ws.server.endpoint.annotation.PayloadRoot;
import org.springframework.ws.server.endpoint.annotation.RequestPayload;
import org.springframework.ws.server.endpoint.annotation.ResponsePayload;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.List;

@Endpoint
public class ProductBulkUploadEndpoint {

    private final TiendaProductService tiendaProductService;
    private final ProductBulkUploadConverter productConverter;
    private static final String NAMESPACE_URI = "http://spring.io/guides/gs-producing-web-service";


    @Autowired
    public ProductBulkUploadEndpoint(TiendaProductService tiendaProductService,
                                     ProductBulkUploadConverter productConverter) {
        this.tiendaProductService = tiendaProductService;
        this.productConverter = productConverter;
    }

    @PayloadRoot(namespace = NAMESPACE_URI, localPart = "ProductBulkUploadRequest")
    @ResponsePayload
    public io.spring.guides.gs_producing_web_service.ProductBulkUploadResponse handleProductBulkRequest(
            @RequestPayload io.spring.guides.gs_producing_web_service.ProductBulkUploadRequest request) throws Exception {

        byte[] csvBytes = request.getCsvData();
        InputStream csvInputStream = new ByteArrayInputStream(csvBytes);

        TiendaProductService.ParseResult result = tiendaProductService.parseCsvFile(csvInputStream);

        io.spring.guides.gs_producing_web_service.ProductBulkUploadResponse response =
                new io.spring.guides.gs_producing_web_service.ProductBulkUploadResponse();

        // Agregar productos creados exitosamente
        result.getSuccessfulProducts().forEach(product -> {
            response.getCreatedProducts().add(productConverter.convertToSoapProduct(product));
        });

        // Agregar errores
        result.getErrors().forEach(error -> {
            response.getErrors().add(productConverter.convertToSoapError(error));
        });

        return response;
    }
}
