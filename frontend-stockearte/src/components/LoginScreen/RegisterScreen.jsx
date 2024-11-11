import { React, useContext, useState } from "react";
import { AuthContext } from "../../context/AuthContext";
import { Link } from "react-router-dom";

export const RegisterScreen = () => {
  const { register } = useContext(AuthContext);

  const [formData, setFormData] = useState({
    userName: "",
    firstName: "",
    lastName: "",
    email: "",
    rol: "Tienda",
    codigoTienda: "",
    activo: true,
    password: "",
  });

  const handleChange = (e) => {
    const { name, value, type, checked } = e.target;
    setFormData((prevState) => ({
      ...prevState,
      [name]: type === "checkbox" ? checked : value,
    }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      await register(formData);
      // Handle successful registration (e.g., show a success message, redirect)
    } catch (error) {
      // Handle registration error (e.g., show error message)
      console.error("Registration failed:", error);
    }
  };



  return (
    <>
      <div className="flex items-center justify-center min-h-screen bg-gray-100">
        <div className="px-8 py-6 mt-4 text-left bg-white shadow-lg w-full max-w-4xl">
          <h3 className="text-2xl font-bold text-center mb-6">
            Register a new account
          </h3>
          <form onSubmit={handleSubmit}>
            <div className="grid grid-cols-2 gap-6">
              {/* Left Column */}
              <div className="space-y-4">
                <div>
                  <label className="block" htmlFor="userName">
                    Username
                  </label>
                  <input
                    type="text"
                    placeholder="Username"
                    className="w-full px-4 py-2 mt-2 border rounded-md focus:outline-none focus:ring-1 focus:ring-blue-600"
                    name="userName"
                    value={formData.userName}
                    onChange={handleChange}
                  />
                </div>
                <div>
                  <label className="block" htmlFor="email">
                    Email
                  </label>
                  <input
                    type="text"
                    placeholder="Email"
                    className="w-full px-4 py-2 mt-2 border rounded-md focus:outline-none focus:ring-1 focus:ring-blue-600"
                    name="email"
                    value={formData.email}
                    onChange={handleChange}
                  />
                </div>
                <div>
                  <label className="block">Password</label>
                  <input
                    type="password"
                    placeholder="Password"
                    className="w-full px-4 py-2 mt-2 border rounded-md focus:outline-none focus:ring-1 focus:ring-blue-600"
                    name="password"
                    value={formData.password}
                    onChange={handleChange}
                  />
                </div>
              </div>

              {/* Right Column */}
              <div className="space-y-4">
                <div>
                  <label className="block">Name</label>
                  <input
                    type="text"
                    placeholder="Name"
                    className="w-full px-4 py-2 mt-2 border rounded-md focus:outline-none focus:ring-1 focus:ring-blue-600"
                    name="firstName"
                    value={formData.firstName}
                    onChange={handleChange}
                  />
                </div>
                <div>
                  <label className="block">Surname</label>
                  <input
                    type="text"
                    placeholder="Surname"
                    className="w-full px-4 py-2 mt-2 border rounded-md focus:outline-none focus:ring-1 focus:ring-blue-600"
                    name="lastName"
                    value={formData.lastName}
                    onChange={handleChange}
                  />
                </div>
                <div>
                  <label className="block">Role</label>
                  <select
                    className="w-full px-4 py-2 mt-2 border rounded-md focus:outline-none focus:ring-1 focus:ring-blue-600"
                    name="rol"
                    value={formData.rol}
                    onChange={handleChange}
                  >
                    <option value="Tienda">Store</option>
                    <option value="Casa Central">Central</option>
                  </select>
                </div>
              </div>
            </div>

            {/* Checkbox and Buttons - Centered at bottom */}
            <div className="mt-6 flex flex-col items-center">
              <label className="flex items-center mb-4">
                <input
                  type="checkbox"
                  name="activo"
                  checked={formData.activo}
                  onChange={handleChange}
                  className="mr-2"
                />
                Enabled
              </label>
              <div className="flex items-center space-x-4">
                <button className="px-6 py-2 text-white bg-blue-600 rounded-lg hover:bg-blue-900">
                  Register
                </button>
                <Link to="/login" className="text-sm text-blue-600 hover:underline">
                  Already have an account? Login
                </Link>
              </div>
            </div>
          </form>
        </div>
      </div>
    </>
  );
};
