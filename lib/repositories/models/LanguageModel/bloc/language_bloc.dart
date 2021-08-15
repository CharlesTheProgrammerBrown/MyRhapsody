import 'dart:async';
import 'dart:convert';

import 'package:MyRhapsody/repositories/models/LanguageModel/language_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

part 'language_event.dart';

part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageInitial());

  @override
  Stream<LanguageState> mapEventToState(
    LanguageEvent event,
  ) async* {
    if (event is LoadLanguages) {
        dynamic data = await rootBundle
        .loadString('assets/json/myRhapsody_supported_languages.json');

      /*dynamic data= {
        "data": [
          {"language_code": "En", "language_title": "English"},
          {"language_code": "Fr", "language_title": "French"}
        ]
      };*/

      print('our json is $data');
      List<dynamic> jdata = json.decode(data)["data"];
      List<LanguageModel> languagesList =jdata
          .map((e) => LanguageModel(
          languageTitle: e["language_title"],
          languageCode: e["language_code"]))
          .toList();
      print('returned data is $languagesList');

      yield LoadedLanguages(languagesList, languagesList[2]);
    }
  }
}
