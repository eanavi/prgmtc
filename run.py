from app import crear_app
nombreConfig = 'porDefecto'
app = crear_app(nombreConfig)

if __name__ == '__main__':
	app.run(host='0.0.0.0')