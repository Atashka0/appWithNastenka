import os
import secrets
from flask import Flask, request, jsonify
from models import db, User, Event, EventType, Characteristic
from werkzeug.security import generate_password_hash, check_password_hash

app = Flask(__name__)

app.secret_key = os.environ.get('FLASK_SECRET_KEY', secrets.token_hex(16))

app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///users.db"

db.init_app(app)

with app.app_context():
    db.create_all()

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

    return jsonify(user.to_dict()), 201

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

    return jsonify(user.to_dict()), 200

@app.route("/users", methods=["GET"])
def get_users():
    users = User.query.all()
    users_list = [{ "id": user.id, "email": user.email, "username": user.username, "password": user.password } for user in users]
    return jsonify(users_list), 200
    
@app.route("/user/<int:id>", methods=["DELETE"])
def delete_user(id):
   user = User.query.get(id)
   if not user:
       return jsonify({"error": "User not found"}), 404

   db.session.delete(user)
   db.session.commit()

   return jsonify({"message": "User deleted successfully"}), 200

@app.route("/newEvent", methods=["POST"])
def create_event():
    data = request.get_json()

    if not data or "username" not in data or "place" not in data or "name" not in data or "description" not in data or "characteristics" not in data or "participants" not in data or "type" not in data:
        return jsonify({"error": "Invalid data format"}),  400

    # Create an Event instance
    event = Event(
        username=data['username'],
        name=data['name'],
        place=data['place'],
        description=data['description'],
        date=data['date'],
        type=data['type'],  # Store the string representation of the event type
        characteristics=data['characteristics'],
    )
    db.session.add(event)

    # Assuming 'participants' is a list of User objects
    # You would need to define a User model and a relationship similar to the one with Characteristic
    # For now, we will just add the event to the database

    db.session.commit()

    return jsonify({"message": "Event created successfully"}),  201


if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=8080)
