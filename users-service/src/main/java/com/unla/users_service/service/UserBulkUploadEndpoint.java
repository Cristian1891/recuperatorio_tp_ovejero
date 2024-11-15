package com.unla.users_service.service;



import io.spring.guides.gs_producing_web_service.UserBulkUploadRequest;
import io.spring.guides.gs_producing_web_service.UserBulkUploadResponse;
import io.spring.guides.gs_producing_web_service.UserParseErrorSoap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ws.server.endpoint.annotation.Endpoint;
import org.springframework.ws.server.endpoint.annotation.PayloadRoot;
import org.springframework.ws.server.endpoint.annotation.RequestPayload;
import org.springframework.ws.server.endpoint.annotation.ResponsePayload;


import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.List;

@Endpoint
public class UserBulkUploadEndpoint {

    private final UserService userService;

    private static final String NAMESPACE_URI = "http://spring.io/guides/gs-producing-web-service";


    @Autowired
    public UserBulkUploadEndpoint(UserService userService) {
        this.userService = userService;
    }

    @PayloadRoot(namespace = NAMESPACE_URI, localPart = "UserBulkUploadRequest")
    @ResponsePayload
    public UserBulkUploadResponse handleUserBulkRequest(@RequestPayload UserBulkUploadRequest request) throws Exception {

        byte[] csvBytes = request.getCsvData();
        InputStream csvInputStream = new ByteArrayInputStream(csvBytes);
        UserBulkUploadResponse response= new UserBulkUploadResponse();

        List<UserParseErrorSoap> errors= userService.uploadUsersFromCsv(csvInputStream);

        for (UserParseErrorSoap error : errors) {
            response.getErrors().add(error);
        }

        return response;

    }






}