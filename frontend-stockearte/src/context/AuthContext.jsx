import React, { createContext, useEffect, useState } from "react";
import { mockFetch } from "../api/mockAPIContext";
import { fetchUserById } from "../api/mockAPIStoresUsers";

export const AuthContext = createContext();

export const AuthProvider = ({ children }) => {
  const [user, setUser] = useState({
    email: null,
    userName: null,
    logged: false,
    rol: null,
    idTienda: null,
    codigoTienda:null,
    idUsuario:null
  });
  useEffect(() => {
    console.log(user);
  }, [user]);
  
  const login = async (values) => {
    try {
      // 1. Autenticar usuario
      const response = await fetch("http://localhost:5000/authorize", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          userName: values.userName,
          password: values.password,
        }),
      });
      
      if (!response.ok) {
        throw new Error(`HTTP error! Status: ${response.status}`);
      }

      const data = await response.json();
      console.log(data);
      const userDetails = data.user;
      console.log(userDetails);

      // 2. Obtener información de la tienda solo si el usuario tiene idTienda
      let codigoTienda = null;
      if (userDetails.idTienda) {
        try {
          const storeResponse = await fetch(`http://localhost:5000/getTienda/${userDetails.idTienda}`);
          if (storeResponse.ok) {
            const storeData = await storeResponse.json();
            codigoTienda = storeData.codigo;
          } else {
            console.warn(`No se pudo obtener información de la tienda: ${storeResponse.status}`);
          }
        } catch (error) {
          console.warn('Error al obtener información de la tienda:', error);
          // Continuamos con el login aunque falle la obtención de la tienda
        }
      }

      // 3. Actualizar estado del usuario
      setUser({
        email: userDetails.email,
        userName: userDetails.userName,
        logged: true,
        rol: userDetails.rol,
        idTienda: userDetails.idTienda || null,
        codigoTienda: codigoTienda,
        idUsuario: userDetails.id
      });

    } catch (error) {
      console.error("Login error:", error);
      throw error; // Re-lanzar el error para manejarlo en el componente
    }
  };

  const register = async (values) => {
    try {
      const response = await fetch("http://localhost:5000/registerUser", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(values),
      });
      const text = await response.text();
      console.log("Server response:", text); // Imprimir la respuesta en texto para depuración
      const data = JSON.parse(text);
      console.log(data); // Intentar convertir a JSON
      if (response.ok) {
        setUser({ 
          email: data.email,
          userName: data.userName,
          logged: true,
          rol: data.rol,
          idTienda: data.rol === "Tienda" ? data.idTienda : null,
          codigoTienda: data.codigoTienda
        });
      } else {
        throw new Error(data.message);
      }
      
    } catch (error) {
      console.error("Registration error:", error);
    }
  };

  const logout = () => {
    setUser({
      email: null,
      userName: null,
      logged: false,
      rol: null,
      idTienda: null,
      codigoTienda: null,
    });
  };

  return (
    <>
      <AuthContext.Provider
        value={{
          user,
          login,
          register,
          logout,
        }}
      >
        {children}
      </AuthContext.Provider>
    </>
  );
};
