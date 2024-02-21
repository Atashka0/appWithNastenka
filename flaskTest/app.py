import os
import secrets
from flask import Flask, request, jsonify
from models import db, User, Event, Characteristic
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
        return jsonify({"error": f"user with email address {email} already exists"}), 400

    if User.query.filter_by(username=username).first():
        return jsonify({"error": f"username {username} is already taken."}), 400

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

    if not data or not all(key in data for key in ["username", "place", "name", "description", "characteristics", "participants", "type"]):
        return jsonify({"error": "Invalid data format"}),  400

    new_event = Event(
        username=data['username'],
        name=data['name'],
        place=data['place'],
        description=data['description'],
        type = data['type'],
        date=data.get('date', '')
    )

    for characteristic_data in data['characteristics']:
        new_characteristic = Characteristic(
            name=characteristic_data['name'],
            description=characteristic_data['description']
        )
        new_event.characteristics.append(new_characteristic)

    for participant_id in data['participants']:
        participant = User.query.get(participant_id)
        if participant:
            new_event.participants.append(participant)

    db.session.add(new_event)
    db.session.commit()

    return jsonify(new_event.to_dict()),  201

@app.route("/events", methods=["GET"])
def get_events():
    events = Event.query.all()
    events_list = [event.to_dict() for event in events]
    return jsonify(events_list),  200

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=8080)
