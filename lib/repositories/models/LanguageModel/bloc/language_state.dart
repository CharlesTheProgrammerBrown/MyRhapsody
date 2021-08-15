part of 'language_bloc.dart';

abstract class LanguageState extends Equatable {
  const LanguageState();

  @override
  List<Object> get props => [];
}

class LanguageInitial extends LanguageState {}

class LoadedLanguages extends LanguageState {
  final List<LanguageModel> languages;
  final LanguageModel currentLanguage;
  LoadedLanguages(this.languages, this.currentLanguage);

  @override
  List<Object> get props => [];
}
