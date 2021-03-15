import 'package:flutter/foundation.dart';

class Surah extends ChangeNotifier {
  final int id;
  final List<Verse> verses;

  Surah({this.id, this.verses});

  factory Surah.fromJSON(Map map) {
    var list = map['verses'] as List;
    List<Verse> verses = list.map((i) => Verse.fromJSON(i)).toList();

    return Surah(id: map['id'], verses: verses);
  }
}

class Verse {
  final int id;
  final String verse;

  Verse({this.id, this.verse});

  factory Verse.fromJSON(Map map) {
    return Verse(id: map['id'], verse: map['verse']);
  }
}
