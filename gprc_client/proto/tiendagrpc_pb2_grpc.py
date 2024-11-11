# Generated by the gRPC Python protocol compiler plugin. DO NOT EDIT!
"""Client and server classes corresponding to protobuf-defined services."""
import grpc
import warnings

import tiendagrpc_pb2 as tiendagrpc__pb2

GRPC_GENERATED_VERSION = '1.66.1'
GRPC_VERSION = grpc.__version__
_version_not_supported = False

try:
    from grpc._utilities import first_version_is_lower
    _version_not_supported = first_version_is_lower(GRPC_VERSION, GRPC_GENERATED_VERSION)
except ImportError:
    _version_not_supported = True

if _version_not_supported:
    raise RuntimeError(
        f'The grpc package installed is at version {GRPC_VERSION},'
        + f' but the generated code in tiendagrpc_pb2_grpc.py depends on'
        + f' grpcio>={GRPC_GENERATED_VERSION}.'
        + f' Please upgrade your grpc module to grpcio>={GRPC_GENERATED_VERSION}'
        + f' or downgrade your generated code using grpcio-tools<={GRPC_VERSION}.'
    )


class OrdenServiceStub(object):
    """Missing associated documentation comment in .proto file."""

    def __init__(self, channel):
        """Constructor.

        Args:
            channel: A grpc.Channel.
        """
        self.CreateOrder = channel.unary_unary(
                '/OrdenService/CreateOrder',
                request_serializer=tiendagrpc__pb2.CreateOrderRequest.SerializeToString,
                response_deserializer=tiendagrpc__pb2.CreateOrderResponse.FromString,
                _registered_method=True)
        self.ChangeOrderState = channel.unary_unary(
                '/OrdenService/ChangeOrderState',
                request_serializer=tiendagrpc__pb2.ChangeOrderStateRequest.SerializeToString,
                response_deserializer=tiendagrpc__pb2.ChangeOrderStateResponse.FromString,
                _registered_method=True)
        self.ListarOrdenesByTienda = channel.unary_unary(
                '/OrdenService/ListarOrdenesByTienda',
                request_serializer=tiendagrpc__pb2.ListarOrdenesRequest.SerializeToString,
                response_deserializer=tiendagrpc__pb2.ListarOrdenesResponse.FromString,
                _registered_method=True)


class OrdenServiceServicer(object):
    """Missing associated documentation comment in .proto file."""

    def CreateOrder(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def ChangeOrderState(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def ListarOrdenesByTienda(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')


def add_OrdenServiceServicer_to_server(servicer, server):
    rpc_method_handlers = {
            'CreateOrder': grpc.unary_unary_rpc_method_handler(
                    servicer.CreateOrder,
                    request_deserializer=tiendagrpc__pb2.CreateOrderRequest.FromString,
                    response_serializer=tiendagrpc__pb2.CreateOrderResponse.SerializeToString,
            ),
            'ChangeOrderState': grpc.unary_unary_rpc_method_handler(
                    servicer.ChangeOrderState,
                    request_deserializer=tiendagrpc__pb2.ChangeOrderStateRequest.FromString,
                    response_serializer=tiendagrpc__pb2.ChangeOrderStateResponse.SerializeToString,
            ),
            'ListarOrdenesByTienda': grpc.unary_unary_rpc_method_handler(
                    servicer.ListarOrdenesByTienda,
                    request_deserializer=tiendagrpc__pb2.ListarOrdenesRequest.FromString,
                    response_serializer=tiendagrpc__pb2.ListarOrdenesResponse.SerializeToString,
            ),
    }
    generic_handler = grpc.method_handlers_generic_handler(
            'OrdenService', rpc_method_handlers)
    server.add_generic_rpc_handlers((generic_handler,))
    server.add_registered_method_handlers('OrdenService', rpc_method_handlers)


 # This class is part of an EXPERIMENTAL API.
class OrdenService(object):
    """Missing associated documentation comment in .proto file."""

    @staticmethod
    def CreateOrder(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(
            request,
            target,
            '/OrdenService/CreateOrder',
            tiendagrpc__pb2.CreateOrderRequest.SerializeToString,
            tiendagrpc__pb2.CreateOrderResponse.FromString,
            options,
            channel_credentials,
            insecure,
            call_credentials,
            compression,
            wait_for_ready,
            timeout,
            metadata,
            _registered_method=True)

    @staticmethod
    def ChangeOrderState(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(
            request,
            target,
            '/OrdenService/ChangeOrderState',
            tiendagrpc__pb2.ChangeOrderStateRequest.SerializeToString,
            tiendagrpc__pb2.ChangeOrderStateResponse.FromString,
            options,
            channel_credentials,
            insecure,
            call_credentials,
            compression,
            wait_for_ready,
            timeout,
            metadata,
            _registered_method=True)

    @staticmethod
    def ListarOrdenesByTienda(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(
            request,
            target,
            '/OrdenService/ListarOrdenesByTienda',
            tiendagrpc__pb2.ListarOrdenesRequest.SerializeToString,
            tiendagrpc__pb2.ListarOrdenesResponse.FromString,
            options,
            channel_credentials,
            insecure,
            call_credentials,
            compression,
            wait_for_ready,
            timeout,
            metadata,
            _registered_method=True)


class NovedadesServiceStub(object):
    """Missing associated documentation comment in .proto file."""

    def __init__(self, channel):
        """Constructor.

        Args:
            channel: A grpc.Channel.
        """
        self.ListarNovedades = channel.unary_unary(
                '/NovedadesService/ListarNovedades',
                request_serializer=tiendagrpc__pb2.EmptyNovedad.SerializeToString,
                response_deserializer=tiendagrpc__pb2.ListarNovedadesResponse.FromString,
                _registered_method=True)
        self.DeleteNovedad = channel.unary_unary(
                '/NovedadesService/DeleteNovedad',
                request_serializer=tiendagrpc__pb2.DeleteNovedadRequest.SerializeToString,
                response_deserializer=tiendagrpc__pb2.DeleteNovedadResponse.FromString,
                _registered_method=True)


class NovedadesServiceServicer(object):
    """Missing associated documentation comment in .proto file."""

    def ListarNovedades(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def DeleteNovedad(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')


def add_NovedadesServiceServicer_to_server(servicer, server):
    rpc_method_handlers = {
            'ListarNovedades': grpc.unary_unary_rpc_method_handler(
                    servicer.ListarNovedades,
                    request_deserializer=tiendagrpc__pb2.EmptyNovedad.FromString,
                    response_serializer=tiendagrpc__pb2.ListarNovedadesResponse.SerializeToString,
            ),
            'DeleteNovedad': grpc.unary_unary_rpc_method_handler(
                    servicer.DeleteNovedad,
                    request_deserializer=tiendagrpc__pb2.DeleteNovedadRequest.FromString,
                    response_serializer=tiendagrpc__pb2.DeleteNovedadResponse.SerializeToString,
            ),
    }
    generic_handler = grpc.method_handlers_generic_handler(
            'NovedadesService', rpc_method_handlers)
    server.add_generic_rpc_handlers((generic_handler,))
    server.add_registered_method_handlers('NovedadesService', rpc_method_handlers)


 # This class is part of an EXPERIMENTAL API.
class NovedadesService(object):
    """Missing associated documentation comment in .proto file."""

    @staticmethod
    def ListarNovedades(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(
            request,
            target,
            '/NovedadesService/ListarNovedades',
            tiendagrpc__pb2.EmptyNovedad.SerializeToString,
            tiendagrpc__pb2.ListarNovedadesResponse.FromString,
            options,
            channel_credentials,
            insecure,
            call_credentials,
            compression,
            wait_for_ready,
            timeout,
            metadata,
            _registered_method=True)

    @staticmethod
    def DeleteNovedad(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(
            request,
            target,
            '/NovedadesService/DeleteNovedad',
            tiendagrpc__pb2.DeleteNovedadRequest.SerializeToString,
            tiendagrpc__pb2.DeleteNovedadResponse.FromString,
            options,
            channel_credentials,
            insecure,
            call_credentials,
            compression,
            wait_for_ready,
            timeout,
            metadata,
            _registered_method=True)


class TiendaServiceStub(object):
    """Missing associated documentation comment in .proto file."""

    def __init__(self, channel):
        """Constructor.

        Args:
            channel: A grpc.Channel.
        """
        self.GetTienda = channel.unary_unary(
                '/TiendaService/GetTienda',
                request_serializer=tiendagrpc__pb2.GetTiendaRequest.SerializeToString,
                response_deserializer=tiendagrpc__pb2.GetTiendaResponse.FromString,
                _registered_method=True)
        self.GetTiendaByCodigo = channel.unary_unary(
                '/TiendaService/GetTiendaByCodigo',
                request_serializer=tiendagrpc__pb2.GetTiendaByCodigoRequest.SerializeToString,
                response_deserializer=tiendagrpc__pb2.GetTiendaResponse.FromString,
                _registered_method=True)
        self.RegistrarTienda = channel.unary_unary(
                '/TiendaService/RegistrarTienda',
                request_serializer=tiendagrpc__pb2.RegistrarTiendaRequest.SerializeToString,
                response_deserializer=tiendagrpc__pb2.RegistrarTiendaResponse.FromString,
                _registered_method=True)
        self.UpdateTienda = channel.unary_unary(
                '/TiendaService/UpdateTienda',
                request_serializer=tiendagrpc__pb2.UpdateTiendaRequest.SerializeToString,
                response_deserializer=tiendagrpc__pb2.UpdateTiendaResponse.FromString,
                _registered_method=True)
        self.ListarTiendas = channel.unary_unary(
                '/TiendaService/ListarTiendas',
                request_serializer=tiendagrpc__pb2.EmptyTienda.SerializeToString,
                response_deserializer=tiendagrpc__pb2.ListarTiendasResponse.FromString,
                _registered_method=True)
        self.GetTiendasByEstado = channel.unary_unary(
                '/TiendaService/GetTiendasByEstado',
                request_serializer=tiendagrpc__pb2.GetTiendaByEstadoRequest.SerializeToString,
                response_deserializer=tiendagrpc__pb2.ListarTiendasResponse.FromString,
                _registered_method=True)
        self.DeleteTienda = channel.unary_unary(
                '/TiendaService/DeleteTienda',
                request_serializer=tiendagrpc__pb2.DeleteTiendaRequest.SerializeToString,
                response_deserializer=tiendagrpc__pb2.DeleteTiendaResponse.FromString,
                _registered_method=True)


class TiendaServiceServicer(object):
    """Missing associated documentation comment in .proto file."""

    def GetTienda(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def GetTiendaByCodigo(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def RegistrarTienda(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def UpdateTienda(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def ListarTiendas(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def GetTiendasByEstado(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def DeleteTienda(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')


def add_TiendaServiceServicer_to_server(servicer, server):
    rpc_method_handlers = {
            'GetTienda': grpc.unary_unary_rpc_method_handler(
                    servicer.GetTienda,
                    request_deserializer=tiendagrpc__pb2.GetTiendaRequest.FromString,
                    response_serializer=tiendagrpc__pb2.GetTiendaResponse.SerializeToString,
            ),
            'GetTiendaByCodigo': grpc.unary_unary_rpc_method_handler(
                    servicer.GetTiendaByCodigo,
                    request_deserializer=tiendagrpc__pb2.GetTiendaByCodigoRequest.FromString,
                    response_serializer=tiendagrpc__pb2.GetTiendaResponse.SerializeToString,
            ),
            'RegistrarTienda': grpc.unary_unary_rpc_method_handler(
                    servicer.RegistrarTienda,
                    request_deserializer=tiendagrpc__pb2.RegistrarTiendaRequest.FromString,
                    response_serializer=tiendagrpc__pb2.RegistrarTiendaResponse.SerializeToString,
            ),
            'UpdateTienda': grpc.unary_unary_rpc_method_handler(
                    servicer.UpdateTienda,
                    request_deserializer=tiendagrpc__pb2.UpdateTiendaRequest.FromString,
                    response_serializer=tiendagrpc__pb2.UpdateTiendaResponse.SerializeToString,
            ),
            'ListarTiendas': grpc.unary_unary_rpc_method_handler(
                    servicer.ListarTiendas,
                    request_deserializer=tiendagrpc__pb2.EmptyTienda.FromString,
                    response_serializer=tiendagrpc__pb2.ListarTiendasResponse.SerializeToString,
            ),
            'GetTiendasByEstado': grpc.unary_unary_rpc_method_handler(
                    servicer.GetTiendasByEstado,
                    request_deserializer=tiendagrpc__pb2.GetTiendaByEstadoRequest.FromString,
                    response_serializer=tiendagrpc__pb2.ListarTiendasResponse.SerializeToString,
            ),
            'DeleteTienda': grpc.unary_unary_rpc_method_handler(
                    servicer.DeleteTienda,
                    request_deserializer=tiendagrpc__pb2.DeleteTiendaRequest.FromString,
                    response_serializer=tiendagrpc__pb2.DeleteTiendaResponse.SerializeToString,
            ),
    }
    generic_handler = grpc.method_handlers_generic_handler(
            'TiendaService', rpc_method_handlers)
    server.add_generic_rpc_handlers((generic_handler,))
    server.add_registered_method_handlers('TiendaService', rpc_method_handlers)


 # This class is part of an EXPERIMENTAL API.
class TiendaService(object):
    """Missing associated documentation comment in .proto file."""

    @staticmethod
    def GetTienda(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(
            request,
            target,
            '/TiendaService/GetTienda',
            tiendagrpc__pb2.GetTiendaRequest.SerializeToString,
            tiendagrpc__pb2.GetTiendaResponse.FromString,
            options,
            channel_credentials,
            insecure,
            call_credentials,
            compression,
            wait_for_ready,
            timeout,
            metadata,
            _registered_method=True)

    @staticmethod
    def GetTiendaByCodigo(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(
            request,
            target,
            '/TiendaService/GetTiendaByCodigo',
            tiendagrpc__pb2.GetTiendaByCodigoRequest.SerializeToString,
            tiendagrpc__pb2.GetTiendaResponse.FromString,
            options,
            channel_credentials,
            insecure,
            call_credentials,
            compression,
            wait_for_ready,
            timeout,
            metadata,
            _registered_method=True)

    @staticmethod
    def RegistrarTienda(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(
            request,
            target,
            '/TiendaService/RegistrarTienda',
            tiendagrpc__pb2.RegistrarTiendaRequest.SerializeToString,
            tiendagrpc__pb2.RegistrarTiendaResponse.FromString,
            options,
            channel_credentials,
            insecure,
            call_credentials,
            compression,
            wait_for_ready,
            timeout,
            metadata,
            _registered_method=True)

    @staticmethod
    def UpdateTienda(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(
            request,
            target,
            '/TiendaService/UpdateTienda',
            tiendagrpc__pb2.UpdateTiendaRequest.SerializeToString,
            tiendagrpc__pb2.UpdateTiendaResponse.FromString,
            options,
            channel_credentials,
            insecure,
            call_credentials,
            compression,
            wait_for_ready,
            timeout,
            metadata,
            _registered_method=True)

    @staticmethod
    def ListarTiendas(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(
            request,
            target,
            '/TiendaService/ListarTiendas',
            tiendagrpc__pb2.EmptyTienda.SerializeToString,
            tiendagrpc__pb2.ListarTiendasResponse.FromString,
            options,
            channel_credentials,
            insecure,
            call_credentials,
            compression,
            wait_for_ready,
            timeout,
            metadata,
            _registered_method=True)

    @staticmethod
    def GetTiendasByEstado(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(
            request,
            target,
            '/TiendaService/GetTiendasByEstado',
            tiendagrpc__pb2.GetTiendaByEstadoRequest.SerializeToString,
            tiendagrpc__pb2.ListarTiendasResponse.FromString,
            options,
            channel_credentials,
            insecure,
            call_credentials,
            compression,
            wait_for_ready,
            timeout,
            metadata,
            _registered_method=True)

    @staticmethod
    def DeleteTienda(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(
            request,
            target,
            '/TiendaService/DeleteTienda',
            tiendagrpc__pb2.DeleteTiendaRequest.SerializeToString,
            tiendagrpc__pb2.DeleteTiendaResponse.FromString,
            options,
            channel_credentials,
            insecure,
            call_credentials,
            compression,
            wait_for_ready,
            timeout,
            metadata,
            _registered_method=True)


class TiendaProductServiceStub(object):
    """Missing associated documentation comment in .proto file."""

    def __init__(self, channel):
        """Constructor.

        Args:
            channel: A grpc.Channel.
        """
        self.AddTiendaProduct = channel.unary_unary(
                '/TiendaProductService/AddTiendaProduct',
                request_serializer=tiendagrpc__pb2.AddTiendaProductRequest.SerializeToString,
                response_deserializer=tiendagrpc__pb2.AddTiendaProductResponse.FromString,
                _registered_method=True)
        self.GetTiendaProduct = channel.unary_unary(
                '/TiendaProductService/GetTiendaProduct',
                request_serializer=tiendagrpc__pb2.GetTiendaProductRequest.SerializeToString,
                response_deserializer=tiendagrpc__pb2.GetTiendaProductResponse.FromString,
                _registered_method=True)
        self.DeleteTiendaProduct = channel.unary_unary(
                '/TiendaProductService/DeleteTiendaProduct',
                request_serializer=tiendagrpc__pb2.DeleteTiendaProductRequest.SerializeToString,
                response_deserializer=tiendagrpc__pb2.DeleteTiendaProductResponse.FromString,
                _registered_method=True)
        self.GetTiendasByProduct = channel.unary_unary(
                '/TiendaProductService/GetTiendasByProduct',
                request_serializer=tiendagrpc__pb2.GetTiendasByProductRequest.SerializeToString,
                response_deserializer=tiendagrpc__pb2.GetTiendasByProductResponse.FromString,
                _registered_method=True)
        self.ObtenerProductosPorTienda = channel.unary_unary(
                '/TiendaProductService/ObtenerProductosPorTienda',
                request_serializer=tiendagrpc__pb2.TiendaProductsRequest.SerializeToString,
                response_deserializer=tiendagrpc__pb2.TiendaProductsResponse.FromString,
                _registered_method=True)
        self.ObtenerProductos = channel.unary_unary(
                '/TiendaProductService/ObtenerProductos',
                request_serializer=tiendagrpc__pb2.EmptyTienda.SerializeToString,
                response_deserializer=tiendagrpc__pb2.TiendaProductsResponse.FromString,
                _registered_method=True)
        self.AsociarProductos = channel.unary_unary(
                '/TiendaProductService/AsociarProductos',
                request_serializer=tiendagrpc__pb2.AsociarProductosRequest.SerializeToString,
                response_deserializer=tiendagrpc__pb2.AsociarProductosResponse.FromString,
                _registered_method=True)
        self.UpdateTiendaProductStock = channel.unary_unary(
                '/TiendaProductService/UpdateTiendaProductStock',
                request_serializer=tiendagrpc__pb2.UpdateTiendaProductStockRequest.SerializeToString,
                response_deserializer=tiendagrpc__pb2.UpdateTiendaProductStockResponse.FromString,
                _registered_method=True)


class TiendaProductServiceServicer(object):
    """Missing associated documentation comment in .proto file."""

    def AddTiendaProduct(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def GetTiendaProduct(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def DeleteTiendaProduct(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def GetTiendasByProduct(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def ObtenerProductosPorTienda(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def ObtenerProductos(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def AsociarProductos(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def UpdateTiendaProductStock(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')


def add_TiendaProductServiceServicer_to_server(servicer, server):
    rpc_method_handlers = {
            'AddTiendaProduct': grpc.unary_unary_rpc_method_handler(
                    servicer.AddTiendaProduct,
                    request_deserializer=tiendagrpc__pb2.AddTiendaProductRequest.FromString,
                    response_serializer=tiendagrpc__pb2.AddTiendaProductResponse.SerializeToString,
            ),
            'GetTiendaProduct': grpc.unary_unary_rpc_method_handler(
                    servicer.GetTiendaProduct,
                    request_deserializer=tiendagrpc__pb2.GetTiendaProductRequest.FromString,
                    response_serializer=tiendagrpc__pb2.GetTiendaProductResponse.SerializeToString,
            ),
            'DeleteTiendaProduct': grpc.unary_unary_rpc_method_handler(
                    servicer.DeleteTiendaProduct,
                    request_deserializer=tiendagrpc__pb2.DeleteTiendaProductRequest.FromString,
                    response_serializer=tiendagrpc__pb2.DeleteTiendaProductResponse.SerializeToString,
            ),
            'GetTiendasByProduct': grpc.unary_unary_rpc_method_handler(
                    servicer.GetTiendasByProduct,
                    request_deserializer=tiendagrpc__pb2.GetTiendasByProductRequest.FromString,
                    response_serializer=tiendagrpc__pb2.GetTiendasByProductResponse.SerializeToString,
            ),
            'ObtenerProductosPorTienda': grpc.unary_unary_rpc_method_handler(
                    servicer.ObtenerProductosPorTienda,
                    request_deserializer=tiendagrpc__pb2.TiendaProductsRequest.FromString,
                    response_serializer=tiendagrpc__pb2.TiendaProductsResponse.SerializeToString,
            ),
            'ObtenerProductos': grpc.unary_unary_rpc_method_handler(
                    servicer.ObtenerProductos,
                    request_deserializer=tiendagrpc__pb2.EmptyTienda.FromString,
                    response_serializer=tiendagrpc__pb2.TiendaProductsResponse.SerializeToString,
            ),
            'AsociarProductos': grpc.unary_unary_rpc_method_handler(
                    servicer.AsociarProductos,
                    request_deserializer=tiendagrpc__pb2.AsociarProductosRequest.FromString,
                    response_serializer=tiendagrpc__pb2.AsociarProductosResponse.SerializeToString,
            ),
            'UpdateTiendaProductStock': grpc.unary_unary_rpc_method_handler(
                    servicer.UpdateTiendaProductStock,
                    request_deserializer=tiendagrpc__pb2.UpdateTiendaProductStockRequest.FromString,
                    response_serializer=tiendagrpc__pb2.UpdateTiendaProductStockResponse.SerializeToString,
            ),
    }
    generic_handler = grpc.method_handlers_generic_handler(
            'TiendaProductService', rpc_method_handlers)
    server.add_generic_rpc_handlers((generic_handler,))
    server.add_registered_method_handlers('TiendaProductService', rpc_method_handlers)


 # This class is part of an EXPERIMENTAL API.
class TiendaProductService(object):
    """Missing associated documentation comment in .proto file."""

    @staticmethod
    def AddTiendaProduct(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(
            request,
            target,
            '/TiendaProductService/AddTiendaProduct',
            tiendagrpc__pb2.AddTiendaProductRequest.SerializeToString,
            tiendagrpc__pb2.AddTiendaProductResponse.FromString,
            options,
            channel_credentials,
            insecure,
            call_credentials,
            compression,
            wait_for_ready,
            timeout,
            metadata,
            _registered_method=True)

    @staticmethod
    def GetTiendaProduct(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(
            request,
            target,
            '/TiendaProductService/GetTiendaProduct',
            tiendagrpc__pb2.GetTiendaProductRequest.SerializeToString,
            tiendagrpc__pb2.GetTiendaProductResponse.FromString,
            options,
            channel_credentials,
            insecure,
            call_credentials,
            compression,
            wait_for_ready,
            timeout,
            metadata,
            _registered_method=True)

    @staticmethod
    def DeleteTiendaProduct(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(
            request,
            target,
            '/TiendaProductService/DeleteTiendaProduct',
            tiendagrpc__pb2.DeleteTiendaProductRequest.SerializeToString,
            tiendagrpc__pb2.DeleteTiendaProductResponse.FromString,
            options,
            channel_credentials,
            insecure,
            call_credentials,
            compression,
            wait_for_ready,
            timeout,
            metadata,
            _registered_method=True)

    @staticmethod
    def GetTiendasByProduct(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(
            request,
            target,
            '/TiendaProductService/GetTiendasByProduct',
            tiendagrpc__pb2.GetTiendasByProductRequest.SerializeToString,
            tiendagrpc__pb2.GetTiendasByProductResponse.FromString,
            options,
            channel_credentials,
            insecure,
            call_credentials,
            compression,
            wait_for_ready,
            timeout,
            metadata,
            _registered_method=True)

    @staticmethod
    def ObtenerProductosPorTienda(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(
            request,
            target,
            '/TiendaProductService/ObtenerProductosPorTienda',
            tiendagrpc__pb2.TiendaProductsRequest.SerializeToString,
            tiendagrpc__pb2.TiendaProductsResponse.FromString,
            options,
            channel_credentials,
            insecure,
            call_credentials,
            compression,
            wait_for_ready,
            timeout,
            metadata,
            _registered_method=True)

    @staticmethod
    def ObtenerProductos(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(
            request,
            target,
            '/TiendaProductService/ObtenerProductos',
            tiendagrpc__pb2.EmptyTienda.SerializeToString,
            tiendagrpc__pb2.TiendaProductsResponse.FromString,
            options,
            channel_credentials,
            insecure,
            call_credentials,
            compression,
            wait_for_ready,
            timeout,
            metadata,
            _registered_method=True)

    @staticmethod
    def AsociarProductos(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(
            request,
            target,
            '/TiendaProductService/AsociarProductos',
            tiendagrpc__pb2.AsociarProductosRequest.SerializeToString,
            tiendagrpc__pb2.AsociarProductosResponse.FromString,
            options,
            channel_credentials,
            insecure,
            call_credentials,
            compression,
            wait_for_ready,
            timeout,
            metadata,
            _registered_method=True)

    @staticmethod
    def UpdateTiendaProductStock(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(
            request,
            target,
            '/TiendaProductService/UpdateTiendaProductStock',
            tiendagrpc__pb2.UpdateTiendaProductStockRequest.SerializeToString,
            tiendagrpc__pb2.UpdateTiendaProductStockResponse.FromString,
            options,
            channel_credentials,
            insecure,
            call_credentials,
            compression,
            wait_for_ready,
            timeout,
            metadata,
            _registered_method=True)