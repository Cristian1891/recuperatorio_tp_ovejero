import React, { useContext, useEffect, useState } from 'react';
import { AuthContext } from '../../context/AuthContext';

interface PurchaseOrder {
  codigoArticulo: string;
  estado: string | null;
  codigoTienda: string;
  totalCantidadSolicitada: number;
}

interface FilterParams {
  codigoArticulo?: string;
  fechaDesde?: string;
  fechaHasta?: string;
  estado?: string;
  codigoTienda?: string;
}

interface SavedFilter {
  id: string;
  nombre: string;
  codigoArticulo?: string;
  fechaDesde?: string;
  fechaHasta?: string;
  estado?: string;
  codigoTienda?: string;
}

export const PurchaseOrders: React.FC = () => {
  const [purchaseOrders, setPurchaseOrders] = useState<PurchaseOrder[]>([]);
  const [filters, setFilters] = useState<FilterParams>({});
  const [startDate, setStartDate] = useState<string>("");
  const [endDate, setEndDate] = useState<string>("");
  const { user } = useContext(AuthContext);
  const [initialFetch, setInitialFetch] = useState(false);
  const [savedFilters, setSavedFilters] = useState<SavedFilter[]>([]);
  const [selectedFilter, setSelectedFilter] = useState<string>("");
  const [filterName, setFilterName] = useState<string>("");
  const [isEditing, setIsEditing] = useState(false);

  useEffect(() => {
    if (user.rol === "Tienda" && user.codigoTienda) {
      setFilters((prev) => ({
        ...prev,
        codigoTienda: user.codigoTienda,
      }));
    }
    setInitialFetch(true);
    fetchSavedFilters();
  }, [user]);

  useEffect(() => {
    if (initialFetch) {
      fetchPurchaseOrders();
    }
  }, [filters, initialFetch]);

  const fetchPurchaseOrders = async () => {
    try {
      const response = await fetch("http://localhost:8085/getAllOrders", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(filters),
      });

      if (!response.ok) {
        throw new Error(`HTTP error! Status: ${response.status}`);
      }

      const data = await response.json();
      setPurchaseOrders(data.ordenComprasResumen);
    } catch (error) {
      console.error("Error fetching purchase orders:", error);
    }
  };

  const fetchSavedFilters = async () => {
    try {
      const response = await fetch("http://localhost:8085/getAllFiltros", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          idUsuario: Number(user.idUsuario),
        }),
      });
      
      const data = await response.json();
      setSavedFilters(data.filtro);
    } catch (error) {
      console.error("Error fetching saved filters:", error);
    }
  };

  const handleFilterChange = (name: string, value: string) => {
    if (user.rol === "Tienda" && name === "codigoTienda") {
      return;
    }
    setFilters((prev) => ({
      ...prev,
      [name]: value || undefined,
    }));
  };

  const handleDateChange = (name: string, value: string) => {
    if (name === "fechaDesde") {
      setStartDate(value);
    } else {
      setEndDate(value);
    }
    handleFilterChange(name, value);
  };

  const applyFilters = () => {
    fetchPurchaseOrders();
  };

  const handleSavedFilterChange = (e: React.ChangeEvent<HTMLSelectElement>) => {
    const filterId = e.target.value;
    setSelectedFilter(filterId);
  
    const filter = savedFilters.find(f => f.id.toString() === filterId);
  
    if (filter) {
      setFilters({
        codigoArticulo: filter.codigoArticulo || "",
        fechaDesde: filter.fechaDesde || "",
        fechaHasta: filter.fechaHasta || "",
        estado: filter.estado || "",
        codigoTienda: user.rol === "Tienda" ? filters?.codigoTienda || "" : filter.codigoTienda || "",
      });
  
      setStartDate(filter.fechaDesde || "");
      setEndDate(filter.fechaHasta || "");
      setFilterName(filter.nombre);
    }
  };

  const saveFilter = async () => {
    if (!filterName) {
      alert("Please enter a name for the filter");
      return;
    }
    const newFilter = { ...filters, nombre: filterName, idUsuario: user.idUsuario };
    try {
      const response = await fetch("http://localhost:8085/addFiltro", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(newFilter),
      });
      if (!response.ok) {
        throw new Error(`HTTP error! Status: ${response.status}`);
      }
      fetchSavedFilters();
      setFilterName("");
      setIsEditing(false);
    } catch (error) {
      console.error("Error saving filter:", error);
    }
  };

  const modifyFilter = async () => {
    if (!selectedFilter || !filterName) {
      alert("Please select a filter and enter a name");
      return;
    }
    const updatedFilter = {
      id: Number(selectedFilter),
      nombre: filterName,
      idUsuario: user.idUsuario,
      ...filters
    };
    try {
      const response = await fetch("http://localhost:8085/modificarFiltro", {
        method: "PUT",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(updatedFilter),
      });
      if (!response.ok) {
        throw new Error(`HTTP error! Status: ${response.status}`);
      }
      fetchSavedFilters();
      setIsEditing(false);
    } catch (error) {
      console.error("Error modifying filter:", error);
    }
  };

  const deleteFilter = async () => {
    if (!selectedFilter) {
      alert("Please select a filter to delete");
      return;
    }
    try {
      const response = await fetch(`http://localhost:8085/eliminarFiltro/${selectedFilter}`, {
        method: "DELETE",
      });
      if (!response.ok) {
        throw new Error(`HTTP error! Status: ${response.status}`);
      }
      fetchSavedFilters();
      setSelectedFilter("");
      setFilterName("");
      setIsEditing(false);
    } catch (error) {
      console.error("Error deleting filter:", error);
    }
  };

  return (
    <div className="container mx-auto p-4">
      <h1 className="text-2xl font-bold mb-4">Purchase Orders</h1>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-5 gap-4 mb-4">
        <div>
          <label htmlFor="savedFilters" className="block text-sm font-medium text-gray-700 mb-1">
            Saved Filters
          </label>
          <select
            id="savedFilters"
            className="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
            value={selectedFilter}
            onChange={handleSavedFilterChange}
          >
            <option value="">Select a saved filter</option>
            {savedFilters.map((filter) => (
              <option key={filter.id} value={filter.id}>
                {filter.nombre}
              </option>
            ))}
          </select>
        </div>

        <div>
          <label htmlFor="codigoArticulo" className="block text-sm font-medium text-gray-700 mb-1">
            Product Code
          </label>
          <input
            type="text"
            id="codigoArticulo"
            className="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
            value={filters.codigoArticulo || ""}
            onChange={(e) => handleFilterChange("codigoArticulo", e.target.value)}
            placeholder="Enter product code"
          />
        </div>

        <div>
          <label htmlFor="fechaDesde" className="block text-sm font-medium text-gray-700 mb-1">
            Start Date
          </label>
          <input
            type="date"
            id="fechaDesde"
            className="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
            value={startDate}
            onChange={(e) => handleDateChange("fechaDesde", e.target.value)}
          />
        </div>

        <div>
          <label htmlFor="fechaHasta" className="block text-sm font-medium text-gray-700 mb-1">
            End Date
          </label>
          <input
            type="date"
            id="fechaHasta"
            className="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
            value={endDate}
            onChange={(e) => handleDateChange("fechaHasta", e.target.value)}
          />
        </div>

        <div>
          <label htmlFor="estado" className="block text-sm font-medium text-gray-700 mb-1">
            Status
          </label>
          <select
            id="estado"
            className="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
            value={filters.estado || ""}
            onChange={(e) => handleFilterChange("estado", e.target.value)}
          >
            <option value="">Seleccione el Estado</option>
            <option value="ACEPTADA">ACEPTADA</option>
            <option value="RECHAZADA">RECHAZADA</option>
            <option value="SOLICITADA">SOLICITADA</option>
            <option value="RECIBIDA">RECIBIDA</option>
          </select>
        </div>

        {user.rol !== "Tienda" && (
          <div>
            <label htmlFor="codigoTienda" className="block text-sm font-medium text-gray-700 mb-1">
              Store
            </label>
            <input
              type="text"
              id="codigoTienda"
              className="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
              value={filters.codigoTienda || ""}
              onChange={(e) => handleFilterChange("codigoTienda", e.target.value)}
              placeholder="Enter store code"
              disabled={user.rol === "Tienda"}
            />
          </div>
        )}
      </div>

      <div className="flex gap-4 mb-4">
        <button
          onClick={applyFilters}
          className="px-4 py-2 bg-indigo-600 text-white rounded-md hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
        >
          Apply Filters
        </button>

        <input
          type="text"
          placeholder="Filter name"
          value={filterName}
          onChange={(e) => setFilterName(e.target.value)}
          className="px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
        />

        {isEditing ? (
          <>
            <button
              onClick={modifyFilter}
              className="px-4 py-2 bg-yellow-600 text-white rounded-md hover:bg-yellow-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-yellow-500"
            >
              Modify Filter
            </button>
            <button
              onClick={() => setIsEditing(false)}
              className="px-4 py-2 bg-gray-600 text-white rounded-md hover:bg-gray-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-500"
            >
              Cancel
            </button>
          </>
        ) : (
          <button
            onClick={saveFilter}
            className="px-4 py-2 bg-green-600 text-white rounded-md hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500"
          >
            Save Filter
          </button>
        )}

        <button
          onClick={() => setIsEditing(true)}
          className="px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
        >
          Edit Filter
        </button>

        <button
          onClick={deleteFilter}
          className="px-4 py-2 bg-red-600 text-white rounded-md hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500"
        >
          Delete Filter
        </button>
      </div>

      <div className="overflow-x-auto">
        <table className="min-w-full divide-y divide-gray-200">
          <thead className="bg-gray-50">
            <tr>
              <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Product Code
              </th>
              <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Status
              </th>
              <th className="px-6 py-3 text-left text-xs font-medium text-gray-500  uppercase tracking-wider">
                Store Code
              </th>
              <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Total Quantity Requested
              </th>
            </tr>
          </thead>
          <tbody className="bg-white divide-y divide-gray-200">
            {purchaseOrders.map((order, index) => (
              <tr key={index}>
                <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                  {order.codigoArticulo}
                </td>
                <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                  {order.estado || "N/A"}
                </td>
                <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                  {order.codigoTienda}
                </td>
                <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                  {order.totalCantidadSolicitada}
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
};