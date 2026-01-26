from flask import Flask
app = Flask(__name__)


@app.route('/')
def hello_world():
    return 'Hello, World!'

# FLASK_APP=minimal.py FLASK_ENV=development flask run
