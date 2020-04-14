-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 14-04-2020 a las 19:26:41
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
-- Base de datos: `ecommerce_db`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CONSULTARPRODUCTO` (`P_MONEDA` CHAR(3), `P_WEBID` INT)  BEGIN

IF P_MONEDA <> 'MXN' THEN
    SELECT P.*, M.PRECIO AS PRECIO2, M.PRECIONUEVO AS PRECIONUEVO2 FROM TBL_PRODUCTO P 
    INNER JOIN TBL_PRODCUTO_MONEDA M ON P.WEBID = M.WEBID
    INNER JOIN TBL_MARCA MAR ON P.CODIGO_MARCA = MAR.CODIGO
    INNER JOIN TBL_CATEGORIA C ON P.CODIGO_CATEGORIA = C.CODIGO
    WHERE P.VISIBLE = TRUE AND MAR.VISIBLE = TRUE AND C.VISIBLE = TRUE AND M.MONEDA = P_MONEDA AND P.WEBID=P_WEBID;
ELSE
    SELECT P.* FROM TBL_PRODUCTO P 
    INNER JOIN TBL_MARCA MAR ON P.CODIGO_MARCA = MAR.CODIGO
    INNER JOIN TBL_CATEGORIA C ON P.CODIGO_CATEGORIA = C.CODIGO
    WHERE P.VISIBLE = TRUE AND MAR.VISIBLE = TRUE AND C.VISIBLE = TRUE AND P.WEBID=P_WEBID;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CONTARCATEGORIA` (`CODCAT` INT)  BEGIN
    SELECT COUNT(*) AS CANTIDAD FROM tbl_categoria
    WHERE CATEGORIA_SUPERIOR = CODCAT AND CODIGO <> CODCAT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CONTARPRODUCTOSMARCA` (`P_MAR` INT)  BEGIN
    SELECT count(*) FROM tbl_producto WHERE codigo_marca = P_MAR;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTARCATEGORIASUPERIOR` ()  BEGIN
    SELECT CODIGO, NOMBRE FROM tbl_categoria
    WHERE CODIGO=CATEGORIA_SUPERIOR AND VISIBLE=TRUE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTARPORCATEGORIA` (`P_MONEDA` CHAR(3), `P_CAT` INT)  BEGIN

IF P_MONEDA <> 'MXN' THEN
    SELECT P.*, M.PRECIO AS PRECIO2, M.PRECIONUEVO AS PRECIONUEVO2 FROM TBL_PRODUCTO P 
    INNER JOIN TBL_PRODCUTO_MONEDA M ON P.WEBID = M.WEBID
    INNER JOIN TBL_MARCA MAR ON P.CODIGO_MARCA = MAR.CODIGO
    INNER JOIN TBL_CATEGORIA C ON P.CODIGO_CATEGORIA = C.CODIGO
    WHERE P.VISIBLE = TRUE AND MAR.VISIBLE = TRUE AND C.VISIBLE = TRUE AND M.MONEDA = P_MONEDA AND P.CODIGO_CATEGORIA = P_CAT;
ELSE
    SELECT P.* FROM TBL_PRODUCTO P 
    INNER JOIN TBL_MARCA MAR ON P.CODIGO_MARCA = MAR.CODIGO
    INNER JOIN TBL_CATEGORIA C ON P.CODIGO_CATEGORIA = C.CODIGO
    WHERE P.VISIBLE = TRUE AND MAR.VISIBLE = TRUE AND C.VISIBLE = TRUE AND P.CODIGO_CATEGORIA = P_CAT;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTARPORMARCA` (`P_MONEDA` CHAR(3), `P_MAR` INT)  BEGIN

IF P_MONEDA <> 'MXN' THEN
    SELECT P.*, M.PRECIO AS PRECIO2, M.PRECIONUEVO AS PRECIONUEVO2 FROM TBL_PRODUCTO P 
    INNER JOIN TBL_PRODCUTO_MONEDA M ON P.WEBID = M.WEBID
    INNER JOIN TBL_MARCA MAR ON P.CODIGO_MARCA = MAR.CODIGO
    INNER JOIN TBL_CATEGORIA C ON P.CODIGO_CATEGORIA = C.CODIGO
    WHERE P.VISIBLE = TRUE AND MAR.VISIBLE = TRUE AND C.VISIBLE = TRUE AND M.MONEDA = P_MONEDA AND P.CODIGO_MARCA = P_MAR;
ELSE
    SELECT P.* FROM TBL_PRODUCTO P 
    INNER JOIN TBL_MARCA MAR ON P.CODIGO_MARCA = MAR.CODIGO
    INNER JOIN TBL_CATEGORIA C ON P.CODIGO_CATEGORIA = C.CODIGO
    WHERE P.VISIBLE = TRUE AND MAR.VISIBLE = TRUE AND C.VISIBLE = TRUE AND P.CODIGO_MARCA = P_MAR;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTARRECOMENDADOS` (`P_MONEDA` CHAR(3))  BEGIN

IF P_MONEDA <> 'MXN' THEN
    SELECT P.*, M.PRECIO AS PRECIO2, M.PRECIONUEVO AS PRECIONUEVO2 FROM TBL_PRODUCTO P 
    INNER JOIN TBL_PRODCUTO_MONEDA M ON P.WEBID = M.WEBID
    INNER JOIN TBL_MARCA MAR ON P.CODIGO_MARCA = MAR.CODIGO
    INNER JOIN TBL_CATEGORIA C ON P.CODIGO_CATEGORIA = C.CODIGO
    WHERE P.VISIBLE = TRUE AND MAR.VISIBLE = TRUE AND C.VISIBLE = TRUE AND M.MONEDA = P_MONEDA;
ELSE
    SELECT P.* FROM TBL_PRODUCTO P 
    INNER JOIN TBL_MARCA MAR ON P.CODIGO_MARCA = MAR.CODIGO
    INNER JOIN TBL_CATEGORIA C ON P.CODIGO_CATEGORIA = C.CODIGO
    WHERE P.VISIBLE = TRUE AND MAR.VISIBLE = TRUE AND C.VISIBLE = TRUE;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTARSUBCATEGORIA` (`CODCAD` INT)  BEGIN
    SELECT CODIGO, NOMBRE FROM tbl_categoria
    WHERE CODIGO<>CATEGORIA_SUPERIOR AND VISIBLE=TRUE AND CODCAD=CATEGORIA_SUPERIOR;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTARTODODECATEGORIA` ()  BEGIN
    SELECT codigo, nombre FROM tbl_categoria 
    WHERE visible=TRUE 
    ORDER BY NOMBRE ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTARTODODEMARCA` ()  BEGIN
    SELECT codigo, nombre FROM tbl_marca 
    WHERE visible=TRUE 
    ORDER BY NOMBRE ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGISTRARPRODUCTO` (`P_NOMBRE` VARCHAR(30), `P_PRECIO` DECIMAL(10,2), `P_PRECIONUEVO` DECIMAL(10,2), `P_STOCK` INT, `P_NUEVO` BOOLEAN, `P_RECOMENDADO` BOOLEAN, `P_DESCRIPCION` VARCHAR(255), `P_VISIBLE` BOOLEAN, `P_CODIGO_MARCA` INT, `P_CODIGO_CATEGORIA` INT, `P_IMG` VARCHAR(100), `P_MONEDA_COP` CHAR(3), `P_PRECIO_COP` DECIMAL(10,2), `P_PRECIONUEVO_COP` DECIMAL(10,2), `P_MONEDA_USD` CHAR(3), `P_PRECIO_USD` DECIMAL(10,2), `P_PRECIONUEVO_USD` DECIMAL(10,2), `P_MONEDA_PEN` CHAR(3), `P_PRECIO_PEN` DECIMAL(10,2), `P_PRECIONUEVO_PEN` DECIMAL(10,2))  BEGIN

DECLARE V_WEBID INT;

    INSERT INTO tbl_producto 
    VALUES(NULL,P_NOMBRE,P_PRECIO,P_PRECIONUEVO,P_STOCK,P_NUEVO,P_RECOMENDADO,P_DESCRIPCION,P_VISIBLE,P_CODIGO_MARCA,P_CODIGO_CATEGORIA,P_IMG);

SET V_WEBID = (SELECT LAST_INSERT_ID());

    INSERT INTO tbl_prodcuto_moneda
    VALUES(P_MONEDA_COP,P_PRECIO_COP,P_PRECIONUEVO_COP,V_WEBID);
    INSERT INTO tbl_prodcuto_moneda
    VALUES(P_MONEDA_USD,P_PRECIO_USD,P_PRECIONUEVO_USD,V_WEBID);
    INSERT INTO tbl_prodcuto_moneda
    VALUES(P_MONEDA_PEN,P_PRECIO_PEN,P_PRECIONUEVO_PEN,V_WEBID);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_categoria`
--

CREATE TABLE `tbl_categoria` (
  `codigo` int(11) NOT NULL,
  `nombre` varchar(30) DEFAULT NULL,
  `visible` tinyint(1) DEFAULT 1,
  `categoria_superior` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tbl_categoria`
--

INSERT INTO `tbl_categoria` (`codigo`, `nombre`, `visible`, `categoria_superior`) VALUES
(1, 'ROPA DEPORTIVA', 1, 1),
(2, 'NIKE', 1, 1),
(3, 'ADIDAS', 1, 1),
(4, 'PUMA', 1, 1),
(5, 'HOMBRES', 1, 5),
(7, 'SACOS', 1, 5),
(8, 'PANTALONES', 1, 5),
(9, 'NIÑOS', 1, 9),
(10, 'MUJERES', 1, 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_marca`
--

CREATE TABLE `tbl_marca` (
  `codigo` int(11) NOT NULL,
  `nombre` varchar(30) DEFAULT NULL,
  `visible` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tbl_marca`
--

INSERT INTO `tbl_marca` (`codigo`, `nombre`, `visible`) VALUES
(1, 'NIKE', 1),
(2, 'ADIDAS', 1),
(3, 'PUMA', 1),
(4, 'LACOSTE', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_prodcuto_moneda`
--

CREATE TABLE `tbl_prodcuto_moneda` (
  `moneda` char(3) NOT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `precionuevo` decimal(10,2) DEFAULT NULL,
  `webid` int(11) NOT NULL
) ;

--
-- Volcado de datos para la tabla `tbl_prodcuto_moneda`
--

INSERT INTO `tbl_prodcuto_moneda` (`moneda`, `precio`, `precionuevo`, `webid`) VALUES
('COP', '5.00', '0.00', 3),
('COP', '80000.00', '0.00', 4),
('COP', '45000.00', '0.00', 6),
('COP', '60000.00', '0.00', 7),
('COP', '120000.00', '0.00', 8),
('COP', '150000.00', '0.00', 9),
('COP', '800.00', '0.00', 10),
('COP', '60.00', '0.00', 11),
('PEN', '6.00', '0.00', 3),
('PEN', '20.00', '0.00', 4),
('PEN', '50.00', '0.00', 6),
('PEN', '30.00', '0.00', 7),
('PEN', '60.00', '0.00', 8),
('PEN', '45.00', '0.00', 9),
('PEN', '111.00', '0.00', 10),
('PEN', '90.00', '0.00', 11),
('USD', '6.00', '0.00', 3),
('USD', '20.00', '0.00', 4),
('USD', '50.00', '0.00', 6),
('USD', '30.00', '0.00', 7),
('USD', '60.00', '0.00', 8),
('USD', '45.00', '0.00', 9),
('USD', '111.00', '0.00', 10),
('USD', '90.00', '0.00', 11);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_producto`
--

CREATE TABLE `tbl_producto` (
  `webid` int(11) NOT NULL,
  `nombre` varchar(30) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `precionuevo` decimal(10,2) DEFAULT NULL,
  `stock` int(11) DEFAULT 1,
  `nuevo` tinyint(1) DEFAULT 1,
  `recomendado` tinyint(1) DEFAULT 0,
  `descripcion` varchar(255) DEFAULT NULL,
  `visible` tinyint(1) DEFAULT 1,
  `codigo_marca` int(11) DEFAULT NULL,
  `codigo_categoria` int(11) DEFAULT NULL,
  `img` varchar(100) DEFAULT 'demo.png'
) ;

--
-- Volcado de datos para la tabla `tbl_producto`
--

INSERT INTO `tbl_producto` (`webid`, `nombre`, `precio`, `precionuevo`, `stock`, `nuevo`, `recomendado`, `descripcion`, `visible`, `codigo_marca`, `codigo_categoria`, `img`) VALUES
(3, 'Camiseta Hombre', '500.00', '0.00', 0, 1, 1, '                      jsdhakjdkjhakda                      ', 1, 2, 4, '02420200159497755662560612557822pro1.jpg'),
(4, 'Buso Puma', '500.00', '0.00', 50, 1, 1, 'Buso puma niÃ±os                                            ', 1, 3, 9, '0242020122828-2834380861320484931pu5.jpg'),
(5, 'Buso Puma', '80000.00', '78000.00', 4, 1, 1, 'es algodÃ³n,  ', 1, 3, 10, '1242020105547-3803816759362970801pu.jpg'),
(6, 'Camiseta Hombre', '45000.00', '0.00', 6, 1, 0, '              en algodÃ³n, no destiÃ±e                          ', 1, 1, 5, '1242020105926-9120826030595982681pro3.jpg'),
(7, 'camisa dama', '60000.00', '0.00', 5, 1, 0, 'en seda, naranja', 1, 3, 10, '1242020110122-801297313901782936pro2.jpg'),
(8, 'jeans', '120000.00', '0.00', 2, 1, 0, 'de tiro alto, azul, bota recta                                            ', 1, 4, 10, '12420201103236306159828788193262pro2.jpg'),
(9, 'Buso Hombre', '150000.00', '0.00', 6, 1, 0, 'de  algodon                                             ', 1, 1, 5, '1242020110546-3512039562656682317pro5.jpg'),
(10, 'pino', '500.00', '0.00', 2, 1, 1, '                                            ', 1, 2, 8, '12420201119304493168233064975530pro5.jpg'),
(11, 'Camiseta Hombre', '50.00', '0.00', 1, 1, 1, '                                            ', 1, 1, 9, '12420201124234516894036994641296pu4.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_revision`
--

CREATE TABLE `tbl_revision` (
  `codigo` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `correo` varchar(60) DEFAULT NULL,
  `comentario` varchar(200) DEFAULT NULL,
  `estrellas` int(11) DEFAULT 3,
  `fecha` datetime DEFAULT NULL,
  `revision_webid` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tbl_categoria`
--
ALTER TABLE `tbl_categoria`
  ADD PRIMARY KEY (`codigo`),
  ADD UNIQUE KEY `nombre` (`nombre`),
  ADD KEY `categoria_superior` (`categoria_superior`);

--
-- Indices de la tabla `tbl_marca`
--
ALTER TABLE `tbl_marca`
  ADD PRIMARY KEY (`codigo`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `tbl_prodcuto_moneda`
--
ALTER TABLE `tbl_prodcuto_moneda`
  ADD PRIMARY KEY (`moneda`,`webid`),
  ADD KEY `webid` (`webid`);

--
-- Indices de la tabla `tbl_producto`
--
ALTER TABLE `tbl_producto`
  ADD PRIMARY KEY (`webid`),
  ADD KEY `codigo_marca` (`codigo_marca`),
  ADD KEY `codigo_categoria` (`codigo_categoria`);

--
-- Indices de la tabla `tbl_revision`
--
ALTER TABLE `tbl_revision`
  ADD PRIMARY KEY (`codigo`),
  ADD KEY `revision_webid` (`revision_webid`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tbl_categoria`
--
ALTER TABLE `tbl_categoria`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `tbl_marca`
--
ALTER TABLE `tbl_marca`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tbl_producto`
--
ALTER TABLE `tbl_producto`
  MODIFY `webid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tbl_revision`
--
ALTER TABLE `tbl_revision`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tbl_categoria`
--
ALTER TABLE `tbl_categoria`
  ADD CONSTRAINT `tbl_categoria_ibfk_1` FOREIGN KEY (`categoria_superior`) REFERENCES `tbl_categoria` (`codigo`);

--
-- Filtros para la tabla `tbl_prodcuto_moneda`
--
ALTER TABLE `tbl_prodcuto_moneda`
  ADD CONSTRAINT `tbl_prodcuto_moneda_ibfk_1` FOREIGN KEY (`webid`) REFERENCES `tbl_producto` (`webid`);

--
-- Filtros para la tabla `tbl_producto`
--
ALTER TABLE `tbl_producto`
  ADD CONSTRAINT `tbl_producto_ibfk_1` FOREIGN KEY (`codigo_marca`) REFERENCES `tbl_marca` (`codigo`),
  ADD CONSTRAINT `tbl_producto_ibfk_2` FOREIGN KEY (`codigo_categoria`) REFERENCES `tbl_categoria` (`codigo`);

--
-- Filtros para la tabla `tbl_revision`
--
ALTER TABLE `tbl_revision`
  ADD CONSTRAINT `tbl_revision_ibfk_1` FOREIGN KEY (`revision_webid`) REFERENCES `tbl_producto` (`webid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
