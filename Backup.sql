-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 18-12-2019 a las 10:26:28
-- Versión del servidor: 10.4.10-MariaDB
-- Versión de PHP: 7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bd_proyecto`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `filtro_producto` (`marca_e` VARCHAR(100), `precio_e` INTEGER, `talla_e` VARCHAR(100))  BEGIN  
   SELECT * FROM producto
    WHERE marca =marca_e
    AND talla=talla_e
    AND precio=precio_e;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `filtro_usuario` (`cuidad_e` VARCHAR(100), `apellido_e` VARCHAR(100))  BEGIN  
   SELECT * FROM usuario
    WHERE ciudad =cuidad_e
    AND papellido=apellido_e;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `nuevo_admin` (IN `dni` INTEGER, IN `papellido` VARCHAR(150), IN `sapellido` VARCHAR(100), IN `nombres` VARCHAR(80), IN `contrasena` VARCHAR(150), IN `ciudad` VARCHAR(80), IN `mail` VARCHAR(80), IN `sueldo` NUMERIC(10,2))  BEGIN
        INSERT INTO admin VALUES(dni,papellido,sapellido,nombres,contrasena,ciudad,mail,sueldo);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `nuevo_user` (IN `dni` INT, IN `nombres` VARCHAR(150), IN `papellido` VARCHAR(100), IN `sapellido` VARCHAR(100), IN `usuario` VARCHAR(150), IN `password` VARCHAR(80), IN `ciudad` VARCHAR(80), IN `mail` VARCHAR(80))  BEGIN
        INSERT INTO usuario VALUES(dni,nombres,papellido,sapellido,usuario,password,ciudad,mail);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registrar_compra` (IN `id_producto` INT, IN `id_usuario` INT)  BEGIN
        INSERT INTO compra VALUES(id_producto, id_usuario);
        
  		SELECT stock FROM producto WHERE stock>0;
       UPDATE producto SET stock =stock-1 WHERE id_producto=id_producto ;       

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registrar_producto` (IN `codigo_producto` INTEGER, IN `stock` VARCHAR(150), IN `marca` VARCHAR(100), IN `precio` VARCHAR(80), IN `talla` VARCHAR(150), IN `imagen` VARCHAR(150), IN `genero_1` VARCHAR(80))  BEGIN
        INSERT INTO producto VALUES(codigo_producto,stock,marca,precio,talla,imagen,genero);
  		IF(genero_1='M' ) THEN 
  			INSERT INTO mujer VALUES (codigo_producto);
  		END IF;
  		IF(genero_1='V' ) THEN 
  			INSERT INTO mujer VALUES (codigo_producto);
  		END IF;  		     	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actulizar_producto` (IN `dni_e` INTEGER)  BEGIN
  SELECT stock FROM producto WHERE stock>0;
       UPDATE producto SET stock =stock-1 WHERE codigo_producto=dni_e ;       
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `admin`
--

CREATE TABLE `admin` (
  `dni` int(11) NOT NULL,
  `papellido` varchar(100) DEFAULT NULL,
  `sapellido` varchar(100) DEFAULT NULL,
  `nombres` varchar(100) DEFAULT NULL,
  `contrasena` varchar(100) DEFAULT NULL,
  `ciudad` varchar(100) DEFAULT NULL,
  `mail` varchar(100) DEFAULT NULL,
  `sueldo` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `admin`
--

INSERT INTO `admin` (`dni`, `papellido`, `sapellido`, `nombres`, `contrasena`, `ciudad`, `mail`, `sueldo`) VALUES
(12345, 'Quispe', 'Pacco', 'Ivan', '12345', 'Arequipa', 'ivanp@gmail.com', '50.00'),
(123451, 'Quispe', 'Perez', 'Francisco', '123451', 'Arequipa', 'admin@live.com', '10.00'),
(123452, 'Quispe', 'DelCarpio', 'Patricia', '123452', 'Arequipa', 'admin@live.com', '100.00'),
(123453, 'Quispe', 'Villanueva', 'Celinda', '123453', 'Arequipa', 'admin@live.com', '200.00'),
(123454, 'Quispe', 'Villalobos', 'Milagros', '123454', 'ciudad', 'admin@live.com', '50.00'),
(123455, 'Quispe', 'Sihuinta', 'Marisol', '123455', 'Tacna', 'admin@live.com', '20.00'),
(123456, 'Quispe', 'Vargas', 'Juana', '123456', 'Arequipa', 'admin@live.com', '500.00'),
(123457, 'Quispe', 'Mamani', 'Cecilia', '123457', 'Juliaca', 'Juliaca@live.com', '210.00'),
(123458, 'Quispe', 'Corrales', 'Graciela', '123458', 'Tacna', 'admin@live.com', '50.00'),
(123459, 'Quispe', 'Cedro', 'Fiorella', '123459', 'Piura', 'admin@live.com', '500.00'),
(123460, 'Quispe', 'Pino', 'Yamile', '123460', 'Puno', 'admin@live.com', '50.00'),
(123461, 'Quispe', 'Mesa', 'Maria', '123461', 'Juliaca', 'admin@live.com', '80.00'),
(123462, 'Quispe', 'Martinez', 'Luis', '123462', 'Arequipa', 'admin@live.com', '50.00'),
(123463, 'Quispe', 'Silva', 'Emanuel', '123463', 'Cuzco', 'admin@live.com', '300.00'),
(123464, 'Quispe', 'Laquise', 'Brian', '123464', 'Lima', 'admin@live.com', '50.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `almacen`
--

CREATE TABLE `almacen` (
  `id_almacen` decimal(10,0) NOT NULL,
  `capacidad` decimal(10,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra`
--

CREATE TABLE `compra` (
  `id_producto` int(11) DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `compra`
--

INSERT INTO `compra` (`id_producto`, `id_usuario`) VALUES
(74596451, 1),
(74596451, 1),
(70518723, 1),
(74596451, 1),
(74596451, 1),
(74596451, 1),
(74596451, 1),
(74596451, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `hombre`
--

CREATE TABLE `hombre` (
  `codigo_producto_hombre` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mujer`
--

CREATE TABLE `mujer` (
  `codigo_producto_hombre` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `mujer`
--

INSERT INTO `mujer` (`codigo_producto_hombre`) VALUES
(1),
(2),
(3),
(4),
(5),
(7),
(10),
(11),
(12),
(15);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `codigo_producto` int(11) NOT NULL,
  `stock` int(11) DEFAULT NULL,
  `marca` varchar(100) DEFAULT NULL,
  `precio` int(11) DEFAULT NULL,
  `talla` varchar(100) DEFAULT NULL,
  `imagen` varchar(100) DEFAULT NULL,
  `genero` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`codigo_producto`, `stock`, `marca`, `precio`, `talla`, `imagen`, `genero`) VALUES
(1, 48, 'Adidas', 75, '32', 'yung chasm.jpg', NULL),
(2, 20, 'Adidas', 50, '32', 'ultraboost19.jpg', NULL),
(3, 10, 'Nike', 75, '32', 'alphaedge.jpg', NULL),
(4, 10, 'Nike', 50, '32', 'superstar.jpg', NULL),
(5, 15, 'Adidas', 75, '23', 'harden.jpg', NULL),
(6, 20, 'Nike', 50, '23', 'falcon.jpg', NULL),
(7, 25, 'Adidas', 75, '23', 'streetball.jpg', NULL),
(8, 50, 'Nike', 50, '32', 'predator.jpg', NULL),
(9, 400, 'Adidas', 75, '23', 'sl72.jpg', NULL),
(10, 100, 'Nike', 20, '32', 'torsionx.jpg', NULL),
(11, 60, 'Adidas', 50, '23', 'nemeziz.jpg', NULL),
(12, 8, 'Nike', 50, '32', 'kaptir.jpg', NULL),
(13, 14, 'Adidas', 75, '23', 'hoops.jpg', NULL),
(14, 24, 'Nike', 50, '32', 'advantage.jpg', NULL),
(15, 65, 'Adidas', 45, '23', 'nitejogger', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `dni` int(11) NOT NULL,
  `nombres` varchar(100) DEFAULT NULL,
  `papellido` varchar(100) DEFAULT NULL,
  `sapellido` varchar(100) DEFAULT NULL,
  `usuario` varchar(100) DEFAULT NULL,
  `contrasena` varchar(100) DEFAULT NULL,
  `ciudad` varchar(100) DEFAULT NULL,
  `mail` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`dni`, `nombres`, `papellido`, `sapellido`, `usuario`, `contrasena`, `ciudad`, `mail`) VALUES
(74596451, 'Juan', 'Perez', 'Alvela', 'JuanP', '123', 'Arequipa', 'juanp@gmail.com'),
(74596452, 'Pedro', 'Perez', 'Mesa', 'PedroP', '123', 'Arequipa', 'pedr123@gmail.com'),
(74596453, 'Jose', 'Meneses', 'Barracuda', 'JoseM', '123', 'Arequipa', 'jose123@gmail.com'),
(74596454, 'Giancarlo', 'Perez', 'Villareal', 'GiancarloP', '123', 'Arequipa', 'gianc123@gmail.com'),
(74596455, 'Maria', 'Perez', 'Ruiz', 'MariaP', '123', 'Cuzco', 'mar123@gmail.com'),
(74596456, 'Fiorella', 'Toha', 'Mesa', 'PedroP', '123', 'Arequipa', 'frll123@gmail.com'),
(74596457, 'Luis', 'Perez', 'Mesa', 'PedroP', '123', 'Arequipa', 'luis123@gmail.com'),
(74596458, 'Yamile', 'Perez', 'Mesa', 'PedroP', '123', 'Chimbote', 'yami123@gmail.com'),
(74596459, 'Ernesto', 'Barrios', 'Mesa', 'PedroP', '123', 'Arequipa', 'ERNEST123@gmail.com'),
(74596460, 'Mario', 'Perez', 'Mesa', 'PedroP', '123', 'Tingo Maria', 'mario_d@gmail.com'),
(74596461, 'Juan', 'Cedro', 'Mesa', 'PedroP', '123', 'Arequipa', 'juanxx@gmail.com'),
(74596462, 'Zumba', 'Mamani', 'Mesa', 'PedroP', '123', 'Pisco', 'zumzum@gmail.com'),
(74596463, 'Pedro', 'Perez', 'Mesa', 'PedroP', '123', 'Arequipa', 'pedrooo123@gmail.com'),
(74596464, 'Henry', 'Quispe', 'Mesa', 'PedroP', '123', 'Tarapoto', 'Henrya@gmail.com'),
(74596465, 'Pedro', 'Cholquehuanca', 'Mesa', 'PedroP', '123', 'Arequipa', 'peasd123@gmail.com');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`dni`);

--
-- Indices de la tabla `almacen`
--
ALTER TABLE `almacen`
  ADD PRIMARY KEY (`id_almacen`);

--
-- Indices de la tabla `hombre`
--
ALTER TABLE `hombre`
  ADD PRIMARY KEY (`codigo_producto_hombre`);

--
-- Indices de la tabla `mujer`
--
ALTER TABLE `mujer`
  ADD PRIMARY KEY (`codigo_producto_hombre`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`codigo_producto`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`dni`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
