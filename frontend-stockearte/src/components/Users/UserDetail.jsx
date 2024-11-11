import React, { useState, useEffect } from "react";
import axios from "axios";
import { useNavigate } from "react-router-dom";
import { X } from "lucide-react";
import Swal from "sweetalert2";


export const UserDetail = ({ user, onClose, onUpdate, isAdding }) => {
  
  const [userData, setUserData] = useState({
    id: 0,
    userName: "",
    firstName: "",
    lastName: "",
    email: "",
    rol: "Tienda",
    idTienda: 0,
    activo: false,
    password: "",
  });
  
  const navigate = useNavigate();
  const [stores, setStores] = useState([]);

  const fetchStores = async () => {
    try {
      const response = await axios.get("http://localhost:5000/getTiendas");
      const data = response.data;
      setStores(Array.isArray(data.tiendasInfo) ? data.tiendasInfo : []);
    } catch (error) {
      console.error("Error fetching stores:", error);
    }
  };

  useEffect(() => {
    fetchStores();
    if (user) {
      setUserData({
        ...user,
        idTienda: Number(user.idTienda),
        activo: Boolean(user.activo),
        password: ""
      });
    }
  }, [user]);

  const handleChange = (e) => {
    const { name, value, type, checked } = e.target;
    let finalValue = value;
    
    // Manejo especial para idTienda
    if (name === 'idTienda') {
      finalValue = value === "" ? 0 : Number(value);
    }

    setUserData((prevData) => ({
      ...prevData,
      [name]: type === "checkbox" ? checked : finalValue,
    }));
  };

  const createUser = async (userData) => {
    try {
      const result = await Swal.fire({
        title: 'Create User',
        text: 'Are you sure you want to create this user?',
        icon: 'question',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, create it!'
      });

      if (result.isConfirmed) {
        const response = await axios.post(
          "http://localhost:5000/registerUser",
          userData
        );
        console.log("Usuario creado:", response.data);
        await Swal.fire(
          'Created!',
          'The user has been created successfully.',
          'success'
        );
        onUpdate(response.data);
        onClose();
      }
    } catch (error) {
      console.error("Error al crear el usuario:", error);
      await Swal.fire(
        'Error!',
        error.response?.data?.message || 'Error creating user',
        'error'
      );
    }
  };

  const updateUser = async (userData) => {
    try {
      const result = await Swal.fire({
        title: 'Update User',
        text: 'Are you sure you want to update this user?',
        icon: 'question',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, update it!'
      });
  
      if (result.isConfirmed) {
        // Asegurar que los datos tengan el formato correcto
        const { codigoTienda, ...dataToSend } = {
          ...userData,
          id: Number(userData.id),
          idTienda: Number(userData.idTienda),
          activo: Boolean(userData.activo)
        };

        console.log(dataToSend);

        
        const response = await axios.put(
          "http://localhost:5000/updateUser",
          dataToSend
        );

        console.log(response.data);
        
        if (response.data) {
          await Swal.fire(
            'Updated!',
            'The user has been updated successfully.',
            'success'
          );
          
          // Asegurarse de que los datos devueltos tengan el formato correcto
          const updatedData = {
            ...response.data,
            id: Number(userData.id),
            idTienda: Number(userData.idTienda),
            activo: Boolean(userData.activo)
          };

          console.log(updatedData);
          
          onUpdate(updatedData);
          onClose();
        }
      }
    } catch (error) {
      console.error("Error updating user:", error);
      await Swal.fire(
        'Error!',
        error.response?.data?.message || 'Error updating user',
        'error'
      );
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      if (isAdding) {
        await createUser(userData);
      } else {
        await updateUser(userData);
      }
    } catch (error) {
      // El error ya se maneja en las funciones createUser y updateUser
      return;
    }
  };

  return (
    <div className="fixed inset-0 bg-gray-600 bg-opacity-50 overflow-y-auto h-full w-full flex justify-center items-center">
      <div className="relative p-8 border w-full max-w-4xl shadow-lg rounded-md bg-white">
        {/* Close button */}
        <button 
          onClick={onClose}
          className="absolute right-4 top-4 text-gray-500 hover:text-gray-700"
        >
          <X size={24} />
        </button>

        {/* Centered title */}
        <h3 className="text-2xl font-bold mb-6 text-center">
          {isAdding ? "Add User" : "Edit User"}
        </h3>

        <form onSubmit={handleSubmit} className="space-y-6">
          {/* Two-column grid for form inputs */}
          <div className="grid grid-cols-2 gap-6">
            {/* Left column */}
            <div className="space-y-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  Username
                </label>
                <input
                  name="userName"
                  type="text"
                  value={userData.userName}
                  onChange={handleChange}
                  className="w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                  required
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  Email
                </label>
                <input
                  name="email"
                  type="email"
                  value={userData.email}
                  onChange={handleChange}
                  className="w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                  required
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  First Name
                </label>
                <input
                  name="firstName"
                  type="text"
                  value={userData.firstName}
                  onChange={handleChange}
                  className="w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                  required
                />
              </div>
            </div>

            {/* Right column */}
            <div className="space-y-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  Last Name
                </label>
                <input
                  name="lastName"
                  type="text"
                  value={userData.lastName}
                  onChange={handleChange}
                  className="w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                  required
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  Password
                </label>
                <input
                  name="password"
                  type="password"
                  value={userData.password}
                  onChange={handleChange}
                  className="w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                  required={isAdding}
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  Store
                </label>
                <select
                  name="idTienda"
                  value={userData.idTienda}
                  onChange={handleChange}
                  className="w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                  required
                >
                  <option value="">Select Store</option>
                  {stores.map((store) => (
                    <option key={`${store.id}-${store.direccion}`} value={Number(store.id)}>
                      {store.codigo}
                    </option>
                  ))}
                </select>
              </div>
            </div>
          </div>

          {/* Status checkbox */}
          <div className="flex justify-center items-center space-x-2">
            <input
              type="checkbox"
              id="status"
              name="activo"
              checked={Boolean(userData.activo)}
              onChange={handleChange}
              className="w-4 h-4 text-blue-600 rounded focus:ring-blue-500"
            />
            <label htmlFor="status" className="text-sm font-medium text-gray-700">
              Status
            </label>
          </div>

          {/* Centered buttons */}
          <div className="flex justify-center space-x-4">
            <button
              type="button"
              onClick={onClose}
              className="px-6 py-2 border border-gray-300 rounded-md text-gray-700 hover:bg-gray-50"
            >
              Cancel
            </button>
            <button
              type="submit"
              className="px-6 py-2 bg-blue-600 text-white font-semibold rounded-md hover:bg-blue-700"
            >
              {isAdding ? "Add User" : "Update User"}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};
