import os


from flask import Flask, render_template
from flask_sqlalchemy import SQLAlchemy
from config import tipoConfig

db = SQLAlchemy()


def crear_app(nombreConf):
    if os.environ.get('CONF_ROSSETA') == 'PRODUCCION':
        app = Flask(__name__, static_folder='estatico',\
            template_folder='plantillas')
        app.config.update(
            SECRET_KEY=os.environ.get('')
        )
    else:
        app = Flask(__name__, instance_relative_config=True,
        template_folder='plantillas', static_folder='estatico')
        app.config.from_object(tipoConfig[nombreConf])
    
    from app.dato import modelos


    @app.errorhandler(403)
    def restringido(error):
        return render_template('errores/403.html')
    
    @app.errorhandler(404)
    def no_encontrado(error):
        return render_template('errores/404.html')
    
    @app.errorhandler(500)
    def error_interno(error):
        return render_template('errores/500.html')

    @app.route('/')
    def homepage():
        return render_template('home/index.html', titulo="Bienvenido")

    db.init_app(app)
    with app.app_context():
        db.create_all()
    
    return app
