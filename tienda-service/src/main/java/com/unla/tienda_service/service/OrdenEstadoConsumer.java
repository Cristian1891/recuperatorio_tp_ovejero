package com.unla.tienda_service.service;

import com.unla.tienda_service.KafkaTopicProvider;
import com.unla.tienda_service.dtos.TiendaResponse;
import com.unla.tienda_service.messages.DispatchOrdenMessage;
import com.unla.tienda_service.messages.ResponseMessage;
import com.unla.tienda_service.model.OrdenCompra;
import com.unla.tienda_service.model.OrdenDespacho;
import com.unla.tienda_service.model.Tienda;
import com.unla.tienda_service.repository.OrdenCompraRepository;
import com.unla.tienda_service.repository.OrdenDespachoRepository;
import com.unla.tienda_service.repository.TiendaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.annotation.KafkaHandler;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.kafka.config.KafkaListenerContainerFactory;
import org.springframework.kafka.listener.ConcurrentMessageListenerContainer;
import org.springframework.kafka.support.KafkaHeaders;
import org.springframework.messaging.handler.annotation.Header;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class OrdenEstadoConsumer {

    @Autowired
    private OrdenCompraRepository ordenCompraRepository;

    @Autowired
    private OrdenDespachoRepository ordenDespachoRepository;

    @Autowired
    private TiendaRepository tiendaRepository;

    @Autowired
    private KafkaTopicProvider kafkaTopicProvider;


    @Autowired
    private KafkaListenerContainerFactory<ConcurrentMessageListenerContainer<String, Object>> kafkaListenerContainerFactory;

    @KafkaHandler
    public void processResponse(ResponseMessage responseMessage) {
        try {
            Optional<Tienda> tiendaOptional = tiendaRepository.findByCodigo(responseMessage.getCodigoTienda());
            if (tiendaOptional.isEmpty()) {
                System.out.println("Tienda no encontrada para el código: " + responseMessage.getCodigoTienda());
                return;
            }

            Tienda tienda = tiendaOptional.get();
            System.out.println("Procesando respuesta de la tienda: " + tienda.getCodigo());

            OrdenCompra orden = ordenCompraRepository.findById(responseMessage.getId()).orElse(null);
            if (orden == null) {
                System.out.println("Orden no encontrada: " + responseMessage.getId());
                return;
            }

            orden.setEstado(convertirEstado(responseMessage.getEstado()));
            orden.setFechaRecepcion(responseMessage.getFechaRecepcion());
            orden.setObservaciones(responseMessage.getObservaciones());
            ordenCompraRepository.save(orden);

            System.out.println("Orden actualizada exitosamente para la tienda: " + tienda.getCodigo());

        } catch (Exception e) {
            System.out.println("Error al procesar el mensaje: " + e.getMessage());
        }
    }

    @KafkaHandler
    public void processResponseDispatch(DispatchOrdenMessage dispatchOrdenMessage) {
        try {
            Optional<Tienda> tiendaOptional = tiendaRepository.findByCodigoAndEstado(dispatchOrdenMessage.getCodigoTienda(), true);
            if (tiendaOptional.isEmpty()) {
                System.out.println("Tienda no encontrada para el código: " + dispatchOrdenMessage.getCodigoTienda());
                return;
            }
            Tienda tienda = tiendaOptional.get();
            System.out.println("Procesando respuesta de la tienda: " + tienda.getCodigo());

            OrdenCompra orden = ordenCompraRepository.findById(dispatchOrdenMessage.getOrdenId()).orElse(null);
            if (orden == null) {
                System.out.println("Orden no encontrada: " + dispatchOrdenMessage.getOrdenId());
                return;
            }

            OrdenDespacho ordenDespacho = new OrdenDespacho();
            ordenDespacho.setFechaEstimadaEnvio(dispatchOrdenMessage.getFechaEstimadaEnvio());
            ordenDespacho.setIdOrdenCompra(orden.getId());
            ordenDespachoRepository.save(ordenDespacho);

            orden.setIdOrdenDespacho(ordenDespacho.getId());
            ordenCompraRepository.save(orden);

            System.out.println("Orden actualizada exitosamente para la tienda: " + tienda.getCodigo());

        } catch (Exception e) {
            System.out.println("Error al procesar el mensaje: " + e.getMessage());
        }
    }

    private OrdenCompra.EstadoOrden convertirEstado(ResponseMessage.EstadoOrden estado) {
        return OrdenCompra.EstadoOrden.valueOf(estado.name());
    }

//    private Tienda getTiendaFromMessage(Object message) {
//        String codigoTienda;
//        if (message instanceof ResponseMessage) {
//            codigoTienda = ((ResponseMessage) message).getCodigoTienda();
//        } else if (message instanceof DispatchOrdenMessage) {
//            codigoTienda = ((DispatchOrdenMessage) message).getCodigoTienda();
//        } else {
//            return null;
//        }
//
//        return tiendaRepository.findByCodigo(codigoTienda).orElse(null);
//    }
}
