from flask_sqlalchemy import SQLAlchemy
from werkzeug.security import generate_password_hash, check_password_hash

db = SQLAlchemy()

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    email = db.Column(db.String(60), unique=True, nullable=False)
    username = db.Column(db.String(20), unique=True, nullable=False)
    password = db.Column(db.String(60), nullable=False)

    def __init__(self, email, username, password):
        self.email = email
        self.username = username
        self.password = generate_password_hash(password)

    def check_password(self, password):
        return check_password_hash(self.password, password)
        
    def to_dict(self):
        return {
            "id": self.id,
            "email": self.email,
            "username": self.username
        }

class Event(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), nullable=False)
    name = db.Column(db.String(80), nullable=False)
    place = db.Column(db.String(120), nullable=False)
    description = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(80), nullable=False)
    type = db.Column(db.String(80), nullable=False)  # EventType as a string
    characteristics = db.Column(JSON, nullable=False)  # Characteristics as JSON
    participants = db.relationship('User', backref='event', lazy=True)

    def to_dict(self):
        return {
            "id": self.id,
            "username": self.username,
            "name": self.name,
            "place": self.place,
            "description": self.description,
            "date": self.date,
            "type": self.type,
            "characteristics": self.characteristics,
            "participants": [user.to_dict() for user in self.participants]
        }
