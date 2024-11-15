package com.unla.soap_client.client;

import com.unla.soap_client.service1.*;
import com.unla.soap_client.service2.*;
import com.unla.soap_client.service3.*;
import com.unla.soap_client.service4.UserBulkUploadRequest;
import com.unla.soap_client.service4.UserBulkUploadResponse;
import com.unla.soap_client.service1.ProductBulkUploadRequest;
import com.unla.soap_client.service1.ProductBulkUploadResponse;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ws.client.core.support.WebServiceGatewaySupport;
import org.springframework.ws.soap.client.core.SoapActionCallback;

import java.util.List;

public class SoapClient extends WebServiceGatewaySupport {



    public GetOrdenComprasAgrupadasResponse getOrdenComprasAgrupadasResponse(GetOrdenComprasRequest getOrdenComprasRequest) {


        SoapActionCallback soapActionCallback = new SoapActionCallback("http://spring.io/guides/gs-producing-web-service/getOrdenComprasRequest");

        GetOrdenComprasAgrupadasResponse getOrdenComprasAgrupadasResponse = (GetOrdenComprasAgrupadasResponse) getWebServiceTemplate().marshalSendAndReceive("http://localhost:8081/ws", getOrdenComprasRequest, soapActionCallback);

        return getOrdenComprasAgrupadasResponse;
    }

    public GetOrdenComprasByTiendaResponse getOrdenComprasByTiendaResponse(GetOrdenComprasByTiendaRequest getOrdenComprasByTiendaRequest) {


        SoapActionCallback soapActionCallback = new SoapActionCallback("http://spring.io/guides/gs-producing-web-service/getOrdenComprasByTiendaRequest");

        GetOrdenComprasByTiendaResponse getOrdenComprasByTiendaResponse = (GetOrdenComprasByTiendaResponse) getWebServiceTemplate().marshalSendAndReceive("http://localhost:8081/ws", getOrdenComprasByTiendaRequest, soapActionCallback);

        return getOrdenComprasByTiendaResponse;
    }



    public GetCatalogoResponse getCatalogoResponse(GetCatalogoRequest getCatalogoRequest) {



        SoapActionCallback soapActionCallback = new SoapActionCallback("http://spring.io/guides/gs-producing-web-service/getCatalogoRequest");

        GetCatalogoResponse getCatalogoResponse = (GetCatalogoResponse) getWebServiceTemplate().marshalSendAndReceive("http://localhost:8083/ws", getCatalogoRequest, soapActionCallback);

        return getCatalogoResponse;
    }

    public AddProductsToCatalogoResponse addProductsToCatalogoResponse(CatalogoSoap catalogoSoap) {

        AddProductsToCatalogoRequest addProductsToCatalogoRequest= new AddProductsToCatalogoRequest();
        addProductsToCatalogoRequest.setId(catalogoSoap.getId());

        if (catalogoSoap != null && catalogoSoap.getProducts() != null) {
            addProductsToCatalogoRequest.getProducts().addAll(catalogoSoap.getProducts());
        }

        SoapActionCallback soapActionCallback = new SoapActionCallback("http://spring.io/guides/gs-producing-web-service/getCatalogoRequest");

        AddProductsToCatalogoResponse addResponse = (AddProductsToCatalogoResponse) getWebServiceTemplate().marshalSendAndReceive("http://localhost:8083/ws", addProductsToCatalogoRequest, soapActionCallback);

        return addResponse;
    }

    public PostCatalogoResponse postCatalogoResponse(CatalogoSoap catalogoSoap) {

        PostCatalogoRequest postCatalogoRequest= new PostCatalogoRequest();
        postCatalogoRequest.setCatalogo(catalogoSoap);

        SoapActionCallback soapActionCallback = new SoapActionCallback("http://spring.io/guides/gs-producing-web-service/getCatalogoRequest");

        PostCatalogoResponse postCatalogoResponse = (PostCatalogoResponse) getWebServiceTemplate().marshalSendAndReceive("http://localhost:8083/ws", postCatalogoRequest, soapActionCallback);

        return postCatalogoResponse;
    }

    public GetCatalogoPdfResponse getCatalogoPdfResponse(GetCatalogoPdfRequest getCatalogoPdfRequest) {



        SoapActionCallback soapActionCallback = new SoapActionCallback("http://spring.io/guides/gs-producing-web-service/getCatalogoPdfRequest");

        GetCatalogoPdfResponse getCatalogoPdfResponse = (GetCatalogoPdfResponse) getWebServiceTemplate().marshalSendAndReceive("http://localhost:8083/ws", getCatalogoPdfRequest, soapActionCallback);

        return getCatalogoPdfResponse;
    }

    public ObtenerFiltrosResponse obtenerFiltrosResponse(ObtenerFiltrosRequest obtenerFiltrosRequest) {


        SoapActionCallback soapActionCallback = new SoapActionCallback("http://spring.io/guides/gs-producing-web-service/obtenerFiltrosRequest");

        ObtenerFiltrosResponse obtenerFiltrosResponse = (ObtenerFiltrosResponse) getWebServiceTemplate().marshalSendAndReceive("http://localhost:8084/ws", obtenerFiltrosRequest, soapActionCallback);

        return obtenerFiltrosResponse;
    }

    public PostFiltroResponse postFiltroResponse(FiltroSoap filtroSoap) {

        PostFiltroRequest postFiltroRequest= new PostFiltroRequest();
        postFiltroRequest.setFiltro(filtroSoap);

        SoapActionCallback soapActionCallback = new SoapActionCallback("http://spring.io/guides/gs-producing-web-service/postFiltroRequest");

        PostFiltroResponse postFiltroResponse = (PostFiltroResponse) getWebServiceTemplate().marshalSendAndReceive("http://localhost:8084/ws", postFiltroRequest, soapActionCallback);

        return postFiltroResponse;
    }

    public ModificarFiltroResponse modificarFiltroResponse(FiltroSoap filtroSoap) {
        ModificarFiltroRequest modificarFiltroRequest = new ModificarFiltroRequest();
        modificarFiltroRequest.setFiltro(filtroSoap);

        SoapActionCallback soapActionCallback = new SoapActionCallback("http://spring.io/guides/gs-producing-web-service/modificarFiltroRequest");

        ModificarFiltroResponse modificarFiltroResponse = (ModificarFiltroResponse) getWebServiceTemplate().marshalSendAndReceive("http://localhost:8084/ws", modificarFiltroRequest, soapActionCallback);

        return modificarFiltroResponse;
    }

    public EliminarFiltroResponse eliminarFiltroResponse(Long id) {
        EliminarFiltroRequest eliminarFiltroRequest = new EliminarFiltroRequest();
        eliminarFiltroRequest.setId(id);

        SoapActionCallback soapActionCallback = new SoapActionCallback("http://spring.io/guides/gs-producing-web-service/eliminarFiltroRequest");

        EliminarFiltroResponse eliminarFiltroResponse = (EliminarFiltroResponse) getWebServiceTemplate().marshalSendAndReceive("http://localhost:8084/ws", eliminarFiltroRequest, soapActionCallback);

        return eliminarFiltroResponse;
    }

    public UserBulkUploadResponse userBulkUploadResponse(UserBulkUploadRequest request){



        SoapActionCallback soapActionCallback = new SoapActionCallback("http://spring.io/guides/gs-producing-web-service/userBulkUploadRequest");

        UserBulkUploadResponse userBulkUploadResponse = (UserBulkUploadResponse) getWebServiceTemplate().marshalSendAndReceive("http://localhost:8082/ws", request, soapActionCallback);

        return userBulkUploadResponse;
    }

    public ProductBulkUploadResponse productBulkUploadResponse(ProductBulkUploadRequest request) {
        try {

            SoapActionCallback soapActionCallback = new SoapActionCallback(
                    "http://spring.io/guides/gs-producing-web-service/productBulkUploadRequest"
            );

            ProductBulkUploadResponse response = (ProductBulkUploadResponse) getWebServiceTemplate()
                    .marshalSendAndReceive("http://localhost:8081/ws", request, soapActionCallback);

            return response;
        } catch (Exception e) {
            // Manejar el error apropiadamente
            throw new RuntimeException("Error al procesar la carga masiva de productos: " + e.getMessage());
        }
    }

    public EliminarCatalogoResponse eliminarCatalogoResponse(EliminarCatalogoRequest request){



        SoapActionCallback soapActionCallback = new SoapActionCallback("http://spring.io/guides/gs-producing-web-service/eiminarCatalogoRequest");

        EliminarCatalogoResponse eliminarCatalogoResponse = (EliminarCatalogoResponse) getWebServiceTemplate().marshalSendAndReceive("http://localhost:8083/ws", request, soapActionCallback);

        return eliminarCatalogoResponse;
    }


}