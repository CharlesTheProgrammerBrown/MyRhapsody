import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'userDataEntity.dart';

@immutable
class UserDataModel extends Equatable {
  final String id;
  final String email;
  final String name;
  final String language;

  const UserDataModel({
    this.id,
    this.email,
    this.name,
    this.language,
    
  });

  UserDataModel copyWith({
    String id,
    String email,
    String name,
    String language,
  }) {
    return UserDataModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      language: language ?? this.language,
    );
  }

  UserDataEntity userDataToEntity() {
    return UserDataEntity(
      id: id,
      email: email,
      name: name,
     language: language,
    );
  }

  static UserDataModel fromEntity(UserDataEntity entity) {
    return UserDataModel(
      id: entity.id,
      email: entity.email,
      name: entity.name,
     language: entity.language,
      
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [id, email, name, language,];

  @override
  String toString() {
    return 'UserDataModel($id,$email,$name,$language)';
  }
}
