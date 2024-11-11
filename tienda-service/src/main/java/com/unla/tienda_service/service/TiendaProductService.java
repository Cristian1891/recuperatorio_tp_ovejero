package com.unla.tienda_service.service;

import com.productoservice.grpc.CheckProductExistsRequest;
import com.productoservice.grpc.CheckProductExistsResponse;
import com.productoservice.grpc.ProductServiceGrpc;
import com.unla.tienda_service.converter.ProductBulkUploadConverter;
import com.unla.tienda_service.dtos.ProductBulkDTO;
import com.unla.tienda_service.dtos.ProductDto;
import com.unla.tienda_service.dtos.ProductParseError;
import com.unla.tienda_service.model.Tienda;
import com.unla.tienda_service.model.TiendaProduct;
import com.unla.tienda_service.repository.TiendaProductRepository;
import com.unla.tienda_service.repository.TiendaRepository;
import io.spring.guides.gs_producing_web_service.ProductBulkUploadRequest;
import io.spring.guides.gs_producing_web_service.ProductParseErrorSoap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVParser;
import org.apache.commons.csv.CSVRecord;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;


@Service
public class TiendaProductService {
    @Autowired
    private ProductServiceGrpc.ProductServiceBlockingStub productServiceStub;


    @Autowired
    private TiendaProductRepository productTiendaRepository;

    @Autowired
    private TiendaRepository tiendaRepository;


    @Autowired
    private ProductBulkUploadConverter productConverter;

    @Autowired
    private TiendaService tiendaService;



    public List<TiendaProduct> getTiendasByProductId(Long productId) {
        return productTiendaRepository.findByProductId(productId);
    }

    public List<ProductParseErrorSoap> uploadProductsFromCsv(InputStream csvInputStream) throws Exception {
        ParseResult result = parseCsvFile(csvInputStream);
        return productConverter.convertProductParseErrorListToSoap(result.getErrors());
    }
    public static class ParseResult {
        private final List<ProductParseError> errors;
        private final List<ProductBulkDTO> successfulProducts;

        public ParseResult(List<ProductParseError> errors, List<ProductBulkDTO> successfulProducts) {
            this.errors = errors;
            this.successfulProducts = successfulProducts;
        }

        public List<ProductParseError> getErrors() {
            return errors;
        }

        public List<ProductBulkDTO> getSuccessfulProducts() {
            return successfulProducts;
        }
    }

    // Nueva clase para manejar el resultado de la validación
    public static class ValidateProductResult {
        private final ProductBulkDTO productDTO;
        private final List<String> tiendasInvalidas;

        public ValidateProductResult(ProductBulkDTO productDTO, List<String> tiendasInvalidas) {
            this.productDTO = productDTO;
            this.tiendasInvalidas = tiendasInvalidas;
        }

        public ProductBulkDTO getProductDTO() {
            return productDTO;
        }

        public List<String> getTiendasInvalidas() {
            return tiendasInvalidas;
        }
    }


    public boolean checkProductExists(String codigo, String color, String talle) {
        CheckProductExistsRequest request = CheckProductExistsRequest.newBuilder()
                .setCodigo(codigo)
                .setColor(color)
                .setTalle(talle)
                .build();

        try {
            CheckProductExistsResponse response = productServiceStub.checkProductExists(request);
            return response.getExists();
        } catch (Exception e) {
            throw new RuntimeException("Error checking product existence via gRPC: " + e.getMessage());
        }
    }


    public ParseResult parseCsvFile(InputStream inputStream) throws Exception {
        List<ProductParseError> errors = new ArrayList<>();
        List<ProductBulkDTO> successfulProducts = new ArrayList<>();

        try (Reader reader = new InputStreamReader(inputStream);
             CSVParser csvParser = new CSVParser(reader, CSVFormat.DEFAULT
                     .withDelimiter(';')
                     .withHeader("codigo", "nombre", "color", "talle", "foto", "tiendas_asignadas")
                     .withSkipHeaderRecord(true))) {

            int lineNumber = 1;
            for (CSVRecord csvRecord : csvParser) {
                String codigo = csvRecord.get("codigo");
                String color = csvRecord.get("color");
                String talle = csvRecord.get("talle");

                try {
                    // Validar si el producto existe
                    if (checkProductExists(codigo, color, talle)) {
                        errors.add(new ProductParseError(
                                lineNumber,
                                codigo,
                                color,
                                talle,
                                "El producto ya existe"
                        ));
                    } else {
                        ValidateProductResult validationResult = validateAndCreateProductDTO(csvRecord, lineNumber);

                        // Si hay errores en las tiendas, agregarlos a la lista de errores
                        if (!validationResult.getTiendasInvalidas().isEmpty()) {
                            errors.add(new ProductParseError(
                                    lineNumber,
                                    codigo,
                                    color,
                                    talle,
                                    "Tiendas inválidas o deshabilitadas: " +
                                            String.join(", ", validationResult.getTiendasInvalidas())
                            ));
                        }

                        // Agregar el producto a la lista de éxitos si se creó correctamente
                        if (validationResult.getProductDTO() != null) {
                            createProduct(validationResult.getProductDTO());
                            successfulProducts.add(validationResult.getProductDTO());
                        }
                    }
                } catch (Exception e) {
                    errors.add(new ProductParseError(
                            lineNumber,
                            codigo,
                            color,
                            talle,
                            e.getMessage()
                    ));
                }
                lineNumber++;
            }
        }

        return new ParseResult(errors, successfulProducts);
    }


    public ValidateProductResult validateAndCreateProductDTO(CSVRecord csvRecord, int lineNumber) throws Exception {
        String codigo = csvRecord.get("codigo");
        String nombre = csvRecord.get("nombre");
        String color = csvRecord.get("color");
        String talle = csvRecord.get("talle");
        String foto = csvRecord.get("foto");
        String tiendasAsignadasStr = csvRecord.get("tiendas_asignadas").trim();

        // Validar campos obligatorios
        if (codigo.isEmpty() || color.isEmpty() || talle.isEmpty()) {
            throw new Exception("Campos obligatorios faltantes");
        }

        // Procesar tiendas asignadas
        List<Tienda> tiendasValidas = new ArrayList<>();
        List<String> tiendasInvalidas = new ArrayList<>();

        if (!tiendasAsignadasStr.isEmpty()) {
            // Obtener lista de códigos de tienda
            List<String> codigosTiendas = Arrays.stream(tiendasAsignadasStr.split("[,|]"))
                    .map(String::trim)
                    .filter(s -> !s.isEmpty())
                    .collect(Collectors.toList());

            if (!codigosTiendas.isEmpty()) {
                // Buscar todas las tiendas habilitadas con los códigos proporcionados
                List<Tienda> tiendasEncontradas = tiendaService.findTiendasByCodigos(codigosTiendas, true);
                tiendasValidas.addAll(tiendasEncontradas);

                // Crear un conjunto de códigos de tiendas encontradas para fácil búsqueda
                List<String> codigosTiendasEncontradas = tiendasEncontradas.stream()
                        .map(Tienda::getCodigo)
                        .toList();

                // Encontrar códigos de tiendas que no se encontraron o están deshabilitadas
                tiendasInvalidas = codigosTiendas.stream()
                        .filter(codigoT -> !codigosTiendasEncontradas.contains(codigoT))
                        .collect(Collectors.toList());
            }
        }

        // Crear el ProductBulkDTO con las tiendas válidas, incluso si hay algunas inválidas
        ProductBulkDTO productDTO = new ProductBulkDTO(codigo, nombre, color, talle, foto, tiendasValidas);

        return new ValidateProductResult(productDTO, tiendasInvalidas);
    }

    public ProductDto createProductInProductService(ProductBulkDTO productDTO) {
        com.productoservice.grpc.CreateProductRequest request = com.productoservice.grpc.CreateProductRequest.newBuilder()
                .setCodigo(productDTO.getCodigo())
                .setNombre(productDTO.getNombre())
                .setColor(productDTO.getColor())
                .setTalle(productDTO.getTalle())
                .setFoto(productDTO.getFoto())
                .build();

        try {
            com.productoservice.grpc.ProductResponse response = productServiceStub.createProduct(request);

            ProductDto createdProduct = new ProductDto();
            createdProduct.setId(response.getId());
            createdProduct.setCodigo(productDTO.getCodigo());
            createdProduct.setNombre(productDTO.getNombre());
            createdProduct.setColor(productDTO.getColor());
            createdProduct.setTalle(productDTO.getTalle());
            createdProduct.setFoto(productDTO.getFoto());

            return createdProduct;
        } catch (Exception e) {
            throw new RuntimeException("Error creating product via gRPC: " + e.getMessage());
        }
    }

    public void createTiendaProductAssociations(ProductDto product, List<Tienda> tiendas) {
        for (Tienda tienda : tiendas) {
            TiendaProduct tiendaProduct = new TiendaProduct();
            tiendaProduct.setProductId(product.getId());
            tiendaProduct.setTiendaId(tienda.getId());
            product.setCodigo(product.getCodigo());
            product.setColor(product.getColor());
            product.setTalle(product.getTalle());
            productTiendaRepository.save(tiendaProduct);
        }
    }

    public void createProduct(ProductBulkDTO productDTO) {
        try {
            // Crear producto en el servicio de productos
            ProductDto createdProduct = createProductInProductService(productDTO);

            // Si hay tiendas asignadas, crear las asociaciones
            if (!productDTO.getTiendasAsignadas().isEmpty()) {
                createTiendaProductAssociations(createdProduct, productDTO.getTiendasAsignadas());
            }
        } catch (Exception e) {
            throw new RuntimeException("Error en el proceso de creación del producto: " + e.getMessage());
        }
    }




}
