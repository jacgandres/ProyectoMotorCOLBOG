CREATE TABLE Pais (
  idPais INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  Nombre VARCHAR(100) NOT NULL,
  FecheRegistro DATETIME NOT NULL,
  PRIMARY KEY(idPais)
);

CREATE TABLE FormaPago (
  idFormaPago INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  Descripcion VARCHAR(100) NOT NULL,
  Activo BOOL NOT NULL,
  FechaRegistro DATETIME NOT NULL,
  PRIMARY KEY(idFormaPago)
);

CREATE TABLE EstadoContrato (
  idEstadoContrato INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  Descripcion VARCHAR(100) NOT NULL,
  Activo BOOL NOT NULL,
  FechaRegistro DATETIME NOT NULL,
  PRIMARY KEY(idEstadoContrato)
);

CREATE TABLE TipoReserva (
  idTipoReserva INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  Nombre VARCHAR NULL,
  FechaRegistro INTEGER UNSIGNED NULL,
  Estado BOOL NULL,
  PRIMARY KEY(idTipoReserva)
);

CREATE TABLE TipoIdentificacion (
  idTipoIdentificacion INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  Nombre VARCHAR(100) NOT NULL,
  Activo BOOL NOT NULL,
  FechaRegistro DATETIME NOT NULL,
  PRIMARY KEY(idTipoIdentificacion)
);

CREATE TABLE Perfil (
  idPerfil INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  Descripcion VARCHAR(100) NOT NULL,
  idFacebook VARCHAR(200) NULL,
  idTwitter VARCHAR(100) NULL,
  Instagram VARCHAR(100) NULL,
  idGoogle VARCHAR(100) NULL,
  Activo BOOL NOT NULL,
  FechaRegistro DATETIME NOT NULL,
  PRIMARY KEY(idPerfil)
);

CREATE TABLE CanalVenta (
  idCanalVenta INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  Nombre VARCHAR NULL,
  FechaRegistro DATETIME NULL,
  PRIMARY KEY(idCanalVenta)
);

CREATE TABLE Departamento (
  idDepartamento INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  Pais_idPais INTEGER UNSIGNED NOT NULL,
  Nombre VARCHAR(100) NOT NULL,
  FechaRegistro DATETIME NOT NULL,
  PRIMARY KEY(idDepartamento),
  INDEX Departamento_FKIndex1(Pais_idPais),
  FOREIGN KEY(Pais_idPais)
    REFERENCES Pais(idPais)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE Ciudad (
  idCiudad INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  Departamento_idDepartamento INTEGER UNSIGNED NOT NULL,
  Nombre VARCHAR(100) NOT NULL,
  FechaRegistro DATETIME NOT NULL,
  PRIMARY KEY(idCiudad),
  INDEX Ciudad_FKIndex1(Departamento_idDepartamento),
  FOREIGN KEY(Departamento_idDepartamento)
    REFERENCES Departamento(idDepartamento)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE ClienteExterno (
  idClienteExterno INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  Perfil_idPerfil INTEGER UNSIGNED NOT NULL,
  Ciudad_idCiudad INTEGER UNSIGNED NOT NULL,
  Nombre VARCHAR(100) NOT NULL,
  Apellido VARCHAR(100) NOT NULL,
  Telefono VARCHAR(10) NULL,
  Email VARCHAR(100) NOT NULL,
  Direccion VARCHAR(100) NULL,
  Imagen VARCHAR(100) NULL,
  FechaUltimoIngreso DATETIME NOT NULL,
  Activo BOOL NOT NULL,
  FechaRegistro DATETIME NOT NULL,
  PRIMARY KEY(idClienteExterno),
  INDEX ClienteExterno_FKIndex1(Ciudad_idCiudad),
  INDEX ClienteExterno_FKIndex2(Perfil_idPerfil),
  FOREIGN KEY(Ciudad_idCiudad)
    REFERENCES Ciudad(idCiudad)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(Perfil_idPerfil)
    REFERENCES Perfil(idPerfil)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE ClienteInterno (
  idClienteInterno INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  Nombre VARCHAR(100) NOT NULL,
  Telefono1 VARCHAR(10) NOT NULL,
  Email VARCHAR(100) NOT NULL,
  TipoIdentificacion_idTipoIdentificacion INTEGER UNSIGNED NOT NULL,
  Identificacion VARCHAR(100) NOT NULL,
  Perfil_idPerfil INTEGER UNSIGNED NOT NULL,
  Ciudad_idCiudad INTEGER UNSIGNED NOT NULL,
  Activo BOOL NOT NULL,
  FechaRegistro DATETIME NOT NULL,
  PRIMARY KEY(idClienteInterno),
  INDEX ClienteInterno_FKIndex1(Ciudad_idCiudad),
  INDEX ClienteInterno_FKIndex2(Perfil_idPerfil),
  INDEX ClienteInterno_FKIndex3(TipoIdentificacion_idTipoIdentificacion),
  FOREIGN KEY(Ciudad_idCiudad)
    REFERENCES Ciudad(idCiudad)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(Perfil_idPerfil)
    REFERENCES Perfil(idPerfil)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(TipoIdentificacion_idTipoIdentificacion)
    REFERENCES TipoIdentificacion(idTipoIdentificacion)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE Promocion (
  idPromocion INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  ClienteInterno_idClienteInterno INTEGER UNSIGNED NOT NULL,
  PRIMARY KEY(idPromocion),
  INDEX Promocion_FKIndex1(ClienteInterno_idClienteInterno),
  FOREIGN KEY(ClienteInterno_idClienteInterno)
    REFERENCES ClienteInterno(idClienteInterno)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE Sede (
  idSede INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  Ciudad_idCiudad INTEGER UNSIGNED NOT NULL,
  ClienteInterno_idClienteInterno INTEGER UNSIGNED NOT NULL,
  PRIMARY KEY(idSede),
  INDEX Sede_FKIndex1(ClienteInterno_idClienteInterno),
  INDEX Sede_FKIndex2(Ciudad_idCiudad),
  FOREIGN KEY(ClienteInterno_idClienteInterno)
    REFERENCES ClienteInterno(idClienteInterno)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(Ciudad_idCiudad)
    REFERENCES Ciudad(idCiudad)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE Contrato (
  idContrato INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  EstadoContrato_idEstadoContrato INTEGER UNSIGNED NOT NULL,
  ClienteInterno_idClienteInterno INTEGER UNSIGNED NOT NULL,
  Descripcion VARCHAR(100) NOT NULL,
  Valor INTEGER UNSIGNED NOT NULL,
  FechaInicial DATETIME NOT NULL,
  FechaFinal DATETIME NOT NULL,
  PlazoEjecucion DATETIME NOT NULL,
  Activo BOOL NOT NULL,
  FechaRegistro DATETIME NOT NULL,
  PRIMARY KEY(idContrato),
  INDEX Contrato_FKIndex1(ClienteInterno_idClienteInterno),
  INDEX Contrato_FKIndex2(EstadoContrato_idEstadoContrato),
  FOREIGN KEY(ClienteInterno_idClienteInterno)
    REFERENCES ClienteInterno(idClienteInterno)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(EstadoContrato_idEstadoContrato)
    REFERENCES EstadoContrato(idEstadoContrato)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE DetalleReserva (
  idDetalleReserva INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  Promocion_idPromocion INTEGER UNSIGNED NOT NULL,
  Sede_idSede INTEGER UNSIGNED NOT NULL,
  PRIMARY KEY(idDetalleReserva),
  INDEX DetalleReserva_FKIndex1(Sede_idSede),
  INDEX DetalleReserva_FKIndex2(Promocion_idPromocion),
  FOREIGN KEY(Sede_idSede)
    REFERENCES Sede(idSede)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(Promocion_idPromocion)
    REFERENCES Promocion(idPromocion)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE ClienteExterno_tiene_ClienteInterno (
  IdClienteExterno_tiene_ClienteInterno INTEGER UNSIGNED NOT NULL,
  ClienteExterno_idClienteExterno INTEGER UNSIGNED NOT NULL,
  ClienteInterno_idClienteInterno INTEGER UNSIGNED NOT NULL,
  Activo BOOL NOT NULL,
  FechaRegistro DATETIME NOT NULL,
  PRIMARY KEY(IdClienteExterno_tiene_ClienteInterno),
  INDEX ClienteExterno_tiene_ClienteInterno_FKIndex1(ClienteInterno_idClienteInterno),
  INDEX ClienteExterno_tiene_ClienteInterno_FKIndex2(ClienteExterno_idClienteExterno),
  FOREIGN KEY(ClienteInterno_idClienteInterno)
    REFERENCES ClienteInterno(idClienteInterno)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(ClienteExterno_idClienteExterno)
    REFERENCES ClienteExterno(idClienteExterno)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE Reserva (
  idReserva INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  ClienteExterno_tiene_ClienteInterno_IdClienteExterno_tiene_ClienteInterno INTEGER UNSIGNED NOT NULL,
  DetalleReserva_idDetalleReserva INTEGER UNSIGNED NOT NULL,
  TipoReserva_idTipoReserva INTEGER UNSIGNED NOT NULL,
  PRIMARY KEY(idReserva),
  INDEX Reserva_FKIndex2(TipoReserva_idTipoReserva),
  INDEX Reserva_FKIndex3(DetalleReserva_idDetalleReserva),
  INDEX Reserva_FKIndex4(ClienteExterno_tiene_ClienteInterno_IdClienteExterno_tiene_ClienteInterno),
  FOREIGN KEY(TipoReserva_idTipoReserva)
    REFERENCES TipoReserva(idTipoReserva)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(DetalleReserva_idDetalleReserva)
    REFERENCES DetalleReserva(idDetalleReserva)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(ClienteExterno_tiene_ClienteInterno_IdClienteExterno_tiene_ClienteInterno)
    REFERENCES ClienteExterno_tiene_ClienteInterno(IdClienteExterno_tiene_ClienteInterno)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE CanalVenta_tiene_Reserva (
  CanalVenta_idCanalVenta INTEGER UNSIGNED NOT NULL,
  Reserva_idReserva INTEGER UNSIGNED NOT NULL,
  PRIMARY KEY(CanalVenta_idCanalVenta, Reserva_idReserva),
  INDEX CanalVenta_has_Reserva_FKIndex1(CanalVenta_idCanalVenta),
  INDEX CanalVenta_has_Reserva_FKIndex2(Reserva_idReserva),
  FOREIGN KEY(CanalVenta_idCanalVenta)
    REFERENCES CanalVenta(idCanalVenta)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(Reserva_idReserva)
    REFERENCES Reserva(idReserva)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE FormaPago_tiene_Reserva (
  FormaPago_idFormaPago INTEGER UNSIGNED NOT NULL,
  Reserva_idReserva INTEGER UNSIGNED NOT NULL,
  Activo BOOL NULL,
  FechaRegistro DATETIME NULL,
  PRIMARY KEY(FormaPago_idFormaPago, Reserva_idReserva),
  INDEX FormaPago_has_Reserva_FKIndex1(FormaPago_idFormaPago),
  INDEX FormaPago_has_Reserva_FKIndex2(Reserva_idReserva),
  FOREIGN KEY(FormaPago_idFormaPago)
    REFERENCES FormaPago(idFormaPago)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(Reserva_idReserva)
    REFERENCES Reserva(idReserva)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);


