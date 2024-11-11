package com.unla.tienda_service;

import org.springframework.stereotype.Component;
import com.unla.tienda_service.model.Tienda;
import com.unla.tienda_service.repository.TiendaRepository;
import org.springframework.beans.factory.annotation.Autowired;

import javax.annotation.PostConstruct;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class KafkaTopicProvider {
    public static final String SOLICITUDES_TOPIC_PREFIX = "{codigo_tienda}-solicitudes";
    public static final String DESPACHO_TOPIC_PREFIX = "{codigo_tienda}-despacho";

    private List<String> solicitudesTopics;
    private List<String> despachoTopics;

    @Autowired
    private TiendaRepository tiendaRepository;

    @PostConstruct
    public void init() {
        solicitudesTopics = tiendaRepository.findAll().stream()
                .map(tienda -> tienda.getCodigo() + "-solicitudes")
                .collect(Collectors.toList());

        despachoTopics = tiendaRepository.findAll().stream()
                .map(tienda -> tienda.getCodigo() + "-despacho")
                .collect(Collectors.toList());
    }

    public List<String> getSolicitudesTopics() {
        return solicitudesTopics;
    }

    public List<String> getDespachoTopics() {
        return despachoTopics;
    }


}
