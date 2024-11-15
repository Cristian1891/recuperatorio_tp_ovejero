import os, sys
CURRENT_DIR = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.dirname(CURRENT_DIR))

CURRENT_DIR = os.path.dirname(os.path.abspath(__file__))
PROTO_DIR = os.path.join(CURRENT_DIR, '../proto') 
sys.path.append(PROTO_DIR)



import grpc
import proto.usergrpc_pb2_grpc as usergrpc_grpc
import proto.usergrpc_pb2 as usergrpc_pb2
import proto.tiendagrpc_pb2_grpc as tiendagrpc_grpc
import proto.tiendagrpc_pb2 as tiendagrpc_pb2
import proto.productgrpc_pb2_grpc as productgrpc_grpc
import proto.productgrpc_pb2 as productgrpc_pb2
from google.protobuf.json_format import MessageToJson

class GrpcClient(object):

    def __init__(self):
        self.host = 'localhost'
        self.serverproduct_port = 9090
        self.servertienda_port = 9091
        self.serveruser_port = 9093

        self.channel = grpc.insecure_channel('{}:{}'.format(self.host, self.serveruser_port))
        self.stub = usergrpc_grpc.UserServiceStub(self.channel)

        self.channel = grpc.insecure_channel('{}:{}'.format(self.host, self.serveruser_port))
        self.auth_stub = usergrpc_grpc.AuthServiceStub(self.channel)

        self.tienda_channel = grpc.insecure_channel('{}:{}'.format(self.host, self.servertienda_port))
        self.tienda_stub = tiendagrpc_grpc.TiendaServiceStub(self.tienda_channel)

        self.orden_channel = grpc.insecure_channel('{}:{}'.format(self.host, self.servertienda_port))
        self.orden_stub = tiendagrpc_grpc.OrdenServiceStub(self.orden_channel)
        
        self.novedad_channel = grpc.insecure_channel('{}:{}'.format(self.host, self.servertienda_port))
        self.novedad_stub = tiendagrpc_grpc.NovedadesServiceStub(self.novedad_channel)

        self.tiendaProduct_channel = grpc.insecure_channel('{}:{}'.format(self.host, self.servertienda_port))
        self.tiendaProduct_stub = tiendagrpc_grpc.TiendaProductServiceStub(self.tiendaProduct_channel)

        self.product_channel = grpc.insecure_channel('{}:{}'.format(self.host, self.serverproduct_port))
        self.product_stub = productgrpc_grpc.ProductServiceStub(self.product_channel)

    ## Metodos User///////////////////

    
    def GetUserByTienda(self, idTienda):
        request = usergrpc_pb2.GetUsersByTiendaRequest(idTienda=idTienda)
        return self.stub.GetUserByTienda(request)
    
    def GetAllUsers(self):
        request = usergrpc_pb2.Empty()
        return self.stub.GetAllUsers(request)
     
    def GetUser(self, username):
        request = usergrpc_pb2.GetUserRequest(username=username)
        return self.stub.GetUser(request)
    
    def RegisterUser(self, user):
        # Handle case where idTienda is not provided or is None/empty
        id_tienda = None
        if 'idTienda' in user and user['idTienda']:
            try:
                id_tienda = int(user['idTienda'])
            except (ValueError, TypeError):
                id_tienda = None
                
        pUser = usergrpc_pb2.RegisterUserRequest(
            userName=user['userName'],
            firstName=user['firstName'],
            lastName=user['lastName'],
            email=user['email'],
            rol=user['rol'],
            idTienda=id_tienda if id_tienda is not None else 0,  # gRPC uses 0 as default for nullable numbers
            activo=user['activo'],
            password=user['password']
        )
        return self.stub.RegisterUser(pUser)
    
    def UpdateUser(self, user):
        # Verificar si hay una password válida
        should_update_password = user['password'] and user['password'].strip()
        
        pUser = usergrpc_pb2.UpdateUserRequest(
            id=int(user['id']),
            userName=user['userName'],
            firstName=user['firstName'],
            lastName=user['lastName'],
            email=user['email'], 
            rol=user['rol'],
            idTienda=int(user['idTienda']),
            activo=user['activo'],
            password=user['password']
        )
        
        # Añadir password solo si es válida
        if should_update_password:
            pUser.password = user['password']
        
        return self.stub.UpdateUser(pUser)

    def DeleteUser(self, user_id):
        request = usergrpc_pb2.DeleteUserRequest(id=user_id)
        return self.stub.DeleteUser(request)
    
    

    def authorize(self, auth):
        pAuth = usergrpc_pb2.JwtRequest(
            userName=auth['userName'],
            password=auth['password']

        )
        return self.auth_stub.authorize(pAuth)

    

    ## Metodos Tienda ///////////////////

    def ListarTiendas(self):
        request = tiendagrpc_pb2.EmptyTienda()
        return self.tienda_stub.ListarTiendas(request)
    
    def GetTienda(self, id):
        request = tiendagrpc_pb2.GetTiendaRequest(id=id)
        return self.tienda_stub.GetTienda(request) 
    
    def GetTiendasByEstado(self, estado):
        request = tiendagrpc_pb2.GetTiendaByEstadoRequest(estado=estado)
        return self.tienda_stub.GetTiendasByEstado(request)
    
    def RegistrarTienda(self, tienda):
        pTienda = tiendagrpc_pb2.RegistrarTiendaRequest(
            codigo=tienda['codigo'],
            estado=tienda['estado'],
            direccion=tienda['direccion'],
            ciudad=tienda['ciudad'],
            provincia=tienda['provincia']
        )
        return self.tienda_stub.RegistrarTienda(pTienda)
    
    def UpdateTienda(self, tienda):
        # Convertir 'estado' a booleano
        estado = tienda['estado']
        if isinstance(estado, str):
            estado_booleano = estado.lower() == "true"
        else:
            estado_booleano = bool(estado)
        
        # Crear la solicitud gRPC con el valor booleano convertido
        pTienda = tiendagrpc_pb2.UpdateTiendaRequest(
            codigo=tienda['codigo'],
            estado=estado_booleano,
            direccion=tienda['direccion'],
            ciudad=tienda['ciudad'],
            provincia=tienda['provincia']
        )
    
        return self.tienda_stub.UpdateTienda(pTienda)

    def DeleteTienda(self, tienda_id):
        request = tiendagrpc_pb2.DeleteTiendaRequest(id=tienda_id)
        return self.tienda_stub.DeleteTienda(request)
    
    def AddTiendaProduct(self, tiendaProduct):
        pTiendaProduct = tiendagrpc_pb2.AddTiendaProductRequest(
            tiendaId=tiendaProduct['tiendaId'],
            productId=tiendaProduct['productId'],
            stock=tiendaProduct['stock']
        )
        return self.tiendaProduct_stub.AddTiendaProduct(pTiendaProduct)
    
    def GetTiendaProduct(self, id):
        request = tiendagrpc_pb2.GetTiendaProductRequest(id=id)
        return self.tiendaProduct_stub.GetTiendaProduct(request)
    
    def DeleteTiendaProduct(self, id):
        request = tiendagrpc_pb2.DeleteTiendaProductRequest(id=id)
        return self.tiendaProduct_stub.DeleteTiendaProduct(request)
    
    def GetTiendasByProduct(self, productId):
        request = tiendagrpc_pb2.GetTiendasByProductRequest(productId=productId)
        return self.tiendaProduct_stub.GetTiendasByProduct(request)
    
    def ObtenerProductos(self):
        request = tiendagrpc_pb2.EmptyTienda()
        return self.tiendaProduct_stub.ObtenerProductos(request)
    
    def ObtenerProductosPorTienda(self, tiendaId):
        request = tiendagrpc_pb2.TiendaProductsRequest(tiendaId=tiendaId)
        return self.tiendaProduct_stub.ObtenerProductosPorTienda(request)
    
    def UpdateTiendaProductStock(self, data):
        pData = tiendagrpc_pb2.UpdateTiendaProductStockRequest(
			tiendaId=data['tiendaId'],
			productId=data['productId'],
			stock=data['stock']
		)
        return self.tiendaProduct_stub.UpdateTiendaProductStock(pData)
    
    def AsociarProductos(self, tiendaProducts):
        tiendaIds = list(map(int, tiendaProducts['tiendaIds']))
    
        request_data = tiendagrpc_pb2.AsociarProductosRequest(
            tiendaIds=tiendaIds,
            productId=int(tiendaProducts['productId']) 
        )
    
        print(f"Enviando datos: {request_data}")
        return self.tiendaProduct_stub.AsociarProductos(request_data)
    
    ## Metodos de Ordenes///////////////////

    def CreateOrder(self, orden):
        items = [
            tiendagrpc_pb2.ItemOrdenDtoGrpc(
                codigoArticulo=item['codigoArticulo'],
                color=item['color'],
                talle=item['talle'],
                cantidadSolicitada=item['cantidadSolicitada'])
            for item in orden['itemOrdenDtoGrpc']
        ]	

        pOrden = tiendagrpc_pb2.CreateOrderRequest(
            codigoTienda=orden['codigoTienda'],
            observaciones=orden['observaciones'],
            itemOrdenDtoGrpc=items
          
        )
        return self.orden_stub.CreateOrder(pOrden)
    
    def ChangeOrderState(self, id):
        request = tiendagrpc_pb2.ChangeOrderStateRequest(id=id)
        return self.orden_stub.ChangeOrderState(request)
    
    ## Metodos de Novedades///////////////////

    def ObtenerNovedades(self):
        request = tiendagrpc_pb2.EmptyNovedad()
        return self.novedad_stub.ListarNovedades(request)
    
    def DeleteNovedad(self, id):
        request = tiendagrpc_pb2.DeleteNovedadRequest(id=id)
        return self.novedad_stub.DeleteNovedad(request)
    
    
        
    ## Metodos Product ///////////////////

    def GetAllProducts(self):
        request = productgrpc_pb2.EmptyProduct()
        return self.product_stub.GetAllProducts(request)
    
    def GetProduct(self, id):
        request = productgrpc_pb2.GetProductRequest(id=id)
        return self.product_stub.GetProduct(request)
    
    def GetProductByNombre(self, nombre):
        request = productgrpc_pb2.GetProductByNombreRequest(nombre=nombre)
        return self.product_stub.GetProductByNombre(request)
    
    def CreateProduct(self, product):
        pProduct = productgrpc_pb2.CreateProductRequest(
            codigo=product['codigo'],
            nombre=product['nombre'],
            foto=product['foto'],
            color=product['color'],
            talle=product['talle']
        )
        return self.product_stub.CreateProduct(pProduct)
    
    def UpdateProduct(self, product):
        pProduct = productgrpc_pb2.UpdateProductRequest(
            codigo=product['codigo'],
            nombre=product['nombre'],
            foto=product['foto'],
            color=product['color'],
            talle=product['talle']
        )
        return self.product_stub.UpdateProduct(pProduct)

    def DeleteProduct(self, id):
        request = productgrpc_pb2.DeleteProductRequest(id=id)
        return self.product_stub.DeleteProduct(request)
    
    
    

if __name__ == '__main__':
    client = GrpcClient()
    result = client.GetUser() 
    print(MessageToJson(result))
     