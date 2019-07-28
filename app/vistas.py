from flask import redirect, render_template, url_for, session, request
from .dato.modelos import Usuarios


@route('/')
def homepage():

    return render_template('home/index.html', titulo="Bienvenido")