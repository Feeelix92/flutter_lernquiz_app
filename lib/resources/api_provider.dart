import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:hs_fulda/models/category.dart';
import 'package:hs_fulda/models/question.dart';


Future<List<Question>> getQuestions(context, Category category) async {
  String jsonPath = await DefaultAssetBundle.of(context).loadString("assets/json/questions.json");
  List<Map<String, dynamic>> questions = List<Map<String,dynamic>>.from(json.decode(jsonPath)[category.name]);

  return Question.fromData(questions);
}