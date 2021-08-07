import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'distributionEntity.dart';

@immutable
class DistributionModel extends Equatable {
  final String id;
  final String email;
  final String name;
  final String language;
  

  const DistributionModel({
    this.id,
    this.email,
    this.name,
    this.language,
    
  });

  DistributionModel copyWith({
    String id,
    String email,
    String name,
    String language,
  }) {
    return DistributionModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      language: language ?? this.language,
    );
  }

  DistributionEntity distributionToEntity() {
    return DistributionEntity(
      id: id,
      email: email,
      name: name,
     language: language,
    );
  }

  static DistributionModel fromEntity(DistributionEntity entity) {
    return DistributionModel(
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
    return 'DistributionModel($id,$email,$name,$language)';
  }
}
