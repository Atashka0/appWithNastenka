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
    
@app.route("/deleteUser/<int:id>", methods=["DELETE"])
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
        # 0 for privatized, 1 for open
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

@app.route("/deleteEvent", methods=["DELETE"])
def delete_event():
    data = request.get_json()

    if not data or not all(key in data for key in ["id", "username"]):
        return jsonify({"error": "Invalid data format"}),   400

    event_id = data["event_id"]
    user_id = data["user_id"]
    event = Event.query.get(event_id)
    user = User.query.get(user_id)

    if not event:
        return jsonify({"error": "Event not found"}),   404

    if event.username == user.username:
        db.session.delete(event)
        db.session.commit()
        return jsonify({"message": "Event deleted successfully"}),   200
    else:
        for participant in event.participants:
            if participant.username == user.username:
                event.participants.remove(participant)
                db.session.commit()
                return jsonify({"message": "User removed from event successfully"}),   200

    return jsonify({"error": "User not found in event participants"}),   404


@app.route("/editEvent/<int:event_id>", methods=["PUT", "PATCH"])
def edit_event(event_id):
    event = Event.query.get(event_id)

    if not event:
        return jsonify({"error": "Event not found"}),  404

    data = request.get_json()

    if not data:
        return jsonify({"error": "Invalid data format"}),  400

    if 'username' in data:
        event.username = data['username']
    if 'name' in data:
        event.name = data['name']
    if 'place' in data:
        event.place = data['place']
    if 'description' in data:
        event.description = data['description']
    if 'date' in data:
        event.date = data['date']
    if 'type' in data:
        event.type = data['type']

    if 'characteristics' in data:
        for characteristic_data in data['characteristics']:
            characteristic_id = characteristic_data.get('id')
            characteristic = Characteristic.query.get(characteristic_id)
            if characteristic:
                characteristic.name = characteristic_data['name']
                characteristic.description = characteristic_data['description']
            else:
                new_characteristic = Characteristic(
                    name=characteristic_data['name'],
                    description=characteristic_data['description'],
                    event=event
                )
                event.characteristics.append(new_characteristic)

    if 'participants' in data:
        event.participants = []
        for participant_id in data['participants']:
            participant = User.query.get(participant_id)
            if participant:
                event.participants.append(participant)

    db.session.commit()

    return jsonify({"message": "Event updated successfully"}),  200

@app.route("/user/<int:user_id>/events", methods=["GET"])
def get_user_events(user_id):
    user = User.query.get(user_id)
    if not user:
        return jsonify({"error": "User not found"}),  404

    events = user.events
    events_list = [event.to_dict() for event in events]
    return jsonify(events_list),  200

@app.route("/getFeedEvents", methods=["GET"])
def get_events():
    events = Event.query.all()
    events_list = [event.to_dict() for event in events]
    return jsonify(events_list),  200

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=8080)
