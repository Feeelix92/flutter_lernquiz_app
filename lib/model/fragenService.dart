import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:flutter_lernquiz_app/model/neueFragen.dart';

class FragenService {
  static const _serviceUrl = 'http://mockbin.org/echo';
  static final _headers = {'Content-Type': 'application/json'};

  Future<Fragen> createContact(Fragen fragen) async {
    try {
      String json = _toJson(fragen);
      final response =
      await http.post(_serviceUrl, headers: _headers, body: json);
      var c = _fromJson(response.body);
      return c;
    } catch (e) {
      print('Server Exception!!!');
      print(e);
      return null;
    }
  }

  Fragen _fromJson(String json) {
    Map<String, dynamic> map = jsonDecode(json);
    var fragen = new Fragen();
    fragen.thema = map['thema'];
    fragen.frage = map['frage'];
    fragen.antwortA = map['antwortA'];
    fragen.antwortB = map['antwortB'];
    fragen.antwortC = map['antwortC'];
    fragen.antwortD = map['antwortD'];
    fragen.richtigeAntwort = map['richtigeAntwort'];
    return fragen;
  }

  String _toJson(Fragen fragen) {
    var mapData = new Map();
    mapData['thema'] = fragen.thema;
    mapData["frage"] = fragen.frage;
    mapData["antwortA"] = fragen.antwortA;
    mapData["antwortB"] = fragen.antwortB;
    mapData["antwortC"] = fragen.antwortC;
    mapData["antwortD"] = fragen.antwortD;
    mapData["richtigeAntwort"] = fragen.richtigeAntwort;
    String json = jsonEncode(mapData);
    return json;
  }
}