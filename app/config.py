import os

class Configuracion():
    BASE_DIR = os.path.abspath(os.path.dirname('__file__'))
    SECRET_KEY = os.environ.get('PRGMTC')
    SQLALCHEMY_TRACK_MODIFICATION = False
    
    @property
    def DATABASE_URI(self):
        return os.environ.get('BASE_DATOS_ROSETTA')

class Desarrollo(Configuracion):
    DEBUG = True
    SECRET_KEY = os.environ.get('PRGMTC') or ('PROGRAMATICA')

class Produccion(Configuracion):
    DEBUG = False

class Testeo(Configuracion):
    TESTING = True

tipoConfig = {
    'desarrollo' : Desarrollo,
    'testeo':Testeo,
    'produccion':Produccion,
    'porDefecto':Desarrollo
}