from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return "<h1>Hello, Flask!</h1><p>This is a basic Python app running in your browser.</p>"

if __name__ == "__main__":
    app.run(debug=True)

