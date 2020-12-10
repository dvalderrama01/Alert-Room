-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 22-09-2020 a las 16:11:37
-- Versión del servidor: 10.4.14-MariaDB
-- Versión de PHP: 7.4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `db_alert_room`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ambientes`
--

CREATE TABLE `ambientes` (
  `idambiente` varchar(10) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `numero` varchar(4) NOT NULL,
  `estado` char(1) NOT NULL,
  `ocupado` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ambiente_inventario`
--

CREATE TABLE `ambiente_inventario` (
  `idambiente` varchar(10) NOT NULL,
  `idarticulo` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `articulos`
--

CREATE TABLE `articulos` (
  `idarticulo` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `conceptos`
--

CREATE TABLE `conceptos` (
  `idconcepto` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `aplica` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `novedades`
--

CREATE TABLE `novedades` (
  `idnovedad` int(11) NOT NULL,
  `idambiente` varchar(10) NOT NULL,
  `idusuarioI` varchar(11) NOT NULL,
  `fechahora` datetime NOT NULL,
  `idusuarioG` varchar(11) NOT NULL,
  `observaciones` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitudes`
--

CREATE TABLE `solicitudes` (
  `idsolicitud` int(11) NOT NULL,
  `idambiente` varchar(10) NOT NULL,
  `idusuario` varchar(11) NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `concepto` int(11) NOT NULL,
  `observaciones` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `identificacion` varchar(11) NOT NULL,
  `nombres` varchar(41) NOT NULL,
  `apellidos` varchar(41) NOT NULL,
  `contrasena` char(32) NOT NULL,
  `email` varchar(50) NOT NULL,
  `telefono` varchar(25) NOT NULL,
  `tipo_usuario` char(1) NOT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `estado` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ambientes`
--
ALTER TABLE `ambientes`
  ADD PRIMARY KEY (`idambiente`);

--
-- Indices de la tabla `ambiente_inventario`
--
ALTER TABLE `ambiente_inventario`
  ADD KEY `fk_ambiente` (`idambiente`),
  ADD KEY `fk_articulo` (`idarticulo`);

--
-- Indices de la tabla `articulos`
--
ALTER TABLE `articulos`
  ADD PRIMARY KEY (`idarticulo`);

--
-- Indices de la tabla `conceptos`
--
ALTER TABLE `conceptos`
  ADD PRIMARY KEY (`idconcepto`);

--
-- Indices de la tabla `novedades`
--
ALTER TABLE `novedades`
  ADD PRIMARY KEY (`idnovedad`),
  ADD KEY `fk_id_ambiente_novedad` (`idambiente`),
  ADD KEY `fk_novedad_instructor_id` (`idusuarioI`),
  ADD KEY `fk_novedad_guarda_id` (`idusuarioG`);

--
-- Indices de la tabla `solicitudes`
--
ALTER TABLE `solicitudes`
  ADD PRIMARY KEY (`idsolicitud`),
  ADD KEY `fk_ambiente_identificador` (`idambiente`),
  ADD KEY `fk_usuario_identificador` (`idusuario`),
  ADD KEY `fk_concepto_identificador` (`concepto`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`identificacion`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `articulos`
--
ALTER TABLE `articulos`
  MODIFY `idarticulo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `conceptos`
--
ALTER TABLE `conceptos`
  MODIFY `idconcepto` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `novedades`
--
ALTER TABLE `novedades`
  MODIFY `idnovedad` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `solicitudes`
--
ALTER TABLE `solicitudes`
  MODIFY `idsolicitud` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `ambiente_inventario`
--
ALTER TABLE `ambiente_inventario`
  ADD CONSTRAINT `fk_ambiente` FOREIGN KEY (`idambiente`) REFERENCES `ambientes` (`idambiente`),
  ADD CONSTRAINT `fk_articulo` FOREIGN KEY (`idarticulo`) REFERENCES `articulos` (`idarticulo`);

--
-- Filtros para la tabla `novedades`
--
ALTER TABLE `novedades`
  ADD CONSTRAINT `fk_id_ambiente_novedad` FOREIGN KEY (`idambiente`) REFERENCES `ambientes` (`idambiente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_novedad_guarda_id` FOREIGN KEY (`idusuarioG`) REFERENCES `usuarios` (`identificacion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_novedad_instructor_id` FOREIGN KEY (`idusuarioI`) REFERENCES `usuarios` (`identificacion`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `solicitudes`
--
ALTER TABLE `solicitudes`
  ADD CONSTRAINT `fk_ambiente_identificador` FOREIGN KEY (`idambiente`) REFERENCES `ambientes` (`idambiente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_concepto_identificador` FOREIGN KEY (`concepto`) REFERENCES `conceptos` (`idconcepto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_usuario_identificador` FOREIGN KEY (`idusuario`) REFERENCES `usuarios` (`identificacion`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
