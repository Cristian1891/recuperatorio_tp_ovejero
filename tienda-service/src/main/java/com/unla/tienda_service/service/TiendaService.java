package com.unla.tienda_service.service;


import com.unla.tienda_service.dtos.TiendaResponse;
import com.unla.tienda_service.model.Tienda;
import com.unla.tienda_service.repository.TiendaRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class TiendaService {


    private final TiendaRepository tiendaRepository;

    public List<TiendaResponse> getAllTiendas() {
        var clients = tiendaRepository.findAll();
        return clients.stream().map(this::mapToTiendaResponse).toList();
    }

    public TiendaResponse getById(Long id) {
        Optional<Tienda> tienda = tiendaRepository.findById(id);
        return mapToTiendaResponse(tienda.get());
    }


    public TiendaResponse findByCodigo(String codigo) {
        return mapToTiendaResponse(tiendaRepository.findByCodigo(codigo).get());
    }

    public List<Tienda> findTiendasByCodigos(List<String> codigos, boolean estado) {
        return tiendaRepository.findByCodigoInAndEstado(codigos, estado);
    }

    // Método existente que devuelve TiendaResponse
    public TiendaResponse findByCodigoAndEstado(String codigo, boolean estado) {
        Optional<Tienda> tienda = tiendaRepository.findByCodigoAndEstado(codigo, estado);
        return tienda.map(this::mapToTiendaResponse).orElse(null);
    }

    // Nuevo método que devuelve la entidad Tienda
    public Tienda findTiendaEntityByCodigoAndEstado(String codigo, boolean estado) {
        System.out.println("Buscando tienda con código: '" + codigo + "' y estado: " + estado);
        Optional<Tienda> tienda = tiendaRepository.findByCodigoAndEstado(codigo, estado);
        System.out.println("Resultado: " + (tienda.isPresent() ? "encontrado" : "no encontrado"));
        return tienda.orElse(null);
    }



    private TiendaResponse mapToTiendaResponse(Tienda tienda) {
        return TiendaResponse.builder()
                .id(tienda.getId())
                .codigo(tienda.getCodigo())
                .estado(tienda.getEstado())
                .build();
    }

}

