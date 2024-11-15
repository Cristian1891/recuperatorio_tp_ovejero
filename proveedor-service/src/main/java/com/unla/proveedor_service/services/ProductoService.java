package com.unla.proveedor_service.services;

import com.unla.proveedor_service.dtos.ProductRequest;
import com.unla.proveedor_service.dtos.ProductResponse;
import com.unla.proveedor_service.models.Product;
import com.unla.proveedor_service.repositories.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.Optional;

@Service
public class ProductoService {

    private final ProductRepository productRepository;

    private final OrdersPausedProcessingService ordersPausedProcessingService;

    private final OrderProcessingService orderProcessingService;

    public ProductoService(ProductRepository productRepository, OrdersPausedProcessingService ordersPausedProcessingService, OrderProcessingService orderProcessingService) {
        this.productRepository = productRepository;
        this.ordersPausedProcessingService = ordersPausedProcessingService;
        this.orderProcessingService = orderProcessingService;
    }

    @Autowired


    public List<ProductResponse> getAllProducts() {
        var products = productRepository.findAll();
        return products.stream().map(this::mapToProductResponse).toList();
    }

    public ProductResponse getById(Long id) {
        Optional<Product> product = productRepository.findById(id);
        return mapToProductResponse(product.get());
    }


    public ProductResponse findByCodigo(String codigo) {
        return mapToProductResponse(productRepository.findByCodigo(codigo).get());
    }

    public ProductResponse updateStock(Long id, Integer stock){
        Product producto=productRepository.findById(id).orElseThrow(()-> new ResponseStatusException(HttpStatus.NOT_FOUND, "Producto no encontrado con ID: " + id));
        producto.setStock(stock);
        Integer a=ordersPausedProcessingService.enviarProductosActualizados(producto);
        return mapToProductResponse(productRepository.save(producto));
    }

    public ProductResponse createProduct(ProductRequest productRequest){
        Product producto=new Product(productRequest.getNombre(),productRequest.getCodigo(),productRequest.getFoto(),productRequest.getColor(),productRequest.getTalle(),productRequest.getStock());
        ProductResponse productResponse=mapToProductResponse(productRepository.save(producto));
        orderProcessingService.sendProductoNovedad(productResponse);
        return productResponse;
    }




    private ProductResponse mapToProductResponse(Product product) {
        return ProductResponse.builder()
                .id(product.getId())
                .nombre(product.getNombre())
                .codigo(product.getCodigo())
                .foto(product.getFoto())
                .talle(product.getTalle())
                .color(product.getColor())
                .stock(product.getStock())
                .build();
    }

}

