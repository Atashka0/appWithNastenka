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

# class Event(db.Model):
#     __tablename__ = 'events'

#     id = db.Column(db.Integer, primary_key=True)
#     organizer_id = db.Column(db.Integer, db.ForeignKey('users.id'))
#     place = db.Column(db.String)
#     name = db.Column(db.String)
#     description = db.Column(db.String)
#     characteristics = db.relationship('Characteristic', backref='event')
#     guests = db.relationship('Guest', backref='event')

#     def to_dict(self):
#         return {
#             'id': self.id,
#             'organizer_id': self.organizer_id,
#             'place': self.place,
#             'name': self.name,
#             'description': self.description,
#             'characteristics': [characteristic.to_dict() for characteristic in self.characteristics],
#             'guests': [guest.to_dict() for guest in self.guests]
#         }

# class Guest(db.Model):
#     __tablename__ = 'guests'

#     id = db.Column(db.Integer, primary_key=True)
#     user_id = db.Column(db.Integer, db.ForeignKey('users.id'))
#     status = db.Column(db.String)
#     event_id = db.Column(db.Integer, db.ForeignKey('events.id'))

#     def to_dict(self):
#         return {
#             'id': self.id,
#             'user_id': self.user_id,
#             'status': self.status
#         }

# class Characteristic(db.Model):
#     __tablename__ = 'characteristics'

#     id = db.Column(db.Integer, primary_key=True)
#     name = db.Column(db.String)
#     description = db.Column(db.String)
#     event_id = db.Column(db.Integer, db.ForeignKey('events.id'))

#     def to_dict(self):
#         return {
#             'id': self.id,
#             'name': self.name,
#             'description': self.description
#         }
