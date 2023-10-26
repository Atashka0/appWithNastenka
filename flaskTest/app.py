# Import necessary modules and classes from Flask
import os
import secrets
from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from werkzeug.security import generate_password_hash, check_password_hash

# Create a Flask application
app = Flask(__name__)

# Generate a secure random key or use the one stored in the environment variable
app.secret_key = os.environ.get('FLASK_SECRET_KEY', secrets.token_hex(16))

# Configure the SQLite database URI
app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///users.db"

# Initialize SQLAlchemy and associate it with the Flask app
db = SQLAlchemy()
db.init_app(app)

# Define a User model class for the database
class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    email = db.Column(db.String(60), unique=True, nullable=False)
    username = db.Column(db.String(20), unique=True, nullable=False)
    password = db.Column(db.String(60), nullable=False)

    # Constructor to initialize User objects
    def __init__(self, email, username, password):
        self.email = email
        self.username = username
        # Hash the password before storing it in the database
        self.password = generate_password_hash(password)

    # Method to check if the provided password matches the stored hashed password
    def check_password(self, password):
        return check_password_hash(self.password, password)

# Create database tables based on defined models
with app.app_context():
    db.create_all()

# Define a route for user registration
@app.route("/register", methods=["POST"])
def register():
    # Get JSON data from the request
    data = request.json

    # Check if the required fields are present in the JSON data
    if not data or "email" not in data or "password" not in data:
        return jsonify({"error": "Invalid data format"}), 400

    # Extract username and password from the JSON data
    email = data["email"]
    username = data["username"]
    password = data["password"]

    # Check if the username already exists in the database
    if User.query.filter_by(email=email).first():
        return jsonify({"error": "User already exists"}), 400

    # Create a new User object and add it to the database
    user = User(email=email, username=username, password=password)
    db.session.add(user)
    db.session.commit()

    # Return a JSON response indicating successful registration
    return jsonify({"message": "User registered successfully"}), 201

# Define a route for user login
@app.route("/login", methods=["POST"])
def login():
    # Get JSON data from the request
    data = request.json

    # Check if the required fields are present in the JSON data
    if not data or "email" not in data or "password" not in data:
        return jsonify({"error": "Invalid data format"}), 400

    # Extract username and password from the JSON data
    email = data["email"]
    password = data["password"]

    # Query the database to find a user with the provided username
    user = User.query.filter_by(email=email).first()

    # If the user doesn't exist, return an error response
    if not user:
        return jsonify({"error": "There's no such user"}), 401

    # Check if the provided password matches the stored hashed password
    if not user.check_password(password):
        return jsonify({"error": "Invalid password"}), 401

    # Return a JSON response indicating successful login
    return jsonify({"message": "Login successful"}), 200

# Run the Flask application
if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=8080)