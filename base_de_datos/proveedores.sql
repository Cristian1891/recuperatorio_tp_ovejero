CREATE SCHEMA IF NOT EXISTS `proveedor_bd`;

USE `proveedor_bd`;


CREATE TABLE `items_orden` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cantidad_solicitada` int DEFAULT NULL,
  `codigo_articulo` varchar(255) DEFAULT NULL,
  `color` varchar(255) DEFAULT NULL,
  `talle` varchar(255) DEFAULT NULL,
  `orden_compra_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK73f1bcc3x75r3d91ewucrn2t1` (`orden_compra_id`),
  CONSTRAINT `FK73f1bcc3x75r3d91ewucrn2t1` FOREIGN KEY (`orden_compra_id`) REFERENCES `ordenes_compra` (`id`)
);

CREATE TABLE `ordenes_compra` (
  `id` bigint NOT NULL,
  `codigo_tienda` varchar(255) DEFAULT NULL,
  `estado` enum('ACEPTADA','RECHAZADA','RECIBIDA','SOLICITADA') DEFAULT NULL,
  `fecha_recepcion` date DEFAULT NULL,
  `fecha_solicitud` date DEFAULT NULL,
  `id_orden_despacho` bigint DEFAULT NULL,
  `observaciones` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
);


CREATE TABLE `ordenes_despacho` (
  `id` bigint NOT NULL,
  `fecha_estimada_envio` date DEFAULT NULL,
  `id_orden_compra` bigint NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `proveedor` (
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
);

CREATE TABLE `producto` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `codigo` varchar(255) DEFAULT NULL,
  `color` varchar(255) DEFAULT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `stock` int DEFAULT NULL,
  `talle` varchar(255) DEFAULT NULL,
  `proveedor_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKid8vjxky5juk3fnuc1sb9qarf` (`proveedor_id`),
  CONSTRAINT `FKid8vjxky5juk3fnuc1sb9qarf` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedor` (`id`)
);


INSERT INTO proveedor (id) VALUES
(1),
(2),
(3),
(4),
(5);


INSERT INTO producto (id, codigo, color, foto, nombre, stock, talle, proveedor_id) VALUES
(1, 'P001', 'Rojo', 'http://dummyimage.com/102x100.png/cc0000/ffffff', 'Camiseta', 10, 'M', 1),
(2, 'P002', 'Azul', 'http://dummyimage.com/185x100.png/cc0000/ffffff', 'Pantalón', 20, 'L', 2),
(3, 'P003', 'Verde', 'http://dummyimage.com/215x100.png/cc0000/ffffff', 'Zapatilla', 15, 'S', 3),
(4, 'P004', 'Amarillo', 'http://dummyimage.com/157x100.png/cc0000/ffffff', 'Gorra', 8, 'M', 4),
(5, 'P005', 'Negro', 'http://dummyimage.com/206x100.png/dddddd/000000', 'Bolso', 12, 'L', 5),
(6, 'P006', 'Gris', 'http://dummyimage.com/154x100.png/5fa2dd/ffffff', 'Cinturón', 18, 'S', 1),
(7, 'P007', 'Blanco', 'http://dummyimage.com/148x100.png/cc0000/ffffff', 'Calcetín', 22, 'M', 2),
(8, 'P008', 'Naranja', 'http://dummyimage.com/207x100.png/dddddd/000000', 'Bufanda', 10, 'L', 3);


INSERT INTO ordenes_compra (id, codigo_tienda, estado, fecha_recepcion, fecha_solicitud, id_orden_despacho, observaciones) VALUES
(1, 'T001', 'SOLICITADA', NULL, '2022-01-01', NULL, 'Orden de compra 1'),
(2, 'T002', 'ACEPTADA', '2022-01-15', '2022-01-05', 1, 'Orden de compra 2'),
(3, 'T003', 'RECHAZADA', NULL, '2022-01-20', NULL, 'Orden de compra 3'),
(4, 'T004', 'RECIBIDA', '2022-02-01', '2022-01-25', 2, 'Orden de compra 4'),
(5, 'T005', 'SOLICITADA', NULL, '2022-02-05', NULL, 'Orden de compra 5');


INSERT INTO ordenes_despacho (id, fecha_estimada_envio, id_orden_compra) VALUES
(1, '2022-01-12', 1),
(2, '2022-01-22', 2),
(3, '2022-02-02', 4);


INSERT INTO items_orden (id, cantidad_solicitada, codigo_articulo, color, talle, orden_compra_id) VALUES
(1, 2, 'P001', 'Rojo', 'M', 1),
(2, 3, 'P002', 'Azul', 'L', 1),
(3, 1, 'P003', 'Verde', 'S', 2),
(4, 4, 'P004', 'Amarillo', 'M', 3),
(5, 2, 'P005', 'Negro', 'L', 4),
(6, 1, 'P006', 'Gris', 'S', 5),
(7, 3, 'P007', 'Blanco', 'M', 2),
(8, 2, 'P008', 'Naranja', 'L', 4);




SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE `items_orden`;
TRUNCATE TABLE `ordenes_compra`;
TRUNCATE TABLE `proveedor`;
TRUNCATE TABLE `producto`;