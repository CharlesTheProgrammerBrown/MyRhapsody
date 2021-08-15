import 'dart:convert';

import 'package:flutter/services.dart';

class LanguageModel {
  final String languageTitle;

  final String languageCode;

  LanguageModel({this.languageTitle, this.languageCode});

  /* static fromJson(List<dynamic> data) {
    return data.map((dataToDecode) {
      var cleaned = json.decode(dataToDecode);
      return LanguageModel(
        languageCode: cleaned["language_code"],
        languageTitle: cleaned["language_title"],
      );
    }).toList();
  }*/


/*  static Future<List<LanguageModel>> supportedLanguages() async {
  *//*  dynamic data = await rootBundle
        .loadString('assets/json/myRhapsody_supported_languages.json');*//*

  dynamic data =  {"data":[
    {
      "language_code":"En",
      "language_title":"English"
    },
    {
      "language_code":"Fr",
      "language_title":"French"
    }
  ]};
   // dynamic returnData = LanguageModel.fromJson(data);
    print('returned data is $returnData');

    return Future<List<LanguageModel>>(()=>returnData) ;
  }*/

  @override
  String toString() {
    return 'LanguageModel{languageTitle: $languageTitle, languageCode: $languageCode}';
  }
}
