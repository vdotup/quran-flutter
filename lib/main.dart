import 'package:quran/models/data.dart';
import 'package:quran/models/surah.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

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
            Expanded(child: SurahView(surahList()[currentSurah])),
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
}

class SurahView extends StatelessWidget {
  final Surah surah;
  SurahView(this.surah);

  String arabicN(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ["٠", "١", "٢", "٣", "٤", "٥", "٦", "٧", "٨", "٩"];
    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(english[i], arabic[i]);
    }
    return input;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: surah.verses.length,
        itemBuilder: (context, index) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 30, right: 10, bottom: 10),
              child: Text(
                surah.verses[index].verse.ar +
                    " " +
                    arabicN((index + 1).toString()),
                maxLines: 400,
                textAlign: TextAlign.right,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "UthamnicHafs",
                    fontSize: 40),
              ),
            ),
          );
        });
  }
}
