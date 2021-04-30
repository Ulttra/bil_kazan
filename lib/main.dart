import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hafta6/hakkinda.dart';
import 'package:hafta6/soru1.dart';
import 'package:hafta6/hakkinda.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bil Kazan',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Bil Kazan'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String adSoyad = '';
  String giriskodu = '';

  void kontrol() {
    if ((adSoyad.length > 9) && (giriskodu.length == 9)) {
      var data = [];
      data.add(adSoyad);
      data.add(giriskodu);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => soru1(),
              settings: RouteSettings(
                arguments: data,
              )));
    }
  }

  @override
  Widget build(BuildContext context) {
    bool butonpasif = true;
    if ((adSoyad.length > 9) && (giriskodu.length == 9)) {
      butonpasif = false;
    } else {
      butonpasif = true;
    }

    void _adSoyadKaydet(String text) {
      setState(() {
        adSoyad = text;
      });
    }

    void _ogrNoKaydet(String text) {
      setState(() {
        giriskodu = text;
      });
    }

    final ButtonStyle basla = ElevatedButton.styleFrom(primary: Colors.indigo);
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Bil Kazan', style:GoogleFonts.playfairDisplaySc()),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Giriş Ekranı', style: TextStyle(fontSize: 25.0)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(left: 20.0, top: 20.0),
                        child:
                            Text('Adınız:', style: TextStyle(fontSize: 18.0)),
                      )),
                  Expanded(
                      flex: 2,
                      child: Container(
                          margin: EdgeInsets.only(left: 20.0, top: 20.0),
                          child: TextField(
                            decoration: const InputDecoration(
                                hintText: 'Adınızı Giriniz',
                                border: OutlineInputBorder()),
                            keyboardType: TextInputType.text,
                            inputFormatters: [
                              FilteringTextInputFormatter.singleLineFormatter,
                            ],
                            onChanged: (text) {
                              _adSoyadKaydet(text);
                            },
                          ))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(left: 20.0, top: 20.0),
                        child: Text('Giriş Kodu:',
                            style: TextStyle(fontSize: 18.0)),
                      )),
                  Expanded(
                      flex: 2,
                      child: Container(
                          margin: EdgeInsets.only(left: 20.0, top: 20.0),
                          child: TextField(
                            decoration: const InputDecoration(
                                hintText: 'Giriş Kodunu Giriniz',
                                border: OutlineInputBorder()),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.singleLineFormatter,
                              LengthLimitingTextInputFormatter(9),
                              WhitelistingTextInputFormatter.digitsOnly,
                            ],
                            onChanged: (text) {
                              _ogrNoKaydet(text);
                            },
                          ))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                        margin: EdgeInsets.only(left: 20.0, top: 20.0),
                        child: SizedBox(
                          height: 35.0,
                          child: ElevatedButton(
                            style: basla,
                            onPressed: butonpasif ? null : kontrol,
                            child: Text(
                              'Yarışmaya Başla',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15.0),
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                        margin: EdgeInsets.only(left: 20.0, top: 20.0),
                        child: SizedBox(
                          height: 35.0,


                          child: TextButton(
                            style: TextButton.styleFrom(primary: Colors.lightBlueAccent),
                            onPressed:()
                            {   Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Hakkinda(),

                                    ));  },
                            child: Text(
                              'Hakkında..',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15.0),
                            ),

                          ),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
