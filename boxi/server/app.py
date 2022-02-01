from flask import Flask

app = Flask(__name__)

@app.route('/')
def index():
	return 'Hello World\n'

@app.route('/barcode')
def barcode():
    return True

@app.route('/lock')
def lock():
    return True

@app.route('/weight')
def weight():
    return True

@app.route('/vibration')
def vibration():
    return True

if __name__ == '__main__':
	app.run(host='0.0.0.0', port='4321')
