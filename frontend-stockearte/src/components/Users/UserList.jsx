import React, { useContext, useEffect, useState } from "react";
import axios from "axios";
import Swal from "sweetalert2";
import { UserDetail } from "./UserDetail";
import { AuthContext } from "../../context/AuthContext";


export const UserList = () => {
  const [users, setUsers] = useState([]);
  const [stores, setStores] = useState([]);
  const [filter, setFilter] = useState({
    userName: "",
    codigoTienda: "",
  });
  const [selectedUser, setSelectedUser] = useState(null);
  const [isAddingUser, setIsAddingUser] = useState(false);
  const { user, logout } = useContext(AuthContext);
  console.log(user.email);
  
  const fetchUsers = async () => {
    const response = await axios.get("http://localhost:5000/getUsers");
    const data = response.data;
    if (Array.isArray(data.user)) {
      setUsers(data.user);
    } else {
      setUsers([]);
    }
  };
  
  const fetchStores = async () => {
    const response = await axios.get("http://localhost:5000/getTiendas");
    const data = response.data;
    setStores(Array.isArray(data.tiendasInfo) ? data.tiendasInfo : []);
  };

  useEffect(() => {
    fetchUsers();
    fetchStores();
  }, [selectedUser]);

  useEffect(() => {
    const updateUsersWithStoreInfo = () => {
      const updatedUsers = users.map(user => {
        const store = stores.find(store => Number(store.id) === Number(user.idTienda));
        return {
          ...user,
          codigoTienda: store ? store.codigo : "Empty",
          idTienda: store ? Number(store.id) : 0 // Aseguramos mantener el idTienda
        };
      });
      setUsers(updatedUsers);
    };

    if (users.length > 0 && stores.length > 0) {
      updateUsersWithStoreInfo();
    }
  }, [stores]);

  const handleFilterChange = (e) => {
    setFilter({ ...filter, [e.target.name]: e.target.value });
  };

  const filteredUsers = users.filter(
    (user) =>
      user.userName?.toLowerCase().includes(filter.userName.toLowerCase()) &&
      (user.codigoTienda || "").toLowerCase().includes(filter.codigoTienda.toLowerCase())
  );


  console.log(users);

  const handleEditUser = (user) => {
    setSelectedUser({
      ...user,
      idTienda: Number(user.idTienda),
      password: ""
    });
    setIsAddingUser(false);
  };

  const handleDeleteUser = async (userId) => {
    try {
      const result = await Swal.fire({
        title: "Are you sure?",
        text: "You won't be able to revert this!",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Yes, delete it!",
      });

      if (result.isConfirmed) {
        await axios.delete(`http://localhost:5000/deleteUser/${userId}`);
        setUsers(users.filter((user) => Number(user.id) !== userId));
        await Swal.fire("Deleted!", "The user has been deleted.", "success");
        if (Number(user.idUsuario) == userId) {
          logout(); // Cierra la sesión si es el usuario actual
        }
      }
    } catch (error) {
      Swal.fire("Error!", "There was an error deleting the user.", "error");
      console.error("Error deleting user:", error);
    }
  };

  const handleUpdateUser = async(updatedUser) => {
    console.log(updatedUser);
    // Encontrar la información de la tienda
    const store = stores.find(store => Number(store.id) === Number(updatedUser.idTienda));
    console.log(store);
    const userWithStore = {
      ...updatedUser,
      codigoTienda: store ? store.codigo : "Empty"
    };
    console.log(userWithStore);
    console.log(users);
  
    if (isAddingUser) {
      setUsers([...users, userWithStore]);
    } else {
      setUsers(users.map((u) => (Number(u.id) === Number(updatedUser.id) ? userWithStore : u)));
    }
    await fetchUsers();
    setSelectedUser(null);
    setIsAddingUser(false);

    
  };

  const handleAddUser = () => {
    setSelectedUser(null);
    setIsAddingUser(true);
  };

  return (
    <>
      <div className="container mx-auto px-4 py-8">
        <h2 className="text-2xl font-bold mb-4">Users</h2>
        {user.rol === "Casa Central" && (
          <button
            onClick={handleAddUser}
            className="mb-4 bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded"
          >
            Add User
          </button>
        )}
        <div className="mb-4 grid grid-cols-1 md:grid-cols-2 gap-4">
          <input
            type="text"
            placeholder="Filter by username"
            name="userName"
            value={filter.userName}
            onChange={handleFilterChange}
            className="border rounded px-2 py-1"
          />
          <input
            type="text"
            placeholder="Filter by store"
            name="codigoTienda"
            value={filter.codigoTienda}
            onChange={handleFilterChange}
            className="border rounded px-2 py-1"
          />
        </div>
        <table className="min-w-full bg-white">
          <thead>
            <tr>
              <th className="py-2 px-4 border-b">Username</th>
              <th className="py-2 px-4 border-b">Stores</th>
              <th className="py-2 px-4 border-b">Status</th>
              <th className="py-2 px-4 border-b">Actions</th>
            </tr>
          </thead>
          <tbody>
            {filteredUsers.map((user) => (
              <tr key={`${user.id}-${user.userName}`}>
                <td className="py-2 px-4 border-b">{user.userName}</td>
                <td className="py-2 px-4 border-b">{user.codigoTienda}</td>
                <td className="py-2 px-4 border-b">{user.activo ? "Enabled" : "Disabled"}</td>
                <td className="py-2 px-4 border-b">
                  <button
                    onClick={() => handleEditUser(user)}
                    className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-1 px-2 rounded mr-2"
                  >
                    Edit
                  </button>
                  <button
                    onClick={() => handleDeleteUser(Number(user.id))}
                    className="bg-red-500 hover:bg-red-700 text-white font-bold py-1 px-2 rounded"
                  >
                    Delete
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
      {(selectedUser || isAddingUser) && (
        <UserDetail
          user={selectedUser}
          onClose={() => {
            setSelectedUser(null);
            setIsAddingUser(false);
          }}
          onUpdate={handleUpdateUser}
          isAdding={isAddingUser}
        />
      )}
    </>
  );
};
