import os
import secrets
from flask import Flask, request, jsonify
from models import db, User
from werkzeug.security import generate_password_hash, check_password_hash

# Create a Flask application
app = Flask(__name__)

# Generate a secure random key or use the one stored in the environment variable
app.secret_key = os.environ.get('FLASK_SECRET_KEY', secrets.token_hex(16))

# Configure the SQLite database URI
app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///users.db"

# Initialize SQLAlchemy and associate it with the Flask app
db.init_app(app)

# Create database tables based on defined models
with app.app_context():
    db.create_all()

# Define a route for user registration
@app.route("/register", methods=["POST"])
def register():
    data = request.json

    if not data or "email" not in data or "password" not in data:
        return jsonify({"error": "Invalid data format"}), 400
    
    email = data["email"]
    username = data["username"]
    password = data["password"]

    if User.query.filter_by(email=email).first():
        return jsonify({"error": "User already exists"}), 400

    user = User(email=email, username=username, password=password)
    db.session.add(user)
    db.session.commit()

    return jsonify({"message": "User registered successfully"}), 201

# Define a route for user login
@app.route("/login", methods=["POST"])
def login():
    data = request.json

    if not data or "email" not in data or "password" not in data:
        return jsonify({"error": "Invalid data format"}), 400

    email = data["email"]
    password = data["password"]

    user = User.query.filter_by(email=email).first()

    if not user:
        return jsonify({"error": "There's no such user"}), 401

    if not user.check_password(password):
        return jsonify({"error": "Invalid password"}), 401

    return jsonify({"message": "Login successful"}), 200

# Run the Flask application
if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=8080)
