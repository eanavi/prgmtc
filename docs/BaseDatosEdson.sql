-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 23-07-2019 a las 14:03:20
-- Versión del servidor: 5.6.17
-- Versión de PHP: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `smartlib2019_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `almacenes`
--


--
-- Volcado de datos para la tabla `almacenes`
--

INSERT INTO `almacenes` (`id`, `nombre`, `direccion`, `telefono`, `estado`) VALUES
(1, 'Almacén Principal', 'Calle cañoto Nro', '-', 'HAB'),
(2, 'Segunda Sucursal', 'Calle Aspiazu nro 123', '2233333', 'HAB'),
(3, 'Tercera Sucursal', '-', '-', 'HAB');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE IF NOT EXISTS `categorias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `descripcion` (`descripcion`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=56 ;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `descripcion`) VALUES
(30, '1000ESPRESSOS'),
(2, 'ARMON'),
(1, 'ARTICO'),
(24, 'BALMAK'),

(50, 'WICTORY');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE IF NOT EXISTS `clientes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ci` varchar(20) NOT NULL,
  `nit` bigint(20) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `apellido1` varchar(20) NOT NULL,
  `apellido2` varchar(20) NOT NULL,
  `cel1` int(11) NOT NULL,
  `cel2` int(11) NOT NULL,
  `direccion` varchar(300) NOT NULL,
  `email` varchar(300) NOT NULL,
  `monto_max_deuda` double NOT NULL,
  `cantidad_max_deuda` int(11) NOT NULL,
  `estado` varchar(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ci` (`ci`,`nit`,`apellido1`,`email`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id`, `ci`, `nit`, `nombre`, `apellido1`, `apellido2`, `cel1`, `cel2`, `direccion`, `email`, `monto_max_deuda`, `cantidad_max_deuda`, `estado`) VALUES
(1, '12345', 1234567, 'JORGE', 'VARGAS', 'VELARDE', 222222, 233333, 'VILLA TUNARI ', 'jorge@gmail.com', 8000, 3, 'HAB');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracion`
--

CREATE TABLE IF NOT EXISTS `configuracion` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador de Registro',
  `campo` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'Nombre de variable o nombre de campo ',
  `valor` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'valor del campo',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=21 ;

--
-- Volcado de datos para la tabla `configuracion`
--

INSERT INTO `configuracion` (`id`, `campo`, `valor`) VALUES
(1, 'almacenPrincipal', '1'),
(2, 'monedaPrincipal', '1'),
(3, 'nombreSistema', 'Online.bo'),
(4, 'idLlaveActiva', '1'),
(5, 'numeroFactura', '67'),
(12, 'nitSucursal', '987654321'),
(13, 'nombreCasaMatriz', 'Empresa S.R.L.'),
(14, 'direccionCasaMatriz', 'Av. San Martin 147 Piso 2 Of. 4A'),
(15, 'telefonoCasaMatriz', '4510871 - 4792704'),
(16, 'actividadEconomica', 'INDUSTRIAL'),
(19, 'tipo_cambio_dolar', '6.97'),
(20, 'sitioWeb', 'www.google.com.bo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `documentos`
--

CREATE TABLE IF NOT EXISTS `documentos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Identificador de Registro',
  `id_documento` int(11) NOT NULL,
  `id_tipo_documento` int(11) NOT NULL,
  `id_almacen_origen` int(11) NOT NULL,
  `id_almacen_destino` int(11) NOT NULL,
  `id_cliente` bigint(11) NOT NULL,
  `tipo_cambio` double NOT NULL,
  `fecha` datetime NOT NULL,
  `descuento` double NOT NULL,
  `usuario` varchar(40) NOT NULL,
  `total` double NOT NULL,
  `efectivo` double NOT NULL,
  `cambio` double NOT NULL,
  `estado` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_documento` (`id_documento`),
  KEY `id_tipo_documento` (`id_tipo_documento`),
  KEY `id_almacen_origen` (`id_almacen_origen`,`id_almacen_destino`),
  KEY `id_cliente` (`id_cliente`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `documentos`
--

INSERT INTO `documentos` (`id`, `id_documento`, `id_tipo_documento`, `id_almacen_origen`, `id_almacen_destino`, `id_cliente`, `tipo_cambio`, `fecha`, `descuento`, `usuario`, `total`, `efectivo`, `cambio`, `estado`) VALUES
(1, 1, 7, 1, 0, 0, 6.97, '2019-07-15 12:11:42', 0, '22', 273000, 273000, 0, 'V'),
(2, 1, 2, 1, 0, 0, 6.97, '2019-07-15 12:11:57', 0, '22', 2730, 2730, 0, 'V'),
(3, 1, 3, 1, 0, 1, 6.97, '2019-07-15 12:12:16', 0, '22', 5460, 5460, 0, 'V');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `existencias`
--

CREATE TABLE IF NOT EXISTS `existencias` (
  `id_producto` int(11) NOT NULL,
  `id_almacen` int(11) NOT NULL,
  `stock` int(11) NOT NULL,
  PRIMARY KEY (`id_producto`,`id_almacen`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `existencias`
--

INSERT INTO `existencias` (`id_producto`, `id_almacen`, `stock`) VALUES
(3, 1, 97);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `file`
--

CREATE TABLE IF NOT EXISTS `file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image` longtext NOT NULL,
  `ext` varchar(20) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=20 ;

--
-- Volcado de datos para la tabla `file`
--

INSERT INTO `file` (`id`, `image`, `ext`, `id_usuario`) VALUES
(18, 'data:image/jpeg;base64,/9j/4AAQSkZJ', 'image/jpeg', 19);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `kardex`
--

CREATE TABLE IF NOT EXISTS `kardex` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Identificador de Registro',
  `id_documento` bigint(20) NOT NULL,
  `id_tipo_documento` bigint(20) NOT NULL,
  `producto` varchar(150) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_unitario` double NOT NULL,
  `precio_total` double NOT NULL,
  `descuento` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_documento` (`id_documento`),
  KEY `id_tipo_documento` (`id_tipo_documento`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `kardex`
--

INSERT INTO `kardex` (`id`, `id_documento`, `id_tipo_documento`, `producto`, `cantidad`, `precio_unitario`, `precio_total`, `descuento`) VALUES
(1, 1, 7, 'CAJAS TERMICAS GALVANIZADAS CAP. 360 LTS', 100, 2730, 273000, 0),
(2, 1, 2, 'CAJAS TERMICAS GALVANIZADAS CAP. 360 LTS', 1, 2730, 2730, 0),
(3, 1, 3, 'CAJAS TERMICAS GALVANIZADAS CAP. 360 LTS', 2, 2730, 5460, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marcas`
--

CREATE TABLE IF NOT EXISTS `marcas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `descripcion` (`descripcion`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=247 ;

--
-- Volcado de datos para la tabla `marcas`
--

INSERT INTO `marcas` (`id`, `descripcion`) VALUES
(164, 'ABLANDADOR DE AGUA'),
(28, 'ABLANDADOR DE CARNE'),
(228, 'ACCESORIOS'),
(120, 'AMASADORA BASCULANTE'),
(212, 'AMASADORA DE CHURROS'),

(148, 'WAFLERAS ELECTRICAS');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `menu`
--

CREATE TABLE IF NOT EXISTS `menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `texto` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `enlace` varchar(250) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `padre` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=22 ;

--
-- Volcado de datos para la tabla `menu`
--

INSERT INTO `menu` (`id`, `texto`, `enlace`, `padre`) VALUES
(1, 'Productos', 'products.php', 1),
(2, 'Ventas', 'store.php', 3),
(5, 'Rep. de Ventas', 'sells.php', 3),
(6, 'Marcas', 'categories.php', 1),
(7, 'Almacenes', 'warehouses.php', 1),
(8, 'Traspasos', 'transfers.php', 3),
(9, 'Reporte de Ventas', 'reports.php', 2),
(12, 'Almacenes.', 'select.php', 0),
(18, 'Usuarios', 'users.php', 3),
(19, 'Reportes', 'admin_reports.php', 2),
(20, 'Clientes', 'client.php', 1),
(21, 'Inventario Inicial', 'inventory.php', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos`
--

CREATE TABLE IF NOT EXISTS `pagos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_documento` bigint(20) NOT NULL,
  `id_tipo_documento` bigint(20) NOT NULL,
  `id_almacen` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `monto` double NOT NULL,
  `estado` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_documento` (`id_documento`,`id_tipo_documento`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `pagos`
--

INSERT INTO `pagos` (`id`, `id_documento`, `id_tipo_documento`, `id_almacen`, `id_usuario`, `fecha`, `monto`, `estado`) VALUES
(1, 1, 3, 1, 22, '2019-07-15 12:12:16', 450, 'V');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paises`
--

CREATE TABLE IF NOT EXISTS `paises` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `descripcion` (`descripcion`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Volcado de datos para la tabla `paises`
--

INSERT INTO `paises` (`id`, `descripcion`) VALUES
(5, 'ARGENTINA'),
(1, 'BRASILERA'),
(4, 'CHILENA'),
(2, 'CHINA'),
(7, 'ESPAÑOLA-SUIZA'),
(3, 'ITALIANA'),
(9, 'NACIONAL'),
(8, 'REPUESTO'),
(6, 'TURQUIA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE IF NOT EXISTS `productos` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'clave principal',
  `modelo` varchar(100) NOT NULL,
  `descripcion` varchar(250) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `id_marca` int(11) NOT NULL,
  `id_pais` int(11) NOT NULL,
  `precio` float NOT NULL,
  `estado` varchar(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `codigo` (`modelo`,`id_categoria`),
  KEY `id_categoria` (`id_categoria`,`id_marca`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=521 ;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `modelo`, `descripcion`, `id_categoria`, `id_marca`, `id_pais`, `precio`, `estado`) VALUES
(1, 'SC-224GLC', 'EXPOSITOR DE HELADO EN PASTA 12 CUBAS', 1, 1, 1, 5313, 'HAB'),
(2, 'TMI-360', 'CAJAS TERMICAS INOX. CAP. 360 LTS', 2, 2, 1, 3780, 'HAB'),
(3, 'TMG-360', 'CAJAS TERMICAS GALVANIZADAS CAP. 360 LTS', 2, 2, 1, 2730, 'HAB'),
(4, 'B-500IG2', 'EMBALADORA DE ALIMENTOS ACERO INOX', 3, 3, 1, 0, 'HAB'),

(520, 'TEST', 'tesd eds', 30, 164, 5, 345, 'HAB');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rol` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `rol`) VALUES
(1, 'Administrador'),
(2, 'Cajer@'),
(3, 'Gerente'),
(5, 'Super Administrador');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol_menu`
--

CREATE TABLE IF NOT EXISTS `rol_menu` (
  `id_rol` int(11) NOT NULL,
  `id_menu` int(11) NOT NULL,
  PRIMARY KEY (`id_rol`,`id_menu`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `rol_menu`
--

INSERT INTO `rol_menu` (`id_rol`, `id_menu`) VALUES
(1, 1),
(1, 2),
(1, 9),
(1, 12),
(1, 20),
(1, 21),
(2, 2),
(2, 20),
(5, 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_documento`
--

CREATE TABLE IF NOT EXISTS `tipo_documento` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(250) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `correlativo` bigint(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=17 ;

--
-- Volcado de datos para la tabla `tipo_documento`
--

INSERT INTO `tipo_documento` (`id`, `descripcion`, `correlativo`) VALUES
(1, 'TRASPASO', 0),
(2, 'VENTA A CONTADO', 1),
(3, 'CREDITO A CLIENTE', 1),
(4, 'BAJA DE INVENTARIO ', 0),
(5, 'COTIZACION', 0),
(6, 'INGRESO DE MERCADERIA', 0),
(7, 'INVENTARIO INICIAL', 1),
(8, 'ANULACION', 0),
(9, 'VENTA FACTURA MANUAL', 0),
(10, 'CONTROL DE INSUMOS', 0),
(11, 'PRODUCTOS', 520),
(15, 'SERVICIOS', 246),
(16, 'CATEGORIAS', 55);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador de Registro',
  `nombre` varchar(100) NOT NULL COMMENT 'Nombre Completo del usuario',
  `usr` varchar(25) NOT NULL COMMENT 'Nombre del usuario',
  `pwd` varchar(255) NOT NULL COMMENT 'Password del usuario',
  `id_rol` int(11) NOT NULL COMMENT 'Identificador del rol',
  `id_almacen` int(11) NOT NULL,
  `habilitado` varchar(3) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `email1` varchar(150) NOT NULL,
  `email2` varchar(150) NOT NULL,
  `cel1` varchar(25) NOT NULL,
  `cel2` varchar(25) NOT NULL,
  `direccion1` varchar(250) NOT NULL,
  `cargo` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `habilitado` (`habilitado`),
  KEY `id_rol` (`id_rol`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=23 ;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `usr`, `pwd`, `id_rol`, `id_almacen`, `habilitado`, `email1`, `email2`, `cel1`, `cel2`, `direccion1`, `cargo`) VALUES
(6, 'Super Administrador', 'super', 'vgcsfR7Dfn0rVFzNmIcslA==', 5, 1, '1', '', '', '', '', '', ''),
(19, 'Cajero', 'cajero', 'D9FClw+Eg1tot5Wf1YmIRg==', 2, 3, '1', 'cajero1@gmail.com', 'cajero1@hotmail.com', '5555555', '7777777', 'villa aruquipa 292', 'Vendedor'),
(22, 'Dante Flores V.', 'admin', 'lyNpj/1gW81zRRXyd4mi1Q==', 1, 1, '1', 'veneros.edson@gmail.com', 'nomail@algo.com', '77570479', '(592)77570479', 'V. Copacabana, Av. Circunvalación Nro. 12', 'Administrador de Sistemas');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
