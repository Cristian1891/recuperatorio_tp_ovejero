import { useState } from 'react';
import { AlertCircle, CheckCircle2, Loader2 } from 'lucide-react';
import React from 'react';

interface ProductErrorResponse {
  lineNumber: number;
  codigo: string;
  color: string;
  talle: string;
  errorMessage: string;
}

interface TiendasAsignadas {
  tienda: string[];
}

interface ProductSuccessResponse {
  codigo: string;
  nombre: string;
  color: string;
  talle: string;
  foto: string;
  tiendasAsignadas: TiendasAsignadas;
}

interface UploadResponse {
  createdProducts: ProductSuccessResponse[];
  errors: ProductErrorResponse[];
}

const formatTiendas = (tiendasAsignadas: TiendasAsignadas | null): string => {
  if (!tiendasAsignadas || !tiendasAsignadas.tienda) return '';
  return Array.isArray(tiendasAsignadas.tienda) 
    ? tiendasAsignadas.tienda.join(', ') 
    : '';
};

export default function CsvProductsUpload() {
  const [file, setFile] = useState<File | null>(null);
  const [errors, setErrors] = useState<ProductErrorResponse[]>([]);
  const [successes, setSuccesses] = useState<ProductSuccessResponse[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [uploadStatus, setUploadStatus] = useState<'idle' | 'success' | 'error'>('idle');

  const handleFileChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    const selectedFile = event.target.files?.[0];
    if (selectedFile && selectedFile.name.endsWith('.csv')) {
      setFile(selectedFile);
      setUploadStatus('idle');
      setErrors([]);
      setSuccesses([]);
    } else {
      alert('Por favor seleccione un archivo CSV válido');
    }
  };

  const encodeFileToBase64 = (file: File): Promise<string> => {
    return new Promise((resolve, reject) => {
      const reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = () => {
        if (typeof reader.result === 'string') {
          const base64String = reader.result.split(',')[1];
          resolve(base64String);
        } else {
          reject(new Error('Error al codificar el archivo'));
        }
      };
      reader.onerror = error => reject(error);
    });
  };

  const handleSubmit = async (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    if (!file) {
      alert('Por favor seleccione un archivo CSV');
      return;
    }

    setIsLoading(true);
    setErrors([]);
    setSuccesses([]);
    setUploadStatus('idle');

    try {
      const base64Data = await encodeFileToBase64(file);
      const response = await fetch('http://localhost:8085/addProductsCsv', {
        method: 'POST',
        credentials: 'include',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ csvData: base64Data }),
      });

      if (!response.ok) {
        throw new Error(`Error ${response.status}: ${response.statusText}`);
      }

      const data: UploadResponse = await response.json();
      console.log('Received data:', JSON.stringify(data, null, 2));  // Para debugging
      
      setErrors(data.errors || []);
      setSuccesses(data.createdProducts || []);
      setUploadStatus(data.errors.length === 0 ? 'success' : 'error');
    } catch (error) {
      console.error('Error al procesar el archivo:', error);
      setUploadStatus('error');
      alert('Ocurrió un error al procesar el archivo. Por favor intente nuevamente.');
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="container mx-auto p-4 max-w-7xl">
      <div className="bg-white shadow-lg rounded-lg p-6">
        <h1 className="text-2xl font-bold mb-6 text-gray-800">
          Carga Masiva de Productos
        </h1>

        <form onSubmit={handleSubmit} className="space-y-4 mb-8">
          <div className="border-2 border-dashed border-gray-300 rounded-lg p-6">
            <label 
              htmlFor="csvFile"
              className="flex flex-col items-center justify-center cursor-pointer"
            >
              <div className="text-center">
                <span className="text-gray-600">
                  {file ? file.name : 'Seleccione o arrastre un archivo CSV'}
                </span>
                <p className="text-sm text-gray-500 mt-1">
                  Solo archivos CSV
                </p>
              </div>
              <input
                type="file"
                id="csvFile"
                accept=".csv"
                onChange={handleFileChange}
                className="hidden"
              />
            </label>
          </div>

          <button
            type="submit"
            disabled={!file || isLoading}
            className="w-full flex items-center justify-center gap-2 bg-blue-600 hover:bg-blue-700 text-white font-semibold py-3 px-4 rounded-lg disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
          >
            {isLoading ? (
              <>
                <Loader2 className="w-5 h-5 animate-spin" />
                Procesando...
              </>
            ) : (
              'Cargar Productos'
            )}
          </button>
        </form>

        {/* Resumen de resultados */}
        {(successes.length > 0 || errors.length > 0) && (
          <div className="mb-6">
            <h2 className="text-lg font-semibold mb-2">Resumen del Proceso</h2>
            <div className="flex gap-4">
              <div className="flex items-center gap-2 text-green-600">
                <CheckCircle2 className="w-5 h-5" />
                <span>{successes.length} productos creados</span>
              </div>
              {errors.length > 0 && (
                <div className="flex items-center gap-2 text-red-600">
                  <AlertCircle className="w-5 h-5" />
                  <span>{errors.length} errores encontrados</span>
                </div>
              )}
            </div>
          </div>
        )}

        {/* Tabla de productos creados exitosamente */}
        {successes.length > 0 && (
          <div className="mb-8">
            <h2 className="text-xl font-semibold mb-4 text-green-600 flex items-center gap-2">
              <CheckCircle2 className="w-6 h-6" />
              Productos Creados Exitosamente
            </h2>
            <div className="overflow-x-auto rounded-lg border border-gray-200">
              <table className="min-w-full divide-y divide-gray-200">
                <thead className="bg-gray-50">
                  <tr>
                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                      Código
                    </th>
                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                      Nombre
                    </th>
                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                      Color
                    </th>
                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                      Talle
                    </th>
                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                      Tiendas
                    </th>
                  </tr>
                </thead>
                <tbody className="bg-white divide-y divide-gray-200">
                  {successes.map((product, index) => (
                    <tr key={index} className="hover:bg-green-50">
                      <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                        {product.codigo}
                      </td>
                      <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                        {product.nombre}
                      </td>
                      <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                        {product.color}
                      </td>
                      <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                        {product.talle}
                      </td>
                      <td className="px-6 py-4 text-sm text-gray-900">
                        {formatTiendas(product.tiendasAsignadas)}
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>
        )}

        {/* Tabla de errores */}
        {errors.length > 0 && (
          <div>
            <h2 className="text-xl font-semibold mb-4 text-red-600 flex items-center gap-2">
              <AlertCircle className="w-6 h-6" />
              Errores Encontrados
            </h2>
            <div className="overflow-x-auto rounded-lg border border-gray-200">
              <table className="min-w-full divide-y divide-gray-200">
                <thead className="bg-gray-50">
                  <tr>
                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                      Línea
                    </th>
                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                      Código
                    </th>
                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                      Color
                    </th>
                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                      Talle
                    </th>
                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                      Error
                    </th>
                  </tr>
                </thead>
                <tbody className="bg-white divide-y divide-gray-200">
                  {errors.map((error, index) => (
                    <tr key={index} className="hover:bg-red-50">
                      <td className="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                        {error.lineNumber}
                      </td>
                      <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                        {error.codigo}
                      </td>
                      <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                        {error.color}
                      </td>
                      <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                        {error.talle}
                      </td>
                      <td className="px-6 py-4 text-sm text-red-600">
                        {error.errorMessage}
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}