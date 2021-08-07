// ignore: file_names

import 'package:equatable/equatable.dart';

import 'rhapsodyEntity.dart';

class RhapsodyModel extends Equatable {
  final String id;
  final DateTime createdOn;
  final String language;
  final String rhapsodyCover;
  final String url;

  const RhapsodyModel({
    this.id,
    this.createdOn,
    this.language,
    this.rhapsodyCover,
    this.url,
  });

  RhapsodyModel copyWith({
    final String id,
    final DateTime createdOn,
    final String language,
    final String rhapsodyCover,
    final String url,
  }) {
    return RhapsodyModel(
      id: id ?? this.id,
      createdOn: createdOn ?? this.createdOn,
      language: language ?? this.language,
      rhapsodyCover:
          rhapsodyCover ?? this.rhapsodyCover,
      url: url ?? this.url,
    );
  }

  // ignore: prefer_constructors_over_static_methods
  static RhapsodyModel fromEntity(
      RhapsodyEntity entity) {
    return RhapsodyModel(
      id: entity.id,
      createdOn: entity.createdOn.toDate(),
      language: entity.language,
      rhapsodyCover: entity.rhapsodyCover,
      url: entity.url,
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [
        id,
        createdOn,
        language,
        rhapsodyCover,
        url,
      ];

  @override
  String toString() {
    return 'RhapsodyModel($id,$createdOn,$language,$rhapsodyCover,$url)';
  }
}
