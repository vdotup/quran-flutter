import 'package:flutter/foundation.dart';

class Surah extends ChangeNotifier {
  final int id;
  final LocalizedName name;
  final List<Verse> verses;

  Surah({this.id, this.name, this.verses});

  factory Surah.fromJSON(Map map) {
    var name = LocalizedName.fromJSON(map['name']);
    var versesList = map['verses'] as List;
    List<Verse> verses = versesList.map((i) => Verse.fromJSON(i)).toList();

    return Surah(id: map['id'], name: name, verses: verses);
  }
}

class LocalizedName {
  final String ar;

  LocalizedName({this.ar});

  factory LocalizedName.fromJSON(Map map) {
    return LocalizedName(ar: map['ar']);
  }
}

class Verse {
  final int id;
  final LocalizedName verse;

  Verse({this.id, this.verse});

  factory Verse.fromJSON(Map map) {
    var verse = LocalizedName.fromJSON(map['verse']);
    return Verse(id: map['id'], verse: verse);
  }
}
