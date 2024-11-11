import React, { useContext, useEffect, useState } from 'react';
import { AuthContext } from '../../context/AuthContext';
import Swal from 'sweetalert2';
import axios from 'axios';
import { ProductDetail } from './ProductDetail';

export const ProductList = () => {
  const [products, setProducts] = useState([]);
  const [filter, setFilter] = useState({
    nombre: '',
    codigo: '',
  });
  const { user } = useContext(AuthContext);
  const [stores, setStores] = useState([]);
  const [selectedProduct, setSelectedProduct] = useState(null);
  const [isAddingProduct, setIsAddingProduct] = useState(false);
  const [isLoading, setIsLoading] = useState(true);
  const [loadingTimeout, setLoadingTimeout] = useState(null);
  

  const fetchProducts = async () => {
    try {
      setIsLoading(true);
      const response = await axios.get("http://localhost:5000/getProducts");
      const data = response.data;
      
      // Obtener las tiendas asociadas solo para productos existentes
      const productsWithStores = await Promise.all(
        data.productsInfo.map(async (product) => {
          try {
            const storesResponse = await axios.get(`http://localhost:5000/getTiendasByProduct/${product.id}`);
            return {
              ...product,
              associatedStores: storesResponse.data.tiendasInfo ? 
                storesResponse.data.tiendasInfo.map(tienda => tienda.id) : 
                []
            };
          } catch (error) {
            console.error(`Error fetching stores for product ${product.id}:`, error);
            return {
              ...product,
              associatedStores: []
            };
          }
        })
      );
      
      setProducts(Array.isArray(productsWithStores) ? productsWithStores : []);
      const timeout = setTimeout(() => {
        setIsLoading(false);
      }, 1000);
      setLoadingTimeout(timeout);
    } catch (error) {
      console.error('Error fetching products:', error);
      Swal.fire('Error!', 'There was an error fetching products.', 'error');
      setIsLoading(false);
      clearTimeout(loadingTimeout);
    }
  };

  const fetchProductsWithStock = async () => {
    try {
      setIsLoading(true);
      const response = await axios.get(`http://localhost:5000/obtenerProductosTiendaByTienda/${user.idTienda}`, {
        params: { idTienda: user.idTienda }
      });
      const data = response.data;
      if (data && Array.isArray(data.productos)) {
        setProducts(data.productos);
      } else {
        setProducts([]);
      }
      const timeout = setTimeout(() => {
        setIsLoading(false);
      }, 1000);
      setLoadingTimeout(timeout);
    } catch (error) {
      console.error('Error fetching products with stock:', error);
      Swal.fire('Error!', 'There was an error fetching products with stock.', 'error');
      setProducts([]);
      setIsLoading(false);
      clearTimeout(loadingTimeout);
    }
  };

  const fetchStores = async () => {
    try {
      const response = await axios.get("http://localhost:5000/getTiendas");
      const data = response.data;
      setStores(Array.isArray(data.tiendasInfo) ? data.tiendasInfo : []);
    } catch (error) {
      console.error('Error fetching stores:', error);
      Swal.fire('Error!', 'There was an error fetching stores.', 'error');
    }
  };

  useEffect(() => {
    if (user.logged) {
      if (user.rol === "Casa Central") {
        fetchProducts();
      } else if (user.rol === "Tienda") {
        fetchProductsWithStock();
      }
      fetchStores();
    }
    return () => {
      clearTimeout(loadingTimeout);
    };
  }, [user.idTienda, user.rol]);

  const handleFilterChange = (e) => {
    setFilter({ ...filter, [e.target.name]: e.target.value });
  };

  const handleEditProduct = (product) => {
    setSelectedProduct(product);
    setIsAddingProduct(false);
  };

  const getEditButtonText = () => {
    return user.rol === 'Tienda' ? 'Edit Stock' : 'Edit';
  };

  const handleAddProduct = () => {
    setSelectedProduct(null);
    setIsAddingProduct(true);
  };

  const handleDeleteProduct = async (productId) => {
    try {
      const result = await Swal.fire({
        title: "Are you sure?",
        text: "You won't be able to revert this!",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Yes, delete it!"
      });

      if (result.isConfirmed) {
        await axios.delete(`http://localhost:5000/deleteProduct/${productId}`);
        setProducts(products.filter((product) => Number(product.id) !== productId));
        await Swal.fire("Deleted!", "The product has been deleted.", "success");
      }
    } catch (error) {
      Swal.fire("Error!", "There was an error deleting the product.", "error");
      console.error("Error deleting product:", error);
    }
  };

  const handleUpdateProduct = async (updatedProduct) => {
    try {
      if (user.rol === "Tienda") {
        // Para usuarios de tienda, actualizamos usando fetchProductsWithStock
        await fetchProductsWithStock();
      } else {
        // Para Casa Central, mantenemos la lógica original
        if (isAddingProduct) {
          const newProduct = {
            ...updatedProduct,
            associatedStores: []
          };
          setProducts(prevProducts => [...prevProducts, newProduct]);
        } else {
          setProducts(prevProducts => 
            prevProducts.map(product => 
              product.id === updatedProduct.id 
                ? { ...product, ...updatedProduct, codigo: product.codigo }
                : product
            )
          );
        }
        await fetchProducts();
      }
      
      setSelectedProduct(null);
      setIsAddingProduct(false);
    } catch (error) {
      console.error('Error updating product:', error);
      Swal.fire('Error!', 'There was an error updating the product.', 'error');
    }
  };

  const handleStoreChange = (productId, selectedStoreIds) => {
    setProducts(products.map(product =>
      product.id === productId ? { ...product, associatedStores: selectedStoreIds } : product
    ));
  };

  const handleSaveAssociations = async (productId, storeIds) => {
    try {
      await axios.post("http://localhost:5000/asociarProductos", {
        productId: productId,
        tiendaIds: storeIds,
      });
      
      // Actualizamos el producto en el estado local inmediatamente
      setProducts(products.map(product =>
        product.id === productId ? 
        { ...product, associatedStores: storeIds } : 
        product
      ));
      
      Swal.fire('Success!', 'Stores associated successfully.', 'success');
    } catch (error) {
      console.error('Error associating stores:', error);
      Swal.fire('Error!', 'There was an error associating stores.', 'error');
    }
  };

  // Asegurarse de que los productos tengan las propiedades necesarias antes de filtrar
  const filteredProducts = products.filter(product =>
    product?.nombre?.toLowerCase().includes(filter.nombre.toLowerCase()) &&
    product?.codigo?.includes(filter.codigo)
  );

  if (isLoading) {
    return (
      <div className="flex justify-center items-center h-screen">
        <div className="animate-spin rounded-full h-32 w-32 border-t-2 border-b-2 border-blue-500"></div>
      </div>
    );
  }

  return (
    <div className="container mx-auto px-4 py-8">
      <h2 className="text-2xl font-bold mb-4">Products</h2>
      {user?.rol === "Casa Central" && (
        <button
          onClick={handleAddProduct}
          className="mb-4 bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded"
        >
          Add Product
        </button>
      )}
      <div className="mb-4 grid grid-cols-1 md:grid-cols-2 gap-4">
        <input
          type="text"
          placeholder="Filter by nombre"
          name="nombre"
          value={filter.nombre}
          onChange={handleFilterChange}
          className="border rounded px-2 py-1"
        />
        <input
          type="text"
          placeholder="Filter by codigo"
          name="codigo"
          value={filter.codigo}
          onChange={handleFilterChange}
          className="border rounded px-2 py-1"
        />
      </div>
      {filteredProducts.length > 0 ? (
        <table className="min-w-full bg-white">
          <thead>
            <tr>
              <th className="py-2 px-4 border-b">Nombre</th>
              <th className="py-2 px-4 border-b">Codigo</th>
              <th className="py-2 px-4 border-b">Color</th>
              <th className="py-2 px-4 border-b">Talle</th>
              {user?.rol === 'Casa Central' && (
                <>
                  <th className="py-2 px-4 border-b">Tiendas Asociadas</th>
                  <th className="py-2 px-4 border-b">Actions</th>
                </>
              )}
              {user?.rol === 'Tienda' && (
                <>
                  <th className="py-2 px-4 border-b">Stock</th>
                  <th className="py-2 px-4 border-b">Actions</th>
                </>
              )}
            </tr>
          </thead> 
          <tbody>
            {filteredProducts.map(product => (
              <tr key={`${product.id}-${product.codigo}`}>
                <td className="py-2 px-4 border-b">{product.nombre}</td>
                <td className="py-2 px-4 border-b">{product.codigo}</td>
                <td className="py-2 px-4 border-b">{product.color}</td>
                <td className="py-2 px-4 border-b">{product.talle}</td>
                {user?.rol === 'Casa Central' && (
                  <>
                    <td className="py-2 px-4 border-b">
                      <select
                        multiple
                        value={product.associatedStores?.map(String) || []}
                        onChange={e => handleStoreChange(product.id, Array.from(e.target.selectedOptions, option => Number(option.value)))}
                        className="border rounded px-2 py-1"
                      >
                        {stores.map(store => (
                          <option key={store.id} value={store.id}>
                            {store.codigo}
                          </option>
                        ))}
                      </select>
                    </td>
                    <td className="py-2 px-4 border-b">
                      <button
                        onClick={() => handleEditProduct(product)}
                        className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-1 px-2 rounded mr-2"
                      >
                        {getEditButtonText()}
                      </button>
                      <button
                        onClick={() => handleDeleteProduct(Number(product.id))}
                        className="bg-red-500 hover:bg-red-700 text-white font-bold py-1 px-2 rounded mr-2"
                      >
                        Delete
                      </button>
                      <button
                        onClick={() => handleSaveAssociations(product.id, product.associatedStores || [])}
                        className="bg-green-500 hover:bg-green-700 text-white font-bold py-1 px-2 rounded"
                      >
                        Save Associations
                      </button>
                    </td>
                  </>
                )}
                {user?.rol === 'Tienda' && (
                  <>
                    <td className="py-2 px-4 border-b">{product.stock}</td>
                    <td className="py-2 px-4 border-b">
                      <button
                        onClick={() => handleEditProduct(product)}
                        className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-1 px-2 rounded mr-2"
                      >
                        Edit Stock
                      </button>
                    </td>
                    
                  </>
                  
                )}
              </tr>
            ))}
          </tbody>
        </table>
      ) : (
        <p className="text-center text-gray-500">No products found</p>
      )}
      
      {(selectedProduct || isAddingProduct) && (
        <ProductDetail
          product={selectedProduct}
          onClose={() => {
            setSelectedProduct(null);
            setIsAddingProduct(false);
          }}
          onUpdate={handleUpdateProduct}
          isAdding={isAddingProduct}
          userRole={user?.rol || ''}
        />
      )}
    </div>
  );
};