// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class RhapsodyEntity extends Equatable {
  final String id;
  final Timestamp createdOn;
  final String language;
  final String rhapsodyCover;
  final String url;

  const RhapsodyEntity({
    this.id,
    this.createdOn,
    this.language,
    this.rhapsodyCover,
    this.url,
  });

  // ignore: prefer_constructors_over_static_methods
  static RhapsodyEntity fromSnapshot(DocumentSnapshot snap) {
    return RhapsodyEntity(
      id: snap.id,
      createdOn: snap.get('createdOn') as Timestamp,
      language: snap.get('language').toString(),
      rhapsodyCover: snap.get('rhapsodyCover').toString(),
      url: snap.get('url').toString(),
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [
        id,
        language,
        createdOn,
        rhapsodyCover,
        url,
      ];

  @override
  String toString() {
    return 'RhapsodyEntity($id,$language,$createdOn,$rhapsodyCover,$url,)';
  }
}
