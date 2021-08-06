import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class UserDataEntity extends Equatable {
  final String id;
  final String email;
  final String name;
  final String language;

  const UserDataEntity({
    @required this.id,
    @required this.email,
    @required this.name,
    @required this.language,
  });

  static UserDataEntity fromSnapshot(DocumentSnapshot snap) {
    return UserDataEntity(
      id: snap.id,
      email: snap.get('email').toString(),
      name: snap.get('name').toString(),
      language: snap.get('language').toString(),
    );
  }

  Map<String, Object> toDocument() {
    return {
      'email': email,
      'name': name,
      'language': language,
    };
  }

  // Map<String, Object> toDocumentPhotoUrlUpdate() {
  //   return {'photoUrl': photoUrl, 'updatedOn': Timestamp.now()};
  // }

  @override
  // TODO: implement props
  List<Object> get props => [
        id,
        email,
        name,
        language,
      ];

  @override
  String toString() {
    return 'UserDataEntity($id,$email,$name,$language)';
  }
}
