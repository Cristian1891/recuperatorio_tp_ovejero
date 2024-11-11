# Generated by the gRPC Python protocol compiler plugin. DO NOT EDIT!
"""Client and server classes corresponding to protobuf-defined services."""
import grpc
import warnings

import usergrpc_pb2 as usergrpc__pb2

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
        + f' but the generated code in usergrpc_pb2_grpc.py depends on'
        + f' grpcio>={GRPC_GENERATED_VERSION}.'
        + f' Please upgrade your grpc module to grpcio>={GRPC_GENERATED_VERSION}'
        + f' or downgrade your generated code using grpcio-tools<={GRPC_VERSION}.'
    )


class UserServiceStub(object):
    """Missing associated documentation comment in .proto file."""

    def __init__(self, channel):
        """Constructor.

        Args:
            channel: A grpc.Channel.
        """
        self.RegisterUser = channel.unary_unary(
                '/UserService/RegisterUser',
                request_serializer=usergrpc__pb2.RegisterUserRequest.SerializeToString,
                response_deserializer=usergrpc__pb2.GetUserResponse.FromString,
                _registered_method=True)
        self.GetUser = channel.unary_unary(
                '/UserService/GetUser',
                request_serializer=usergrpc__pb2.GetUserRequest.SerializeToString,
                response_deserializer=usergrpc__pb2.GetUserResponse.FromString,
                _registered_method=True)
        self.GetUserByTienda = channel.unary_unary(
                '/UserService/GetUserByTienda',
                request_serializer=usergrpc__pb2.GetUsersByTiendaRequest.SerializeToString,
                response_deserializer=usergrpc__pb2.GetUsersByTiendaResponse.FromString,
                _registered_method=True)
        self.DeleteUser = channel.unary_unary(
                '/UserService/DeleteUser',
                request_serializer=usergrpc__pb2.DeleteUserRequest.SerializeToString,
                response_deserializer=usergrpc__pb2.DeleteUserResponse.FromString,
                _registered_method=True)
        self.GetAllUsers = channel.unary_unary(
                '/UserService/GetAllUsers',
                request_serializer=usergrpc__pb2.Empty.SerializeToString,
                response_deserializer=usergrpc__pb2.GetAllUsersResponse.FromString,
                _registered_method=True)
        self.UpdateUser = channel.unary_unary(
                '/UserService/UpdateUser',
                request_serializer=usergrpc__pb2.UpdateUserRequest.SerializeToString,
                response_deserializer=usergrpc__pb2.GetUserResponse.FromString,
                _registered_method=True)


class UserServiceServicer(object):
    """Missing associated documentation comment in .proto file."""

    def RegisterUser(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def GetUser(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def GetUserByTienda(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def DeleteUser(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def GetAllUsers(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def UpdateUser(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')


def add_UserServiceServicer_to_server(servicer, server):
    rpc_method_handlers = {
            'RegisterUser': grpc.unary_unary_rpc_method_handler(
                    servicer.RegisterUser,
                    request_deserializer=usergrpc__pb2.RegisterUserRequest.FromString,
                    response_serializer=usergrpc__pb2.GetUserResponse.SerializeToString,
            ),
            'GetUser': grpc.unary_unary_rpc_method_handler(
                    servicer.GetUser,
                    request_deserializer=usergrpc__pb2.GetUserRequest.FromString,
                    response_serializer=usergrpc__pb2.GetUserResponse.SerializeToString,
            ),
            'GetUserByTienda': grpc.unary_unary_rpc_method_handler(
                    servicer.GetUserByTienda,
                    request_deserializer=usergrpc__pb2.GetUsersByTiendaRequest.FromString,
                    response_serializer=usergrpc__pb2.GetUsersByTiendaResponse.SerializeToString,
            ),
            'DeleteUser': grpc.unary_unary_rpc_method_handler(
                    servicer.DeleteUser,
                    request_deserializer=usergrpc__pb2.DeleteUserRequest.FromString,
                    response_serializer=usergrpc__pb2.DeleteUserResponse.SerializeToString,
            ),
            'GetAllUsers': grpc.unary_unary_rpc_method_handler(
                    servicer.GetAllUsers,
                    request_deserializer=usergrpc__pb2.Empty.FromString,
                    response_serializer=usergrpc__pb2.GetAllUsersResponse.SerializeToString,
            ),
            'UpdateUser': grpc.unary_unary_rpc_method_handler(
                    servicer.UpdateUser,
                    request_deserializer=usergrpc__pb2.UpdateUserRequest.FromString,
                    response_serializer=usergrpc__pb2.GetUserResponse.SerializeToString,
            ),
    }
    generic_handler = grpc.method_handlers_generic_handler(
            'UserService', rpc_method_handlers)
    server.add_generic_rpc_handlers((generic_handler,))
    server.add_registered_method_handlers('UserService', rpc_method_handlers)


 # This class is part of an EXPERIMENTAL API.
class UserService(object):
    """Missing associated documentation comment in .proto file."""

    @staticmethod
    def RegisterUser(request,
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
            '/UserService/RegisterUser',
            usergrpc__pb2.RegisterUserRequest.SerializeToString,
            usergrpc__pb2.GetUserResponse.FromString,
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
    def GetUser(request,
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
            '/UserService/GetUser',
            usergrpc__pb2.GetUserRequest.SerializeToString,
            usergrpc__pb2.GetUserResponse.FromString,
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
    def GetUserByTienda(request,
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
            '/UserService/GetUserByTienda',
            usergrpc__pb2.GetUsersByTiendaRequest.SerializeToString,
            usergrpc__pb2.GetUsersByTiendaResponse.FromString,
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
    def DeleteUser(request,
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
            '/UserService/DeleteUser',
            usergrpc__pb2.DeleteUserRequest.SerializeToString,
            usergrpc__pb2.DeleteUserResponse.FromString,
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
    def GetAllUsers(request,
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
            '/UserService/GetAllUsers',
            usergrpc__pb2.Empty.SerializeToString,
            usergrpc__pb2.GetAllUsersResponse.FromString,
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
    def UpdateUser(request,
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
            '/UserService/UpdateUser',
            usergrpc__pb2.UpdateUserRequest.SerializeToString,
            usergrpc__pb2.GetUserResponse.FromString,
            options,
            channel_credentials,
            insecure,
            call_credentials,
            compression,
            wait_for_ready,
            timeout,
            metadata,
            _registered_method=True)


class AuthServiceStub(object):
    """Missing associated documentation comment in .proto file."""

    def __init__(self, channel):
        """Constructor.

        Args:
            channel: A grpc.Channel.
        """
        self.authorize = channel.unary_unary(
                '/AuthService/authorize',
                request_serializer=usergrpc__pb2.JwtRequest.SerializeToString,
                response_deserializer=usergrpc__pb2.JwtToken.FromString,
                _registered_method=True)


class AuthServiceServicer(object):
    """Missing associated documentation comment in .proto file."""

    def authorize(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')


def add_AuthServiceServicer_to_server(servicer, server):
    rpc_method_handlers = {
            'authorize': grpc.unary_unary_rpc_method_handler(
                    servicer.authorize,
                    request_deserializer=usergrpc__pb2.JwtRequest.FromString,
                    response_serializer=usergrpc__pb2.JwtToken.SerializeToString,
            ),
    }
    generic_handler = grpc.method_handlers_generic_handler(
            'AuthService', rpc_method_handlers)
    server.add_generic_rpc_handlers((generic_handler,))
    server.add_registered_method_handlers('AuthService', rpc_method_handlers)


 # This class is part of an EXPERIMENTAL API.
class AuthService(object):
    """Missing associated documentation comment in .proto file."""

    @staticmethod
    def authorize(request,
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
            '/AuthService/authorize',
            usergrpc__pb2.JwtRequest.SerializeToString,
            usergrpc__pb2.JwtToken.FromString,
            options,
            channel_credentials,
            insecure,
            call_credentials,
            compression,
            wait_for_ready,
            timeout,
            metadata,
            _registered_method=True)