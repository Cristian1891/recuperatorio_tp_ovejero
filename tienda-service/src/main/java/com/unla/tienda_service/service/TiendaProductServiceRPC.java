package com.unla.tienda_service.service;

import com.productoservice.grpc.GetProductRequest;
import com.productoservice.grpc.GetProductResponse;
import com.productoservice.grpc.ProductServiceGrpc;
import com.unla.tienda_service.model.Tienda;
import com.unla.tienda_service.model.TiendaProduct;
import com.unla.tienda_service.repository.TiendaProductRepository;
import com.tiendaservice.grpc.*;
import com.unla.tienda_service.repository.TiendaRepository;
import io.grpc.Status;
import io.grpc.stub.StreamObserver;
import jakarta.persistence.metamodel.EmbeddableType;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import net.devh.boot.grpc.server.service.GrpcService;


import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;


@GrpcService
@RequiredArgsConstructor
public class TiendaProductServiceRPC extends TiendaProductServiceGrpc.TiendaProductServiceImplBase {

    private final TiendaProductRepository tiendaProductRepository;
    private final TiendaRepository tiendaRepository;
    private final ProductServiceGrpc.ProductServiceBlockingStub productServiceStub;


    @Override
    @Transactional
    public void addTiendaProduct(AddTiendaProductRequest request, StreamObserver<AddTiendaProductResponse> responseObserver) {

        System.out.println(request);
        TiendaProduct tiendaProduct = TiendaProduct.builder()
                .tiendaId(request.getTiendaId())
                .productId(request.getProductId())
                .stock(request.getStock())
                .build();

        tiendaProductRepository.save(tiendaProduct);

        AddTiendaProductResponse response = AddTiendaProductResponse.newBuilder()
                .setMessage("Producto agregado a la tienda")
                .setSuccess(true)
                .build();

        responseObserver.onNext(response);
        responseObserver.onCompleted();
    }

    @Override
    public void getTiendaProduct(GetTiendaProductRequest request, StreamObserver<GetTiendaProductResponse> responseObserver) {
        TiendaProduct tiendaProduct = tiendaProductRepository.findById(request.getId())
                .orElseThrow(() -> new RuntimeException("TiendaProduct no encontrado"));

        GetTiendaProductResponse response = GetTiendaProductResponse.newBuilder()
                .setTiendaId(tiendaProduct.getTiendaId())
                .setProductId(tiendaProduct.getProductId())
                .setStock(tiendaProduct.getStock())
                .build();

        responseObserver.onNext(response);
        responseObserver.onCompleted();
    }

    @Override
    public void deleteTiendaProduct(DeleteTiendaProductRequest request, StreamObserver<DeleteTiendaProductResponse> responseObserver) {
        tiendaProductRepository.deleteById(request.getId());

        DeleteTiendaProductResponse response = DeleteTiendaProductResponse.newBuilder()
                .setMessage("TiendaProduct eliminado")
                .setSuccess(true)
                .build();

        responseObserver.onNext(response);
        responseObserver.onCompleted();
    }


    @Override
    @Transactional
    public void obtenerProductosPorTienda(TiendaProductsRequest request, StreamObserver<TiendaProductsResponse> responseObserver) {
        try {
            long tiendaId = request.getTiendaId();

            // Validación del ID de tienda
            if (tiendaId <= 0) {
                responseObserver.onError(Status.INVALID_ARGUMENT
                        .withDescription("El ID de tienda debe ser mayor que 0")
                        .asRuntimeException());
                return;
            }

            // Obtener productos y validar si la lista está vacía
            List<TiendaProduct> productosEnTienda = tiendaProductRepository.findByTiendaId(tiendaId);
            if (productosEnTienda == null || productosEnTienda.isEmpty()) {
                TiendaProductsResponse response = TiendaProductsResponse.newBuilder()
                        .build();
                responseObserver.onNext(response);
                responseObserver.onCompleted();
                System.out.println("No se encontraron productos para la tienda ID: " + tiendaId);
                return;
            }

            TiendaProductsResponse.Builder responseBuilder = TiendaProductsResponse.newBuilder();
            boolean algunProductoValido = false;

            for (TiendaProduct tiendaProduct : productosEnTienda) {
                try {
                    // Validar que el producto no sea null
                    if (tiendaProduct == null || tiendaProduct.getProductId() <= 0) {
                        System.err.println("Producto inválido encontrado en la tienda ID: " + tiendaId);
                        continue;
                    }

                    GetProductRequest productRequest = GetProductRequest.newBuilder()
                            .setId(tiendaProduct.getProductId())
                            .build();

                    // Llamada al servicio de productos con manejo de timeout
                    GetProductResponse productResponse;
                    try {
                        productResponse = productServiceStub.getProduct(productRequest);

                        // Validar que la respuesta del producto no sea null
                        if (productResponse == null) {
                            System.err.println("Respuesta nula del servicio de productos para el producto ID: " + tiendaProduct.getProductId());
                            continue;
                        }

                        // Validar campos obligatorios
                        if (productResponse.getNombre().isEmpty() || productResponse.getCodigo().isEmpty()) {
                            System.err.println("Datos incompletos para el producto ID: " + tiendaProduct.getProductId());
                            continue;
                        }

                        TiendaProductResponse tiendaProductResponse = TiendaProductResponse.newBuilder()
                                .setTiendaId(tiendaProduct.getTiendaId())
                                .setProductoId(tiendaProduct.getProductId())
                                .setNombre(productResponse.getNombre())
                                .setCodigo(productResponse.getCodigo())
                                .setFoto(productResponse.getFoto())
                                .setColor(productResponse.getColor())
                                .setTalle(productResponse.getTalle())
                                .setStock(tiendaProduct.getStock())
                                .build();

                        responseBuilder.addProductos(tiendaProductResponse);
                        algunProductoValido = true;

                    } catch (Exception e) {
                        System.err.println("Error al obtener datos del producto " + tiendaProduct.getProductId() +
                                " de la tienda " + tiendaId + ": " + e.getMessage());
                        // Continuar con el siguiente producto
                        continue;
                    }

                } catch (Exception e) {
                    System.err.println("Error procesando producto en tienda " + tiendaId + ": " + e.getMessage());
                    // Continuar con el siguiente producto
                    continue;
                }
            }

            // Verificar si se encontró al menos un producto válido
            if (!algunProductoValido) {
                System.out.println("No se encontraron productos válidos para la tienda ID: " + tiendaId);
                responseBuilder.clear(); // Limpiar el builder por si acaso
            }

            responseObserver.onNext(responseBuilder.build());
            responseObserver.onCompleted();

        } catch (Exception e) {
            System.err.println("Error general en obtenerProductosPorTienda: " + e.getMessage());
            responseObserver.onError(Status.INTERNAL
                    .withDescription("Error interno del servidor: " + e.getMessage())
                    .asRuntimeException());
        }
    }

    @Override
    @Transactional
    public void obtenerProductos(EmptyTienda request, StreamObserver<TiendaProductsResponse> responseObserver) {
        try {
            List<TiendaProduct> productosEnTienda = tiendaProductRepository.findAll();
            TiendaProductsResponse.Builder responseBuilder = TiendaProductsResponse.newBuilder();

            for (TiendaProduct tiendaProduct : productosEnTienda) {
                try {
                    GetProductRequest productRequest = GetProductRequest.newBuilder()
                            .setId(tiendaProduct.getProductId())
                            .build();

                    GetProductResponse productResponse = productServiceStub.getProduct(productRequest);

                    TiendaProductResponse tiendaProductResponse = TiendaProductResponse.newBuilder()
                            .setTiendaId(tiendaProduct.getTiendaId())
                            .setProductoId(tiendaProduct.getProductId())
                            .setNombre(productResponse.getNombre())
                            .setCodigo(productResponse.getCodigo())
                            .setFoto(productResponse.getFoto())
                            .setColor(productResponse.getColor())
                            .setTalle(productResponse.getTalle())
                            .setStock(tiendaProduct.getStock())
                            .build();


                    responseBuilder.addProductos(tiendaProductResponse);
            } catch (Exception e) {
                System.err.println("Error al obtener producto " + tiendaProduct.getProductId() + ": " + e.getMessage());
                // Continuar con el siguiente producto
            }

            }

            responseObserver.onNext(responseBuilder.build());
            responseObserver.onCompleted();
        } catch (Exception e) {
            responseObserver.onError(Status.INTERNAL
                    .withDescription("Error interno del servidor: " + e.getMessage())
                    .asRuntimeException());
        }
    }

    @Override
    @Transactional
    public void getTiendasByProduct(GetTiendasByProductRequest request,
                                    StreamObserver<GetTiendasByProductResponse> responseObserver) {
        try {
            // Validar el ID del producto
            if (request.getProductId() <= 0) {
                responseObserver.onError(Status.INVALID_ARGUMENT
                        .withDescription("El ID del producto debe ser mayor que 0")
                        .asRuntimeException());
                return;
            }

            // Obtener las tiendas que tienen el producto
            List<TiendaProduct> tiendaProducts = tiendaProductRepository.findByProductId((long) request.getProductId());

            GetTiendasByProductResponse.Builder responseBuilder = GetTiendasByProductResponse.newBuilder();

            // Si no hay tiendas, devolver una respuesta vacía
            if (tiendaProducts.isEmpty()) {
                responseObserver.onNext(responseBuilder.build());
                responseObserver.onCompleted();
                return;
            }

            // Por cada tienda que tiene el producto, obtener la información completa
            for (TiendaProduct tiendaProduct : tiendaProducts) {
                try {
                    // Obtener la tienda de la base de datos
                    Tienda tienda = tiendaRepository.findById(tiendaProduct.getTiendaId())
                            .orElseThrow(() -> new RuntimeException("Tienda no encontrada: " + tiendaProduct.getTiendaId()));

                    // Construir objeto TiendaInfo con toda la información
                    TiendaInfo tiendaInfo = TiendaInfo.newBuilder()
                            .setId(tienda.getId())
                            .setCodigo(tienda.getCodigo())
                            .setEstado(tienda.getEstado())
                            .setDireccion(tienda.getDireccion())
                            .setCiudad(tienda.getCiudad())
                            .setProvincia(tienda.getProvincia())
                            .build();

                    responseBuilder.addTiendasInfo(tiendaInfo);

                } catch (Exception e) {
                    System.err.println("Error al obtener información de la tienda " +
                            tiendaProduct.getTiendaId() + ": " + e.getMessage());
                    continue;
                }
            }

            responseObserver.onNext(responseBuilder.build());
            responseObserver.onCompleted();

        } catch (Exception e) {
            System.err.println("Error general en getTiendasByProduct: " + e.getMessage());
            responseObserver.onError(Status.INTERNAL
                    .withDescription("Error interno del servidor: " + e.getMessage())
                    .asRuntimeException());
        }
    }

    @Override
    @Transactional
    public void asociarProductos(AsociarProductosRequest request, StreamObserver<AsociarProductosResponse> responseObserver) {
        long productId = request.getProductId();
        List<Long> tiendaIds = request.getTiendaIdsList();

        tiendaProductRepository.deleteByProductIdAndTiendaIdNotIn(productId, tiendaIds);

        if (tiendaIds.isEmpty()) {
            tiendaProductRepository.deleteByProductId(productId);
        } else {
            for (Long tiendaId : tiendaIds) {

                boolean exists = tiendaProductRepository.existsByTiendaIdAndProductId(tiendaId, productId);

                if (!exists) {
                    TiendaProduct tiendaProduct = TiendaProduct.builder()
                            .tiendaId(tiendaId)
                            .productId(productId)
                            .stock(0)
                            .build();
                    tiendaProductRepository.save(tiendaProduct);
                }
            }
        }

        AsociarProductosResponse response = AsociarProductosResponse.newBuilder()
                .setSuccess(true)
                .setMessage("Asociación de productos realizada correctamente")
                .build();

        responseObserver.onNext(response);
        responseObserver.onCompleted();
    }

    @Override
    @Transactional
    public void updateTiendaProductStock(UpdateTiendaProductStockRequest request,
                                         StreamObserver<UpdateTiendaProductStockResponse> responseObserver) {
        try {
            // Buscar la relación tienda-producto
            TiendaProduct tiendaProduct = tiendaProductRepository
                    .findByTiendaIdAndProductId(request.getTiendaId(), request.getProductId())
                    .orElseThrow(() -> new RuntimeException("Producto no encontrado para esta tienda"));

            // Actualizar el stock
            tiendaProduct.setStock(request.getStock());
            tiendaProductRepository.save(tiendaProduct);

            // Construir respuesta exitosa
            UpdateTiendaProductStockResponse response = UpdateTiendaProductStockResponse.newBuilder()
                    .setSuccess(true)
                    .setMessage("Stock actualizado correctamente")
                    .build();

            responseObserver.onNext(response);
            responseObserver.onCompleted();

        } catch (Exception e) {
            // Construir respuesta de error
            UpdateTiendaProductStockResponse response = UpdateTiendaProductStockResponse.newBuilder()
                    .setSuccess(false)
                    .setMessage("Error al actualizar el stock: " + e.getMessage())
                    .build();

            responseObserver.onNext(response);
            responseObserver.onCompleted();
        }
    }


}