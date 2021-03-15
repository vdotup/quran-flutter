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
      debugShowCheckedModeBanner: true,
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
      ),
    );
  }
}

class SurahView extends StatelessWidget {
  Surah surah;
  SurahView(this.surah);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Expanded(child: ListView.builder(itemBuilder: (context, index) {
        return Text(
          surah.verses[index].verse,
          maxLines: 400,
          style: TextStyle(
              color: Colors.green, fontFamily: "UthamnicHafs", fontSize: 20),
        );
      })),
    );
  }
}
