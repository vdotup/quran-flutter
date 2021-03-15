import 'dart:convert';

import 'package:quran/models/surah.dart';
import 'package:flutter/services.dart';

List<Surah> _surahList;

List<Surah> surahList() => _surahList;

Future<T> _load<T>(String filename, T Function(dynamic) builder) async {
  final fileString = await rootBundle.loadString('assets/$filename');
  return builder(json.decode(fileString));
}

Future<Null> loadData() async {
  final String surahListFilename = "json/result.json";

  _surahList = await _load(
      surahListFilename,
      (data) =>
          List.unmodifiable((data).map((element) => Surah.fromJSON(element))));
}
