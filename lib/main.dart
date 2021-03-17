import 'package:quran/models/data.dart';
import 'package:quran/models/surah.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:quran/tools.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  loadData().then((_) {
    print(surahList().length);
    runApp(App());
  });
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black,
        statusBarColor: Colors.black,
        statusBarBrightness: Brightness.light));

    return MaterialApp(
      routes: {
        '/': (BuildContext context) => Home(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentSurah = 0;
  double fontSize = 20;

  void prev() {
    if (currentSurah <= 0) {
      setState(() {
        currentSurah = surahList().length - 1;
      });
    } else {
      setState(() {
        currentSurah -= 1;
      });
    }
  }

  void next() {
    if (currentSurah == surahList().length - 1) {
      setState(() {
        currentSurah = 0;
      });
    } else {
      setState(() {
        currentSurah += 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text((surahList()[currentSurah].id + 1).toString(),
                      style: TextStyle(
                          color: Colors.green, fontFamily: "UthamnicHafs")),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    surahList()[currentSurah].name.ar,
                    style: TextStyle(
                        color: Colors.green,
                        fontFamily: "UthamnicHafs",
                        fontSize: 20),
                  ),
                ],
              ),
            ),
            Expanded(child: surahView(surahList()[currentSurah])),
            Row(
              children: [
                CupertinoButton(
                    child: Icon(
                      CupertinoIcons.arrowtriangle_left_circle,
                      size: 50,
                    ),
                    onPressed: prev),
                Spacer(),
                CupertinoButton(
                    child: Icon(
                      CupertinoIcons.minus_circle_fill,
                      size: 50,
                    ),
                    onPressed: () {
                      setState(() {
                        if (fontSize > 10) {
                          fontSize -= 1;
                        }
                      });
                    }),
                Text(
                  fontSize.toString(),
                  style: TextStyle(color: Colors.white),
                ),
                CupertinoButton(
                    child: Icon(
                      CupertinoIcons.plus_circle_fill,
                      size: 50,
                    ),
                    onPressed: () {
                      setState(() {
                        if (fontSize < 80) {
                          fontSize += 1;
                        }
                      });
                    }),
                Spacer(),
                CupertinoButton(
                    child: Icon(
                      CupertinoIcons.arrowtriangle_right_circle,
                      size: 50,
                    ),
                    onPressed: next)
              ],
            )
          ],
        ),
      ),
    );
  }

  ListView surahView(Surah surah) {
    Column ayah(int index) {
      if (index == 0 && surah.id != 0 && surah.id != 8) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ",
              maxLines: 400,
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "UthamnicHafs",
                  fontSize: fontSize),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              surah.verses[index].verse.ar + " " + Tools().numberConvert(index),
              maxLines: 400,
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "UthamnicHafs",
                  fontSize: fontSize),
            ),
          ],
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              surah.verses[index].verse.ar + " " + Tools().numberConvert(index),
              maxLines: 400,
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "UthamnicHafs",
                  fontSize: fontSize),
            ),
          ],
        );
      }
    }

    return ListView.builder(
        itemCount: surah.verses.length,
        itemBuilder: (context, index) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 30, right: 10, bottom: 10),
              child: ayah(index),
            ),
          );
        });
  }
}
