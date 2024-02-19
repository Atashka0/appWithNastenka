from flask_sqlalchemy import SQLAlchemy
from werkzeug.security import generate_password_hash, check_password_hash

db = SQLAlchemy()

class EventParticipant(db.Model):
    __tablename__ = 'event_participants' 
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), primary_key=True)
    event_id = db.Column(db.Integer, db.ForeignKey('event.id'), primary_key=True)
    
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

class Characteristic(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    description = db.Column(db.String(255), nullable=False)
    event_id = db.Column(db.Integer, db.ForeignKey('event.id')) 

    def to_dict(self):
        return {
            "id": self.id,
            "name": self.name,
            "description": self.description
        }

class Event(db.Model):
    __tablename__ = 'event'  
    
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(20), nullable=False)
    name = db.Column(db.String(100), nullable=False)
    place = db.Column(db.String(100), nullable=False)
    description = db.Column(db.String(255), nullable=False)
    date = db.Column(db.String(50), nullable=False)
    type = db.Column(db.String(1), nullable=False)
    characteristics = db.relationship('Characteristic', backref='event', lazy=True)
    participants = db.relationship('User', secondary='event_participants', backref='events')

    def to_dict(self):
        return {
            "id": self.id,
            "username": self.username,
            "name": self.name,
            "place": self.place,
            "description": self.description,
            "date": self.date,
            "type": self.type,
            "characteristics": [characteristic.to_dict() for characteristic in self.characteristics],
            "participants": [participant.to_dict() for participant in self.participants]
        }
