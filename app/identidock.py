from flask import Flask, Response, request
import requests
import hashlib
import redis


app = Flask(__name__)
cache = redis.StrictRedis( host='redis', port=6379, db=0 )
salt = "UNIQUE_SALT"

@app.route('/', methods=['GET', 'POST'])
def main_page():
	html = open('index.html', 'r')
	name = 'demo'
	if request.method == 'POST':
		name = request.form['name']

	salted_name = salt + name
	name_hash = hashlib.sha256( salted_name.encode() ).hexdigest()

	return html.read().format(name, name_hash)


@app.route('/monster/<name>')
def gen_identicon(name):
	image = cache.get( name )
	if image is None:
		print( "Cache miss (промах кэша)", flush=True )
		r = requests.get('http://dnmonster:8080/monster/' + name + '?size=80')
		image = r.content
		cache.set( name, image )
	return Response(image, mimetype='image/png')


@app.route('/hello')
def hello_world():
	return 'Hello World! \n'

if __name__ == '__main__':
	app.run(debug=True, host='0.0.0.0')