import React, { useState, useEffect, useContext } from 'react';
import Swal from 'sweetalert2';
import { AuthContext } from '../../context/AuthContext';

export const ProductDetail = ({ product, onClose, onUpdate, isAdding, userRole }) => {
  const { user } = useContext(AuthContext);
  const [productData, setProductData] = useState({
    nombre: '',
    codigo: '',
    foto: '',
    talle: '',
    color: '',
    stock: 0
  });

  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (!isAdding && product) {
      setProductData({
        nombre: product.nombre,
        codigo: product.codigo,
        foto: product.foto,
        talle: product.talle,
        color: product.color,
        stock: product.stock || 0
      });
    } else if (isAdding) {
      setProductData({
        nombre: '',
        codigo: generateProductCode(),
        foto: '',
        talle: '',
        color: '',
        stock: 0
      });
    }
    setLoading(false);
  }, [product, isAdding]);

  const generateProductCode = () => {
    // Combina Math.random con Date.now para mayor unicidad
    return (Math.random().toString(36) + Date.now().toString(36)).substring(2, 12).toUpperCase();
  };

  console.log(product);

  const handleProductSubmit = async (e) => {
    e.preventDefault();
    try {
      let endpoint;
      let data;

      if (userRole === 'Tienda') {
        endpoint = `http://localhost:5000/updateProductStock`;
        data = {
          productId: Number(product.productoId),
          tiendaId: Number(product.tiendaId),
          stock: Number(productData.stock)
        };
      } else {
        endpoint = isAdding 
          ? 'http://localhost:5000/registerProduct'
          : `http://localhost:5000/updateProduct`;
        data = productData;
      }

      const response = await fetch(endpoint, {
        method: isAdding ? 'POST' : 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data),
      });

      console.log(response);

      if (response.ok) {
        // const resultProduct = await response.json();
        
        if (!isAdding) {
          onUpdate({
              ...product,
              stock: productData.stock
          });
        } else {
            onUpdate(productData);
        }
        
        onClose();
        Swal.fire('Success!', `Product ${isAdding ? 'created' : 'updated'} successfully.`, 'success');
      }
    } catch (error) {
      console.error('Error:', error);
      Swal.fire('Error!', `Error ${isAdding ? 'creating' : 'updating'} the product.`, 'error');
    }
  };

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setProductData((prevData) => ({
      ...prevData,
      [name]: value,
    }));
  };

  if (loading) {
    return (
      <div className="fixed inset-0 bg-gray-600 bg-opacity-50 flex items-center justify-center">
        <div className="animate-spin rounded-full h-32 w-32 border-t-2 border-b-2 border-blue-500"></div>
      </div>
    );
  }

  return (
    <div className="fixed inset-0 bg-gray-600 bg-opacity-50 overflow-y-auto h-full w-full" style={{ zIndex: 1000 }}>
      <div className="relative p-8 border w-full max-w-2xl mx-auto my-10 shadow-lg rounded-md bg-white">
        <button 
          onClick={onClose} 
          className="absolute top-2 right-2 text-gray-600 hover:text-gray-800"
          type="button"
        >
          &times;
        </button>
        <h3 className="text-2xl font-bold mb-6">
          {userRole === 'Tienda' 
            ? 'Edit Product Stock' 
            : (isAdding ? 'Add New Product' : 'Edit Product')}
        </h3>
        
        <form onSubmit={handleProductSubmit} className="space-y-4">
          {userRole === 'Tienda' ? (
            // Form for store users - only stock modification
            <div>
              <label htmlFor="stock" className="block text-sm font-medium text-gray-700 mb-1">
                Stock
              </label>
              <input
                id="stock"
                name="stock"
                type="number"
                min="0"
                value={productData.stock}
                onChange={handleInputChange}
                className="w-full px-4 py-2 border rounded-md"
                required
              />
            </div>
          ) : (
            // Form for central office users - all fields except stock
            <>
              <div>
                <label htmlFor="nombre" className="block text-sm font-medium text-gray-700 mb-1">
                  Nombre
                </label>
                <input
                  id="nombre"
                  name="nombre"
                  type="text"
                  value={productData.nombre}
                  onChange={handleInputChange}
                  className="w-full px-4 py-2 border rounded-md"
                  required
                />
              </div>

              <div>
                <label htmlFor="codigo" className="block text-sm font-medium text-gray-700 mb-1">
                  Código
                </label>
                <input
                  id="codigo"
                  name="codigo"
                  type="text"
                  value={productData.codigo}
                  readOnly
                  className="w-full px-4 py-2 border rounded-md bg-gray-100"
                />
              </div>

              <div>
                <label htmlFor="foto" className="block text-sm font-medium text-gray-700 mb-1">
                  Foto (URL)
                </label>
                <input
                  id="foto"
                  name="foto"
                  type="text"
                  value={productData.foto}
                  onChange={handleInputChange}
                  className="w-full px-4 py-2 border rounded-md"
                  required
                />
              </div>

              <div>
                <label htmlFor="talle" className="block text-sm font-medium text-gray-700 mb-1">
                  Talle
                </label>
                <input
                  id="talle"
                  name="talle"
                  type="text"
                  value={productData.talle}
                  onChange={handleInputChange}
                  className="w-full px-4 py-2 border rounded-md"
                  required
                />
              </div>

              <div>
                <label htmlFor="color" className="block text-sm font-medium text-gray-700 mb-1">
                  Color
                </label>
                <input
                  id="color"
                  name="color"
                  type="text"
                  value={productData.color}
                  onChange={handleInputChange}
                  className="w-full px-4 py-2 border rounded-md"
                  required
                />
              </div>
            </>
          )}

          <button 
            type="submit" 
            className="bg-blue-500 text-white px-4 py-2 rounded-md hover:bg-blue-600"
          >
            {userRole === 'Tienda' 
              ? 'Update Stock'
              : (isAdding ? 'Add Product' : 'Update Product')}
          </button>
        </form>
      </div>
    </div>
  );
};