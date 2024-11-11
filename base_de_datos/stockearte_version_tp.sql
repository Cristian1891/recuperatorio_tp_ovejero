CREATE SCHEMA IF NOT EXISTS `tienda-bd`;

USE `tienda-bd`;

CREATE TABLE tienda (
  id INT AUTO_INCREMENT PRIMARY KEY,
  codigo VARCHAR(20) NOT NULL UNIQUE,
  estado BOOLEAN NOT NULL DEFAULT TRUE,
  direccion VARCHAR(100) NOT NULL,
  ciudad VARCHAR(60) NOT NULL,
  provincia VARCHAR(60) NOT NULL
);

CREATE TABLE user (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_name VARCHAR(50) UNIQUE NOT NULL,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(50) NOT NULL,
  rol VARCHAR(50) NOT NULL,
  activo BOOLEAN NOT NULL DEFAULT TRUE,
  password VARCHAR(10) NOT NULL,
  tienda_id INT -- Puede ser NULL si pertenece a la casa central
  -- FOREIGN KEY (tienda_id) REFERENCES tienda(id) ON DELETE SET NULL
);

CREATE TABLE producto (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  codigo VARCHAR(10) NOT NULL UNIQUE,
  foto VARCHAR(255),
  color VARCHAR(50) NOT NULL,
  talle VARCHAR(5) NOT NULL
);

CREATE TABLE `tienda-product` (
  id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT,
  stock INT DEFAULT 0,
  tienda_id INT,
  -- FOREIGN KEY (tienda_id) REFERENCES tienda(id) ON DELETE CASCADE,
--   FOREIGN KEY (product_id) REFERENCES producto(id) ON DELETE CASCADE,
  UNIQUE (tienda_id, product_id)
);

CREATE TABLE `catalogo` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `id_tienda` bigint NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
);


CREATE TABLE `catalogo_producto` (
  `catalogo_id` bigint NOT NULL,
  `producto_id` bigint NOT NULL,
  KEY `FKtluimsfd0w4yexwhfijrpd1ek` (`producto_id`),
  KEY `FKdirdaoaubakd77h13dbwiqvpc` (`catalogo_id`),
  CONSTRAINT `FKdirdaoaubakd77h13dbwiqvpc` FOREIGN KEY (`catalogo_id`) REFERENCES `catalogo` (`id`),
  CONSTRAINT `FKtluimsfd0w4yexwhfijrpd1ek` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id`)
);

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
  `id` bigint NOT NULL AUTO_INCREMENT,
  `codigo_tienda` varchar(255) DEFAULT NULL,
  `estado` enum('ACEPTADA','RECHAZADA','RECIBIDA','SOLICITADA') DEFAULT NULL,
  `fecha_recepcion` date DEFAULT NULL,
  `fecha_solicitud` date DEFAULT NULL,
  `id_orden_despacho` bigint DEFAULT NULL,
  `observaciones` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `ordenes_despacho` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `fecha_estimada_envio` date DEFAULT NULL,
  `id_orden_compra` bigint NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `producto-novedad` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `codigo` varchar(255) DEFAULT NULL,
  `color` varchar(255) DEFAULT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `stock` int DEFAULT NULL,
  `talle` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
);





-- rol
-- INSERT INTO rol(id_rol,nombre_rol) VALUES (1,'Casa Central');
-- INSERT INTO rol(id_rol,nombre_rol) VALUES (2,'Tienda');

-- tienda
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T001','Av. Santa Fe 1234','Buenos Aires','Buenos Aires',true);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T002','Calle Corrientes 456','Buenos Aires','Buenos Aires',false);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T003','Av. Rivadavia 789','Buenos Aires','Buenos Aires',false);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T004','San Martín 1010','La Plata','Buenos Aires',false);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T005','Calle 12 2020','La Plata','Buenos Aires',false);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T006','Av. Colón 3030','Mar del Plata','Buenos Aires',true);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T007','Calle 1 4040','Mar del Plata','Buenos Aires',true);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T008','Av. 9 de Julio 5050','Rosario','Santa Fe',false);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T009','Calle San Luis 6060','Rosario','Santa Fe',true);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T010','Calle Mendoza 7070','Santa Fe','Santa Fe',false);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T011','Av. Belgrano 8080','Santa Fe','Santa Fe',true);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T012','Calle Alem 9090','Córdoba','Córdoba',false);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T013','Av. Sabatini 10101','Córdoba','Córdoba',true);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T014','Calle Avellaneda 11111','Córdoba','Córdoba',true);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T015','Av. Cruz Roja 12121','San Francisco','Córdoba',false);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T016','Calle Tucumán 13131','San Francisco','Córdoba',false);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T017','Av. Belgrano 14141','San Luis','San Luis',true);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T018','Calle 25 de Mayo 15151','San Luis','San Luis',true);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T019','Calle 9 de Julio 16161','Mendoza','Mendoza',false);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T020','Av. Libertador 17171','Mendoza','Mendoza',false);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T021','Calle 9 de Julio 18181','Neuquén','Neuquén',false);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T022','Av. Argentina 19191','Neuquén','Neuquén',true);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T023','Calle San Martín 20202','Río Negro','Río Negro',false);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T024','Av. Mitre 21212','Río Negro','Río Negro',true);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T025','Calle Moreno 22222','Chubut','Chubut',true);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T026','Av. Roca 23232','Chubut','Chubut',false);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T027','Calle Rawson 24242','Santa Cruz','Santa Cruz',true);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T028','Av. Kirchner 25252','Santa Cruz','Santa Cruz',false);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T029','Calle Godoy Cruz 26262','Tierra del Fuego','Tierra del Fuego',true);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T030','Av. Malvinas 27272','Tierra del Fuego','Tierra del Fuego',true);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T031','Calle Don Bosco 28282','Catamarca','Catamarca',false);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T032','Av. Rivadavia 29292','Catamarca','Catamarca',true);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T033','Calle Chacabuco 30303','La Rioja','La Rioja',true);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T034','Av. San Nicolás 31313','La Rioja','La Rioja',true);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T035','Calle Tucumán 32323','Santiago del Estero','Santiago del Estero',false);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T036','Av. 25 de Mayo 33333','Santiago del Estero','Santiago del Estero',false);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T037','Calle 9 de Julio 34343','Jujuy','Jujuy',true);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T038','Av. Güemes 35353','Jujuy','Jujuy',false);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T039','Calle Belgrano 36363','Salta','Salta',true);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T040','Av. San Martín 37373','Salta','Salta',false);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T041','Calle San Luis 38383','Formosa','Formosa',false);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T042','Av. Rivadavia 39393','Formosa','Formosa',false);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T043','Calle 12 40404','Chaco','Chaco',true);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T044','Av. Roca 41414','Chaco','Chaco',true);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T045','Calle Moreno 42424','Misiones','Misiones',true);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T046','Av. Santa Fe 43434','Misiones','Misiones',false);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T047','Calle San Martín 44444','Entre Ríos','Entre Ríos',false);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T048','Av. Paraná 45454','Entre Ríos','Entre Ríos',true);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T049','Calle La Rioja 46464','Corrientes','Corrientes',true);
INSERT INTO tienda(codigo,direccion,ciudad,provincia,estado) VALUES ('T050','Av. San Juan 47474','Corrientes','Corrientes',true);

INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario1','abc123defg','Juan','Pérez','juan.perez@email.com',TRUE,'Casa Central',44);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario2','def456ghi7','Ana','Gómez','ana.gomez@email.com',TRUE,'Tienda',1);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario3','ghi789jkl0','Carlos','López','carlos.lopez@email.com',TRUE,'Tienda',2);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario4','abc234def5','María','Rodríguez','maria.rodriguez@email.com',TRUE,'Tienda',3);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario5','jkl890mno1','Pedro','Martínez','pedro.martinez@email.com',FALSE,'Tienda',4);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario6','ghi567klm8','Javier','Sánchez','javier.sanchez@email.com',TRUE,'Tienda',5);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario7','mno012pqr9','Laura','Romero','laura.romero@email.com',TRUE,'Tienda',6);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario8','def789stu2','Sofía','Fernández','sofia.fernandez@email.com',TRUE,'Tienda',7);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario9','stu345vwx3','Martín','Giménez','martin.gimenez@email.com',TRUE,'Tienda',8);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario10','jkl456yz0','Patricia','Herrera','patricia.herrera@email.com',FALSE,'Tienda',9);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario11','abc567jkl1','Mateo','Domínguez','mateo.dominguez@email.com',TRUE,'Tienda',10);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario12','mno234def5','Valentina','Castro','valentina.castro@email.com',TRUE,'Tienda',11);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario13','stu890ghi2','Lucas','Silva','lucas.silva@email.com',TRUE,'Casa Central',45);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario14','def012jkl4','Tomás','Morales','tomas.morales@email.com',TRUE,'Tienda',12);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario15','ghi123klm6','Camila','Mendoza','camila.mendoza@email.com',TRUE,'Tienda',13);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario16','jkl567mno0','Diego','Arias','diego.arias@email.com',FALSE,'Tienda',14);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario17','stu789nop2','Lucía','Reyes','lucia.reyes@email.com',TRUE,'Tienda',15);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario18','abc901pqr7','Ignacio','Duarte','ignacio.duarte@email.com',TRUE,'Tienda',16);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario19','ghi345stu5','Gabriela','Acosta','gabriela.acosta@email.com',TRUE,'Tienda',17);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario20','stu012vwx8','Alberto','Ruiz','alberto.ruiz@email.com',FALSE,'Tienda',18);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario21','mno678yz3','Victoria','Martín','victoria.martin@email.com',TRUE,'Casa Central',46);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario22','abc890pqr4','Sebastián','Ortiz','sebastian.ortiz@email.com',TRUE,'Tienda',19);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario23','ghi234vwx1','Micaela','Luna','micaela.luna@email.com',TRUE,'Tienda',20);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario24','jkl123nop2','Rodrigo','Espinoza','rodrigo.espinoza@email.com',FALSE,'Tienda',21);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario25','stu345ghi3','Delfina','Ibarra','delfina.ibarra@email.com',TRUE,'Tienda',22);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario26','mno789klm5','Agustín','Mejía','agustin.mejia@email.com',TRUE,'Tienda',23);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario27','ghi567stu6','Fernanda','Navarro','fernanda.navarro@email.com',TRUE,'Casa Central',47);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario28','abc012vwx7','Cintia','Soto','cintia.soto@email.com',FALSE,'Tienda',24);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario29','stu456yz8','Leonardo','Rojas','leonardo.rojas@email.com',TRUE,'Tienda',25);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario30','ghi678klm9','Liliana','Mora','liliana.mora@email.com',TRUE,'Tienda',26);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario31','abc123pqr1','Santiago','Pardo','santiago.pardo@email.com',FALSE,'Tienda',27);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario32','stu789vwx4','Guadalupe','Vera','guadalupe.vera@email.com',TRUE,'Tienda',28);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario33','mno345ghi6','Julieta','Figueroa','julieta.figueroa@email.com',TRUE,'Tienda',29);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario34','ghi012nop3','Joaquín','Méndez','joaquin.mendez@email.com',TRUE,'Casa Central',48);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario35','stu123yz0','Manuel','Otero','manuel.otero@email.com',TRUE,'Tienda',30);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario36','ghi789mno2','Sol','Escobar','sol.escobar@email.com',TRUE,'Tienda',31);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario37','abc678stu3','Bruno','Palacios','bruno.palacios@email.com',FALSE,'Tienda',32);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario38','mno456vwx4','Florencia','Núñez','florencia.nunez@email.com',TRUE,'Tienda',33);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario39','ghi345nop5','Cristian','Rivera','cristian.rivera@email.com',TRUE,'Tienda',34);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario40','stu901klm6','Diana','Ponce','diana.ponce@email.com',TRUE,'Casa Central',49);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario41','abc789yz9','Esteban','Correa','esteban.correa@email.com',FALSE,'Tienda',35);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario42','mno234pqr7','Daniela','Ramírez','daniela.ramirez@email.com',TRUE,'Tienda',36);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario43','ghi123vwx1','Jorge','Molina','jorge.molina@email.com',TRUE,'Tienda',37);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario44','stu456nop2','Marcos','Paz','marcos.paz@email.com',TRUE,'Tienda',38);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario45','ghi678stu5','Magdalena','Lagos','magdalena.lagos@email.com',FALSE,'Tienda',39);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario46','abc012yz6','Rocío','García','rocio.garcia@email.com',TRUE,'Casa Central',50);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario47','mno567ghi7','Pablo','Salinas','pablo.salinas@email.com',TRUE,'Tienda',40);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario48','stu234klm3','Victoria','Bustos','victoria.bustos@email.com',TRUE,'Tienda',41);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario49','ghi789vwx4','Maximiliano','Valle','maximiliano.valle@email.com',TRUE,'Tienda',42);
INSERT INTO user(user_name,password,first_name,last_name,email,activo,rol,id_tienda) VALUES ('usuario50','mno890yz9','Bárbara','Campos','barbara.campos@email.com',FALSE,'Tienda',43);

-- producto
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P001','Camiseta Deportiva','M','http://dummyimage.com/107x100.png/5fa2dd/ffffff','Rojo');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P002','Pantalón de Entrenamiento','L','http://dummyimage.com/135x100.png/5fa2dd/ffffff','Azul');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P003','Sudadera con Capucha','M','http://dummyimage.com/220x100.png/dddddd/000000','Negro');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P004','Chaqueta Deportiva','L','http://dummyimage.com/177x100.png/ff4444/ffffff','Gris');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P005','Polo Casual','S','http://dummyimage.com/245x100.png/dddddd/000000','Blanco');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P006','Short Deportivo','M','http://dummyimage.com/170x100.png/dddddd/000000','Azul');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P007','Zapatillas Running','L','http://dummyimage.com/205x100.png/ff4444/ffffff','Negro');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P008','Camiseta Básica','XL','http://dummyimage.com/199x100.png/cc0000/ffffff','Gris');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P009','Pantalón Jeans','S','http://dummyimage.com/190x100.png/ff4444/ffffff','Rojo');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P010','Chaleco Acolchado','M','http://dummyimage.com/211x100.png/ff4444/ffffff','Verde');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P011','Camisa Casual','S','http://dummyimage.com/123x100.png/5fa2dd/ffffff','Azul');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P012','Abrigo de Invierno','M','http://dummyimage.com/193x100.png/cc0000/ffffff','Negro');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P013','Camiseta Estampada','42','http://dummyimage.com/132x100.png/5fa2dd/ffffff','Blanco');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P014','Pantalón Cargo','43','http://dummyimage.com/117x100.png/5fa2dd/ffffff','Negro');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P015','Sudadera Deportiva','M','http://dummyimage.com/197x100.png/dddddd/000000','Amarillo');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P016','Chaqueta de Cuero','L','http://dummyimage.com/223x100.png/dddddd/000000','Rojo');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P017','Sombrero Fedora','32','http://dummyimage.com/239x100.png/cc0000/ffffff','Azul');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P018','Bufanda de Lana','34','http://dummyimage.com/193x100.png/dddddd/000000','Negro');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P019','Gorra Deportiva','M','http://dummyimage.com/205x100.png/5fa2dd/ffffff','Verde');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P020','Camiseta de Tirantes','L','http://dummyimage.com/188x100.png/cc0000/ffffff','Gris');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P021','Guantes Deportivos','S','http://dummyimage.com/234x100.png/5fa2dd/ffffff','Blanco');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P022','Pantalón de Vestir','M','http://dummyimage.com/169x100.png/ff4444/ffffff','Celeste');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P023','Camiseta Polo','L','http://dummyimage.com/200x100.png/dddddd/000000','Negro');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P024','Camisa de Vestir','XL','http://dummyimage.com/203x100.png/dddddd/000000','Azul');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P025','Camiseta Manga Larga','S','http://dummyimage.com/152x100.png/cc0000/ffffff','Rojo');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P026','Pantalón Jogger','M','http://dummyimage.com/148x100.png/5fa2dd/ffffff','Amarillo');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P027','Cinturón de Cuero','32','http://dummyimage.com/220x100.png/cc0000/ffffff','Verde');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P028','Zapatos Formales','34','http://dummyimage.com/204x100.png/ff4444/ffffff','Marrón');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P029','Abrigo de Lana','L','http://dummyimage.com/144x100.png/5fa2dd/ffffff','Negro');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P030','Chaleco Formal','M','http://dummyimage.com/167x100.png/dddddd/000000','Azul');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P031','Camiseta de Algodón','L','http://dummyimage.com/103x100.png/5fa2dd/ffffff','Negro');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P032','Chaleco Vaquero','XL','http://dummyimage.com/140x100.png/dddddd/000000','Marrón');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P033','Zapatos Deportivos','Único','http://dummyimage.com/170x100.png/ff4444/ffffff','Negro');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P034','Pantalón Chino','Único','http://dummyimage.com/124x100.png/dddddd/000000','Gris');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P035','Camisa de Manga Corta','Único','http://dummyimage.com/103x100.png/dddddd/000000','Rojo');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P036','Camiseta Sin Mangas','Único','http://dummyimage.com/220x100.png/cc0000/ffffff','Verde');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P037','Gorra Snapback','Único','http://dummyimage.com/194x100.png/ff4444/ffffff','Azul');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P038','Chaleco de Plumas','Único','http://dummyimage.com/196x100.png/dddddd/000000','Negro');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P039','Camiseta Térmica','S','http://dummyimage.com/167x100.png/ff4444/ffffff','Blanco');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P040','Zapatillas Casual','M','http://dummyimage.com/179x100.png/cc0000/ffffff','Gris');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P041','Bufanda Ligera','M','http://dummyimage.com/117x100.png/cc0000/ffffff','Negro');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P042','Camiseta Henley','L','http://dummyimage.com/158x100.png/ff4444/ffffff','Azul');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P043','Pantalón Corto de Playa','32','http://dummyimage.com/239x100.png/dddddd/000000','Negro');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P044','Guantes de Cuero','34','http://dummyimage.com/229x100.png/cc0000/ffffff','Gris');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P045','Camiseta V-Neck','S','http://dummyimage.com/164x100.png/5fa2dd/ffffff','Rojo');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P046','Pantalón Slim Fit','M','http://dummyimage.com/111x100.png/cc0000/ffffff','Azul');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P047','Zapatillas Skate','M','http://dummyimage.com/230x100.png/cc0000/ffffff','Blanco');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P048','Sudadera con Cierre','L','http://dummyimage.com/206x100.png/5fa2dd/ffffff','Negro');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P049','Sombrero de Paja','S','http://dummyimage.com/126x100.png/dddddd/000000','Verde');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P050','Camiseta Técnica','M','http://dummyimage.com/177x100.png/ff4444/ffffff','Azul');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P051','Pantalón de Yoga','M','http://dummyimage.com/125x100.png/ff4444/ffffff','Gris');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P052','Chaqueta Cortavientos','L','http://dummyimage.com/109x100.png/ff4444/ffffff','Negro');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P053','Camiseta de Compresión','Único','http://dummyimage.com/231x100.png/cc0000/ffffff','Negro');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P054','Blazer Casual','Único','http://dummyimage.com/142x100.png/ff4444/ffffff','Marrón');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P055','Pantalón de Pana','42','http://dummyimage.com/201x100.png/5fa2dd/ffffff','Negro');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P056','Camiseta Oversize','43','http://dummyimage.com/242x100.png/dddddd/000000','Marrón');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P057','Zapatillas de Lona','M','http://dummyimage.com/221x100.png/5fa2dd/ffffff','Rojo');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P058','Chaqueta Bomber','L','http://dummyimage.com/110x100.png/5fa2dd/ffffff','Gris');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P059','Pantalón de Pinzas','M','http://dummyimage.com/118x100.png/cc0000/ffffff','Verde');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P060','Camiseta Crop Top','L','http://dummyimage.com/177x100.png/5fa2dd/ffffff','Negro');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P061','Botas de Senderismo','S','http://dummyimage.com/130x100.png/5fa2dd/ffffff','Blanco');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P062','Gabardina Clásica','M','http://dummyimage.com/142x100.png/cc0000/ffffff','Azul');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P063','Pantalón Pitillo','M','http://dummyimage.com/233x100.png/dddddd/000000','Negro');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P064','Camiseta Tie-Dye','L','http://dummyimage.com/229x100.png/5fa2dd/ffffff','Gris');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P065','Zapatillas de Baloncesto','42','http://dummyimage.com/200x100.png/5fa2dd/ffffff','Blanco');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P066','Chaqueta Vaquera','43','http://dummyimage.com/183x100.png/ff4444/ffffff','Negro');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P067','Pantalón Palazzo','32','http://dummyimage.com/216x100.png/cc0000/ffffff','Beige');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P068','Camiseta Raglán','34','http://dummyimage.com/153x100.png/ff4444/ffffff','Verde');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P069','Mocasines de Cuero','S','http://dummyimage.com/136x100.png/cc0000/ffffff','Azul');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P070','Parka con Capucha','M','http://dummyimage.com/176x100.png/dddddd/000000','Verde');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P071','Pantalón Culotte','S','http://dummyimage.com/102x100.png/5fa2dd/ffffff','Blanco');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P072','Camiseta de Malla','M','http://dummyimage.com/226x100.png/cc0000/ffffff','Negro');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P073','Botines Chelsea','Único','http://dummyimage.com/134x100.png/ff4444/ffffff','Gris');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P074','Chaqueta de Punto','Único','http://dummyimage.com/105x100.png/ff4444/ffffff','Negro');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P075','Pantalón Capri','M','http://dummyimage.com/218x100.png/ff4444/ffffff','Azul');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P076','Camiseta Ringer','L','http://dummyimage.com/140x100.png/cc0000/ffffff','Gris');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P077','Sandalias Deportivas','S','http://dummyimage.com/213x100.png/dddddd/000000','Rojo');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P078','Poncho de Lana','M','http://dummyimage.com/213x100.png/ff4444/ffffff','Amarillo');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P079','Pantalón Harem','42','http://dummyimage.com/221x100.png/5fa2dd/ffffff','Blanco');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P080','Camiseta de Bolsillo','43','http://dummyimage.com/171x100.png/ff4444/ffffff','Azul');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P081','Zapatos Oxford','Único','http://dummyimage.com/121x100.png/ff4444/ffffff','Negro');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P082','Chaqueta de Plumas','Único','http://dummyimage.com/208x100.png/dddddd/000000','Rojo');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P083','Pantalón de Campana','S','http://dummyimage.com/192x100.png/ff4444/ffffff','Blanco');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P084','Camiseta de Cuello Alto','M','http://dummyimage.com/116x100.png/dddddd/000000','Azul');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P085','Alpargatas Clásicas','M','http://dummyimage.com/123x100.png/cc0000/ffffff','Gris');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P086','Cárdigan Largo','L','http://dummyimage.com/205x100.png/ff4444/ffffff','Negro');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P087','Pantalón de Lino','M','http://dummyimage.com/235x100.png/dddddd/000000','Marrón');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P088','Camiseta de Tirantes Anchos','L','http://dummyimage.com/174x100.png/dddddd/000000','Negro');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P089','Botas de Combate','S','http://dummyimage.com/142x100.png/dddddd/000000','Rojo');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P090','Kimono Ligero','M','http://dummyimage.com/148x100.png/5fa2dd/ffffff','Verde');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P091','Pantalón de Cuero','32','http://dummyimage.com/143x100.png/cc0000/ffffff','Negro');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P092','Camiseta con Parche','34','http://dummyimage.com/100x100.png/5fa2dd/ffffff','Azul');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P093','Zapatillas de Tenis','42','http://dummyimage.com/173x100.png/ff4444/ffffff','Gris');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P094','Chaqueta Safari','43','http://dummyimage.com/126x100.png/dddddd/000000','Negro');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P095','Pantalón Boyfriend','S','http://dummyimage.com/175x100.png/dddddd/000000','Azul');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P096','Camiseta de Rejilla','M','http://dummyimage.com/165x100.png/ff4444/ffffff','Negro');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P097','Mocasines Penny','Único','http://dummyimage.com/237x100.png/dddddd/000000','Blanco');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P098','Trench Coat','Único','http://dummyimage.com/216x100.png/5fa2dd/ffffff','Beige');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P099','Pantalón Paper Bag','S','http://dummyimage.com/145x100.png/ff4444/ffffff','Rojo');
INSERT INTO producto(codigo,nombre,talle,foto,color) VALUES ('P100','Camiseta con Cuello de Tortuga','M','http://dummyimage.com/210x100.png/ff4444/ffffff','Gris');

-- producto_tienda
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (1,1,10);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (1,2,15);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (1,3,20);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (2,4,25);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (2,5,30);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (2,6,35);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (3,7,40);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (3,8,45);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (3,9,50);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (4,10,55);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (4,11,60);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (4,12,65);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (5,13,70);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (5,14,75);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (5,15,80);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (6,16,85);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (6,17,90);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (6,18,95);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (7,19,100);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (7,20,105);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (7,21,110);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (8,22,115);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (8,23,120);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (8,24,125);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (9,25,130);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (9,26,135);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (9,27,140);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (10,28,145);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (10,29,150);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (10,30,155);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (11,31,160);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (11,32,165);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (11,33,170);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (12,34,175);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (12,35,180);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (12,36,185);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (13,37,190);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (13,38,195);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (13,39,200);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (14,40,205);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (14,41,210);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (14,42,215);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (15,43,220);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (15,44,225);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (15,45,230);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (16,46,235);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (16,47,240);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (16,48,245);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (17,49,250);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (17,50,255);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (17,51,260);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (18,52,265);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (18,53,270);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (18,54,275);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (19,55,280);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (19,56,285);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (19,57,290);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (20,58,295);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (20,59,300);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (20,60,305);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (21,61,310);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (21,62,315);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (21,63,320);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (22,64,325);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (22,65,330);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (22,66,335);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (23,67,340);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (23,68,345);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (23,69,350);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (24,70,355);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (24,71,360);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (24,72,365);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (25,73,370);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (25,74,375);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (25,75,380);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (26,76,385);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (26,77,390);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (26,78,395);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (27,79,400);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (27,80,405);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (27,81,410);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (28,82,415);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (28,83,420);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (28,84,425);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (29,85,430);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (29,86,435);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (29,87,440);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (30,88,445);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (30,89,450);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (30,90,455);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (31,91,460);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (31,92,465);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (31,93,470);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (32,94,475);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (32,95,480);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (32,96,485);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (33,97,490);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (33,98,495);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (33,99,500);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (34,100,505);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (34,1,510);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (34,2,515);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (35,3,520);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (35,4,525);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (35,5,530);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (36,6,535);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (36,7,540);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (36,8,545);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (37,9,550);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (37,10,555);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (37,11,560);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (38,12,565);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (38,13,570);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (38,14,575);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (39,15,580);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (39,16,585);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (39,17,590);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (40,18,595);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (40,19,600);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (40,20,605);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (41,21,610);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (41,22,615);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (41,23,620);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (42,24,625);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (42,25,630);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (42,26,635);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (43,27,640);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (43,28,645);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (43,29,650);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (44,30,655);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (44,31,660);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (44,32,665);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (45,33,670);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (45,34,675);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (45,35,680);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (46,36,685);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (46,37,690);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (46,38,695);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (47,39,700);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (47,40,705);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (47,41,710);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (48,42,715);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (48,43,720);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (48,44,725);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (49,45,730);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (49,46,735);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (49,47,740);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (50,48,745);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (50,49,750);
INSERT INTO `tienda-product`(tienda_id,product_id,stock) VALUES (50,50,755);

INSERT INTO catalogo (id, id_tienda, nombre) VALUES
(1, 1, 'Verano 2023'),
(2, 2, 'Invierno 2023'),
(3, 3, 'Primavera 2023'),
(4, 4, 'Otoño 2023'),
(5, 5, 'Accesorios'),
(6, 6, 'Ropa de Mujer'),
(7, 7, 'Ropa de Hombre'),
(8, 8, 'Ropa de Niños'),
(9, 9, 'Calzado'),
(10, 10, 'Bolsos y Carteras');


INSERT INTO catalogo_producto (catalogo_id, producto_id) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 4),
(2, 5),
(2, 6),
(3, 7),
(3, 8),
(3, 9),
(4, 10),
(4, 11),
(4, 12),
(5, 13),
(5, 14),
(5, 15),
(6, 16),
(6, 17),
(6, 18),
(7, 19),
(7, 20),
(7, 21),
(8, 22),
(8, 23),
(8, 24),
(9, 25),
(9, 26),
(9, 27),
(10, 28),
(10, 29),
(10, 30);


INSERT INTO ordenes_compra (id, codigo_tienda, estado, fecha_recepcion, fecha_solicitud, id_orden_despacho, observaciones) VALUES
(1, 'T001', 'ACEPTADA', '2023-01-01', '2022-12-31', 1, 'Orden de compra para la tienda T001'),
(2, 'T002', 'RECHAZADA', '2023-01-05', '2022-12-31', NULL, 'Orden de compra rechazada por la tienda T002'),
(3, 'T003', 'RECIBIDA', '2023-01-10', '2022-12-31', 2, 'Orden de compra recibida por la tienda T003'),
(4, 'T004', 'SOLICITADA', '2023-01-15', '2022-12-31', NULL, 'Orden de compra solicitada por la tienda T004'),
(5, 'T005', 'ACEPTADA', '2023-01-20', '2022-12-31', 3, 'Orden de compra aceptada por la tienda T005');

INSERT INTO ordenes_despacho (id, fecha_estimada_envio, id_orden_compra) VALUES
(1, '2023-01-05', 1),
(2, '2023-01-10', 3),
(3, '2023-01-15', 5),
(4, '2023-01-20', 2),
(5, '2023-01-25', 4);

INSERT INTO `producto-novedad` (id, codigo, color, foto, nombre, stock, talle) VALUES
(1, 'PN001', 'Rojo', 'http://dummyimage.com/199x100.png/5fa2dd/ffffff', 'Camiseta de Manga Larga', 10, 'M'),
(2, 'PN002', 'Azul', 'http://dummyimage.com/247x100.png/ff4444/ffffff', 'Pantalón de Vestir', 15, 'L'),
(3, 'PN003', 'Negro', 'http://dummyimage.com/186x100.png/ff4444/ffffff', 'Zapatos Formales', 20, 'Único'),
(4, 'PN004', 'Gris', 'http://dummyimage.com/117x100.png/5fa2dd/ffffff', 'Camiseta de Tirantes', 25, 'S'),
(5, 'PN005', 'Verde', 'http://dummyimage.com/218x100.png/cc0000/ffffff', 'Pantalón de Cuero', 30, 'M'),
(6, 'PN006', 'Marrón', 'http://dummyimage.com/198x100.png/5fa2dd/ffffff', 'Chaqueta de Punto', 35, 'L'),
(7, 'PN007', 'Blanco', 'http://dummyimage.com/138x100.png/cc0000/ffffff', 'Camiseta de Algodón', 40, 'L');

SET FOREIGN_KEY_CHECKS = 1;
TRUNCATE TABLE user;
TRUNCATE TABLE producto;
TRUNCATE TABLE tienda;
TRUNCATE TABLE `tienda-product`;
TRUNCATE TABLE `producto-novedad`;
