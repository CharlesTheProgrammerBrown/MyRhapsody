part of 'rhapsody_bloc.dart';

class RhapsodyState extends Equatable {
  final bool rhapsodiesLoadInProgress;
  final bool rhapsodiesLoadFailure;
  final bool rhapsodiesLoadSuccess;
  final List<RhapsodyModel> rhapsodies;
  final String language;

  const RhapsodyState(
      {this.rhapsodiesLoadInProgress,
      this.rhapsodiesLoadFailure,
      this.rhapsodiesLoadSuccess,
      this.rhapsodies,
      this.language});

  factory RhapsodyState.initial() {
    return const RhapsodyState(
      rhapsodiesLoadInProgress: true,
      rhapsodiesLoadFailure: false,
      rhapsodiesLoadSuccess: false,
      rhapsodies: [],
    );
  }

  factory RhapsodyState.rhapsodiesLoadFailure() {
    return const RhapsodyState(
      rhapsodiesLoadInProgress: false,
      rhapsodiesLoadFailure: true,
      rhapsodiesLoadSuccess: false,
      rhapsodies: [],
    );
  }

  factory RhapsodyState.rhapsodiesLoadSuccess({
    List<RhapsodyModel> rhapsodies,
    String language,
    String categoryName,
    String categoryDescription,
  }) {
    return RhapsodyState(
      rhapsodiesLoadInProgress: false,
      rhapsodiesLoadFailure: false,
      rhapsodiesLoadSuccess: true,
      rhapsodies: rhapsodies,
      language: language,
    );
  }

  RhapsodyState copyWith({
    final bool rhapsodiesLoadInProgress,
    final bool rhapsodiesLoadFailure,
    final bool rhapsodiesLoadSuccess,
    final List<RhapsodyModel> rhapsodies,
    final String language,
  }) {
    return RhapsodyState(
      rhapsodiesLoadFailure:
          rhapsodiesLoadFailure ?? this.rhapsodiesLoadFailure,
      rhapsodiesLoadInProgress:
          rhapsodiesLoadInProgress ?? this.rhapsodiesLoadInProgress,
      rhapsodiesLoadSuccess:
          rhapsodiesLoadSuccess ?? this.rhapsodiesLoadSuccess,
      language: language ?? this.language,
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [
        rhapsodiesLoadInProgress,
        rhapsodiesLoadFailure,
        rhapsodiesLoadSuccess,
        rhapsodies,
        language,
      ];

  @override
  String toString() {
    return '{LoadInProgress: $rhapsodiesLoadInProgress, LoadFailure: $rhapsodiesLoadFailure, LoadSuccess: $rhapsodiesLoadSuccess, rhapsodies: $rhapsodies, language: $language, }';
  }
}
