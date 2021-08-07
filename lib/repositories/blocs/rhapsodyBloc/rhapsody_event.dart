part of 'rhapsody_bloc.dart';

abstract class RhapsodyEvent extends Equatable {
  const RhapsodyEvent();

  @override
  List<Object> get props => [];
}

class InitiateRhapsodyByLanguage extends RhapsodyEvent {
  final String language;

  const InitiateRhapsodyByLanguage({this.language});

  @override
  List<Object> get props => [
        language,
      ];

  @override
  String toString() {
    return 'InitiateRhapsodyInLanguage - $language';
  }
}

class LoadRhapsodiesByLanguage extends RhapsodyEvent {
  final String language;

  final List<RhapsodyModel> rhapsodiesByLanguage;

  const LoadRhapsodiesByLanguage({
    this.language,
    this.rhapsodiesByLanguage,
  });

  @override
  List<Object> get props => [language, rhapsodiesByLanguage];

  @override
  String toString() {
    return 'LoadRhapsodiesByLanguage{lang : $language}';
  }
}
