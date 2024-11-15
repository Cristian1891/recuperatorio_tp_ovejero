import React from "react";
import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
import Header from "./components/Header";
import ProductList from "./pages/ProductList";
import "./App.css";
import AddProduct from "./pages/AddProduct";

const App: React.FC = () => {
  return (
    <Router>
      <div className="app">
        <Header />
        <main className="main-content">
          <Routes>
            <Route path="/" element={<ProductList />} />
            <Route path="/add" element={<AddProduct />} />
          </Routes>
        </main>
      </div>
    </Router>
  );
};

export default App;
