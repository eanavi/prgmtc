from datetime import datetime
from sqlalchemy import Table, Column, ForeignKey, MetaData
from sqlalchemy.orm import relationship, backref
from werkzeug.security import generate_password_hash, check_password_hash
from sqlalchemy.dialects.postgresql import JSON
from geoalchemy2 import Geometry
from app import db


'''
Area Empresarial 
'''

metadata = db.metadata

class Empresa(db.Model):
    __tablename__ = 'empresa'
    id = db.Column(db.Integer, primary_key=True, comment='el id - 1 indica empresa principal')
    nombre = db.Column(db.String(20), nullable=False, unique=True)
    nit = db.Column(db.String(20))
    direccion = db.Column(db.String(20))
    telefono = db.Column(db.String(20))
    ubicacion = db.Column(Geometry('POINT'))

    departamentos = relationship('Deptos')

    #campos seguridad
    usuario = db.Column(db.String(20), nullable=False)
    fechaReg = db.Column(db.DateTime, default=datetime.now(), comment = 'Fecha de Creacion del Registro')
    ipCliente = db.Column(db.String(50), nullable=False)
    estado = db.Column(db.String(2), default='Vi')


class Deptos(db.Model):
    __tablename__ = 'departamento'
    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(20))
    id_empresa = db.Column(db.Integer, ForeignKey('empresa.id'))
    id_superior = db.Column(db.Integer, comment='0 es superior \
        de lo contrario debe tener un id de quien depende')
    
    Almacenes = relationship('Almacenes')
    Empleados = relationship('Empleados')

    #campos seguridad
    usuario = db.Column(db.String(20), nullable=False)
    fechaReg = db.Column(db.DateTime, default=datetime.now(), comment = 'Fecha de Creacion del Registro')
    ipCliente = db.Column(db.String(50), nullable=False)
    estado = db.Column(db.String(2), default='Vi')

class Almacenes(db.Model):
    __tablename__ = 'almacen'
    id = db.Column(db.Integer, primary_key = True)
    nombre = db.Column(db.String(20))
    id_departamento = db.Column(db.Integer, ForeignKey('departamento.id'))
    direccion = db.Column(db.String(250))
    telefono = db.Column(db.String(20))
    ubicacion = db.Column(Geometry('POINT'))
    id_responsable = db.Column(db.Integer,ForeignKey('empleado.id'))
    
    #campos seguridad
    usuario = db.Column(db.String(20), nullable=False)
    fechaReg = db.Column(db.DateTime, default=datetime.now(), comment = 'Fecha de Creacion del Registro')
    ipCliente = db.Column(db.String(50), nullable=False)
    estado = db.Column(db.String(2), default='Vi')

class Personas(db.Model):
    __tablename__ = 'persona'
    id = db.Column(db.Integer, primary_key = True)
    nombres = db.Column(db.String(60))
    primer_apellido = db.Column(db.String(60))
    segudo_apellido = db.Column(db.String(60))
    ci = db.Column(db.String(20))
    ext = db.Column(db.String(2))

    #campos seguridad
    usuario = db.Column(db.String(20), nullable=False)
    fechaReg = db.Column(db.DateTime, default=datetime.now(), comment = 'Fecha de Creacion del Registro')
    ipCliente = db.Column(db.String(50), nullable=False)
    estado = db.Column(db.String(2), default='Vi')

class Empleados(db.Model):
    __tablename__ = 'empleado'
    id = db.Column(db.Integer, primary_key = True)
    cargo = db.Column(db.String(20))
    email = db.Column(db.String(50))

    id_departamento = db.Column(db.Integer, ForeignKey('departamento.id'))
    id_persona = db.Column(db.Integer, ForeignKey('persona.id'))

    #campos seguridad
    usuario = db.Column(db.String(20), nullable=False)
    fechaReg = db.Column(db.DateTime, default=datetime.now(), comment = 'Fecha de Creacion del Registro')
    ipCliente = db.Column(db.String(50), nullable=False)
    estado = db.Column(db.String(2), default='Vi')

class Usuario(db.Model):
    __tablename__ = 'usuario'
    id = db.Column(db.Integer, primary_key = True)
    nombre = db.Column(db.String(20), unique=True)
    clave = db.Column(db.String(255))
    ultimo_acceso = db.Column(db.DateTime, default=datetime.now())

    id_empleado = db.Column(db.Integer, ForeignKey('empleado.id'))
    id_rol = db.Column(db.Integer, ForeignKey('rol.id'))

    #campos seguridad
    usuario = db.Column(db.String(20), nullable=False)
    fechaReg = db.Column(db.DateTime, default=datetime.now(), comment = 'Fecha de Creacion del Registro')
    ipCliente = db.Column(db.String(50), nullable=False)
    estado = db.Column(db.String(2), default='Vi')

rol_menu = Table('rol_menu', metadata,
    Column('rol_id', db.Integer, ForeignKey('rol.id')),
    Column('menu_id', db.Integer, ForeignKey('menu.id')),
    Column('acceso', db.String(2)),
    Column('estado', db.String(2))
)

class Rol(db.Model):
    __tablename__ = 'rol'
    id = db.Column(db.Integer, primary_key = True)
    nombre = db.Column(db.String(40))
    accesos = db.relationship('Menu', secondary = rol_menu)
    
    #campos seguridad
    usuario = db.Column(db.String(20), nullable=False)
    fechaReg = db.Column(db.DateTime, default=datetime.now(), comment = 'Fecha de Creacion del Registro')
    ipCliente = db.Column(db.String(50), nullable=False)
    estado = db.Column(db.String(2), default='Vi')

class Menu(db.Model):
    __tablename__ = 'menu'
    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(50))
    enlace = db.Column(db.String(250))
    padre = db.Column(db.Integer, comment = 'root tiene padre 0')

    roles = db.relationship('Rol', secondary = rol_menu)

    #campos seguridad
    usuario = db.Column(db.String(20), nullable=False)
    fechaReg = db.Column(db.DateTime, default=datetime.now(), comment = 'Fecha de Creacion del Registro')
    ipCliente = db.Column(db.String(50), nullable=False)
    estado = db.Column(db.String(2), default='Vi')

class Catalogo(db.Model):
    __tablename__ = 'catalogo'
    id = db.Column(db.Integer, primary_key=True)
    codNum = db.Column(db.Integer)
    codAlfa = db.Column(db.String(2))
    descripcion = db.Column(db.String(50))
    grupo = db.Column(db.String(10))
    orden = db.Column(db.Integer)

    estado = db.Column(db.String(2), default='Vi')

#---------------------------------
'''
   Area comercial 
'''

class tipoCambio(db.Model):
    __tablename__ = 'tipo_cambio'
    id=db.Column(db.Integer, primary_key=True)
    cambio=db.Column(db.Numeric(6,2))
    moneda=db.Column(db.String(10))
    fecha=db.Column(db.Date, comment='Fecha del tipo de cambio')

    estado = db.Column(db.String(2), default='Vi')

class Clientes(db.Model):
    __tablename__ = 'cliente'
    id = db.Column(db.Integer, primary_key=True)

    tipo_cliente = db.Column(db.String(2), comment='P=Persona, E=Empresa')
    id_cliente = db.Column(db.Integer, nullable=False, comment='persona.id si \
        tipo_cliente=P e empresa.id si tipo_cliente=E')
    nit = db.Column(db.String(20))
    direccion = db.Column(db.String(200))
    telefono = db.Column(db.String(50))
    email = db.Column(db.String(250))
    monto_max_deuda = db.Column(db.Numeric(12,4))
    cantidad_max_deuda = db.Column(db.Integer)

    #campos seguridad
    usuario = db.Column(db.String(20), nullable=False)
    fechaReg = db.Column(db.DateTime, default=datetime.now(), comment = 'Fecha de Creacion del Registro')
    ipCliente = db.Column(db.String(50), nullable=False)
    estado = db.Column(db.String(2), default='Vi')

class Brands(db.Model):
    __tablename__ = 'brand'
    id = db.Column(db.Integer, primary_key = True)
    nombre = db.Column(db.String(40))
    nit = db.Column(db.String(20))
    
    id_responsable = db.Column(db.Integer, ForeignKey('empleado.id'))

    #campos seguridad
    usuario = db.Column(db.String(20), nullable=False)
    fechaReg = db.Column(db.DateTime, default=datetime.now(), comment = 'Fecha de Creacion del Registro')
    ipCliente = db.Column(db.String(50), nullable=False)
    estado = db.Column(db.String(2), default='Vi')

class TipoProductos(db.Model):
    __tablename__ = 'tipo_producto'
    id = db.Column(db.Integer, primary_key = True)
    nombre = db.Column(db.String(40))

    id_brand = db.Column(db.Integer, ForeignKey('brand.id'))

    #campos seguridad
    usuario = db.Column(db.String(20), nullable=False)
    fechaReg = db.Column(db.DateTime, default=datetime.now(), comment = 'Fecha de Creacion del Registro')
    ipCliente = db.Column(db.String(50), nullable=False)
    estado = db.Column(db.String(2), default='Vi')

class Unidades(db.Model):
    __tablename__ = 'unidad'
    id = db.Column(db.Integer, primary_key = True)
    nombre = db.Column(db.String(20))

class Productos(db.Model):
    '''Tabla e productos por marca y luego tipo'''
    __tablename__ = 'producto'
    id = db.Column(db.Integer, primary_key = True)
    nombre = db.Column(db.String(40))
    codigo = db.Column(db.String(10), comment='interno de la empresa')
    contenedor = db.Column(db.String(10), comment='Confirmar si es un contenedor por producto')

    tipo_producto = db.Column(db.Integer, ForeignKey('tipo_producto.id'))
    unidad = db.Column(db.Integer, ForeignKey('unidad.id'))
    cantidad_tipo = db.Column(db.Integer, comment='Cantidad ')
    precio_unidad = db.Column(db.Numeric(12,4), comment='Precio por unidad')

    #campos seguridad
    usuario = db.Column(db.String(20), nullable=False)
    fechaReg = db.Column(db.DateTime, default=datetime.now(), comment = 'Fecha de Creacion del Registro')
    ipCliente = db.Column(db.String(50), nullable=False)
    estado = db.Column(db.String(2), default='Vi')

class Documentos(db.Model):
    '''Registra los documentos por tipo y por gestion un secuencial
        para identificar cada movimiento, puede ser inventario inicial, Venta

    '''
    __tablename__ = 'documento'
    id = db.Column(db.Integer, primary_key = True)
    codigo = db.Column(db.String(3), comment='Memo tecnico de tipo documento')
    nombre = db.Column(db.String(20), comment='lista secuencial de todos los movientos')
    secuencial = db.Column(db.Integer)
    gestion = db.Column(db.Integer)

    #campos seguridad
    usuario = db.Column(db.String(20), nullable=False)
    fechaReg = db.Column(db.DateTime, default=datetime.now(), comment = 'Fecha de Creacion del Registro')
    ipCliente = db.Column(db.String(50), nullable=False)
    estado = db.Column(db.String(2), default='Vi')

class Movimientos(db.Model):
    __tablename__ = 'movimiento'
    id = db.Column(db.Integer, primary_key = True)
    documento = db.Column(db.Integer, comment='Verificar si puede ser compuesto \
        con tipo y secuencial')
    almacen_origen = db.Column(db.Integer)
    almacen_destino = db.Column(db.Integer)
    fecha = db.Column(db.DateTime, default=datetime.now(), comment='fecha del movimiento')
    tipo_cambio = db.Column(db.Numeric(6,2))
    moneda = db.Column(db.String(3), comment='Bs. Bolivianos, US Dolares americanos, etc.')
    total = db.Column(db.Numeric(16,4), comment='Valor total del Movimiento')
    glosa = db.Column(db.String(500), comment='Glosa del documento')
    autoriza = db.Column(db.Integer, comment='Persona que autoriza el movimiento')
    observacion = db.Column(db.String(500))
    descripcion = db.Column(db.JSON, comment='Descripcion del Documento')

    detalles_movimiento = relationship('DetallesMovimiento')

    #campos seguridad
    usuario = db.Column(db.String(20), nullable=False)
    fechaReg = db.Column(db.DateTime, default=datetime.now(), comment = 'Fecha de Creacion del Registro')
    ipCliente = db.Column(db.String(50), nullable=False)
    estado = db.Column(db.String(2), default='Vi')

class DetallesMovimiento(db.Model):
    __tablename__ = 'detalle_movimiento'
    id = db.Column(db.Integer, primary_key = True)
    id_movimiento = db.Column(db.Integer, ForeignKey('movimiento.id'))
    id_producto = db.Column(db.Integer)
    cantidad = db.Column(db.Integer)
    precio = db.Column(db.Numeric(12,4))
    descuento = db.Column(db.Numeric(6,2))

    #campos seguridad
    usuario = db.Column(db.String(20), nullable=False)
    fechaReg = db.Column(db.DateTime, default=datetime.now(), comment = 'Fecha de Creacion del Registro')
    ipCliente = db.Column(db.String(50), nullable=False)
    estado = db.Column(db.String(2), default='Vi')

class Kardex(db.Model):
    __tablename__ = 'kardex'
    id = db.Column(db.Integer, primary_key = True)
    id_producto = db.Column(db.Integer)
    id_almacen = db.Column(db.Integer)
    sado = db.Column(db.Integer)
    precio = db.Column(db.Numeric)

    #campos seguridad
    usuario = db.Column(db.String(20), nullable=False)
    fechaReg = db.Column(db.DateTime, default=datetime.now(), comment = 'Fecha de Creacion del Registro')
    ipCliente = db.Column(db.String(50), nullable=False)
    estado = db.Column(db.String(2), default='Vi')

class Proformas(db.Model):
    __tablename__ = 'proforma'
    id = db.Column(db.Integer, primary_key = True)
    tipoVenta = db.Column(db.String(2), comment='Px=Contado, Cr=Credito')
    documento = db.Column(db.Integer, comment='Verificar si puede ser compuesto \
        con tipo y cuencial')
    almacen_origen = db.Column(db.Integer)
    vendedor = db.Column(db.Integer)
    cliente = db.Column(db.Integer)
    tipo_cambio = db.Column(db.Numeric(6,2))
    fecha = db.Column(db.DateTime, default=datetime.now())
    moneda = db.Column(db.String(3), comment='Bs. Bolivianos, US Dolares americanos, etc.')
    total = db.Column(db.Numeric(16,4), comment='Venta total')
    descripcion = db.Column(db.JSON, comment='Descripcion del Documento')

    detalles_proforma = relationship('DetallesProforma')

    #campos seguridad
    usuario = db.Column(db.String(20), nullable=False)
    fechaReg = db.Column(db.DateTime, default=datetime.now(), comment = 'Fecha de Creacion del Registro')
    ipCliente = db.Column(db.String(50), nullable=False)
    estado = db.Column(db.String(2), default='Vi')

class DetallesProforma(db.Model):
    __tablename__ = 'detalle_proforma'
    id = db.Column(db.Integer, primary_key = True)
    id_proforma = db.Column(db.Integer, ForeignKey('proforma.id'))
    id_producto = db.Column(db.Integer)
    cantidad = db.Column(db.Integer)
    precio_unitario = db.Column(db.Numeric(12,4))
    precio_total = db.Column(db.Numeric(12,4))
    descuento = db.Column(db.Numeric(12,4))

    #campos seguridad
    usuario = db.Column(db.String(20), nullable=False)
    fechaReg = db.Column(db.DateTime, default=datetime.now(), comment = 'Fecha de Creacion del Registro')
    ipCliente = db.Column(db.String(50), nullable=False)
    estado = db.Column(db.String(2), default='Vi')

class Facturas(db.Model):
    __tablename__ = 'factura'
    id = db.Column(db.Integer, primary_key = True)
    venta = db.Column(db.Integer)
    secuencial = db.Column(db.Integer)
    nit = db.Column(db.String(10))
    nombre_cliente = db.Column(db.String(10))
    autorizacion = db.Column(db.String(20))
    codigo_control = db.Column(db.String(20))
    fecha = db.Column(db.DateTime, default=datetime.now())
    descripcion = db.Column(db.JSON, comment='Descripcion del Documento')

    detalles_factura = relationship('DetallesFactura')

    #campos seguridad
    usuario = db.Column(db.String(20), nullable=False)
    fechaReg = db.Column(db.DateTime, default=datetime.now(), comment = 'Fecha de Creacion del Registro')
    ipCliente = db.Column(db.String(50), nullable=False)
    estado = db.Column(db.String(2), default='Vi')

class DetallesFactura(db.Model):
    __tablename__ = 'detalle_factura'
    id = db.Column(db.Integer, primary_key = True)
    id_factura = db.Column(db.Integer, ForeignKey('factura.id'))
    id_producto = db.Column(db.Integer)
    cantidad = db.Column(db.Integer)
    precio = db.Column(db.Numeric(12,4))
    importe = db.Column(db.Numeric(12,4))
    descuento = db.Column(db.Numeric(12,4))

    #campos seguridad
    usuario = db.Column(db.String(20), nullable=False)
    fechaReg = db.Column(db.DateTime, default=datetime.now(), comment = 'Fecha de Creacion del Registro')
    ipCliente = db.Column(db.String(50), nullable=False)
    estado = db.Column(db.String(2), default='Vi')

class Ventas(db.Model):
    __tablename__ = 'venta'
    id = db.Column(db.Integer, primary_key = True)
    tipoVenta = db.Column(db.String(2), comment='Px=Contado, Cr=Credito')
    documento = db.Column(db.Integer, comment='Verificar si puede ser compuesto \
        con tipo y cuencial')
    almacen_origen = db.Column(db.Integer)
    factura = db.Column(db.Integer)
    vendedor = db.Column(db.Integer)
    cliente = db.Column(db.Integer)
    tipo_cambio = db.Column(db.Numeric(6,2))
    fecha = db.Column(db.DateTime, default=datetime.now())
    moneda = db.Column(db.String(3), comment='Bs. Bolivianos, US Dolares americanos, etc.')
    total = db.Column(db.Numeric(16,4), comment='Venta total')
    tipo_pago = db.Column(db.String(3), comment='E=Efectivo, T=Tarjeta, C=Cheque')
    descripcion = db.Column(db.JSON, comment='Descripcion del Documento')
    detalles = relationship('DetallesVenta')
    
    #campos seguridad
    usuario = db.Column(db.String(20), nullable=False)
    fechaReg = db.Column(db.DateTime, default=datetime.now(), comment = 'Fecha de Creacion del Registro')
    ipCliente = db.Column(db.String(50), nullable=False)
    estado = db.Column(db.String(2), default='Vi')

class DetallesVenta(db.Model):
    __tablename__ = 'detalle_venta'
    id = db.Column(db.Integer, primary_key = True)
    id_venta = db.Column(db.Integer, ForeignKey('venta.id'))
    id_producto = db.Column(db.Integer)
    cantidad = db.Column(db.Integer)
    precio_unitario = db.Column(db.Numeric(12,3))
    precio_total = db.Column(db.Numeric(12,3))
    descuento = db.Column(db.Numeric(12,3))

    #campos seguridad
    usuario = db.Column(db.String(20), nullable=False)
    fechaReg = db.Column(db.DateTime, default=datetime.now(), comment = 'Fecha de Creacion del Registro')
    ipCliente = db.Column(db.String(50), nullable=False)
    estado = db.Column(db.String(2), default='Vi')


suc 
Error
reslutad