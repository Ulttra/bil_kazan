import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hafta6/hakkinda.dart';

import 'package:hafta6/soru9.dart';
import 'package:hafta6/menuYapimi.dart';

import 'package:hafta6/soru1.dart';
import 'package:hafta6/hakkinda.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'package:hafta6/views/list_uyes.dart';
import 'package:sqflite/sqflite.dart';
import 'package:hafta6/models/Uye.dart';
import 'package:hafta6/services/db_utils.dart';
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
  Color baseColor = Colors.lightBlueAccent;
  double yazibuyukluk = 19.0;
  String adSoyad = '';
  String giriskodu = '';
  var _filePath;
  List<Uye> uyeList = [];
  Future<String> get _localDevicePath async {
    final _devicePath = await getApplicationDocumentsDirectory();
    return _devicePath.path;
  }

  Future<File> _localFile({String path, String type}) async {
    String _path = await _localDevicePath;
    var _newPath = await Directory("$_path/$path").create();
    return File("${_newPath.path}/kural.$type");
  }

  Future _downloadSamplePDF() async {
    final _response = await http.get(Uri.parse(
        "https://uzemegitim.selcuk.edu.tr/kilavuzlar/ogrencigiris.pdf"));
    if (_response.statusCode == 200) {
      final _file = await _localFile(path: "pdfs", type: "pdf");
      final _saveFile = await _file.writeAsBytes(_response.bodyBytes);
      print("Dosya yazma işlemi tamamlandı. Dosyanın yolu: ${_saveFile.path}");
      setState(() {
        _filePath = _saveFile.path;
      });
    } else {
      print(_response.statusCode);
    }
  }
  void getData() async {
    await utils.uyes().then((result) => {
      setState(() {
        uyeList = result;
      })
    });
    for(var i=0;i<uyeList.length;i++)
    {

      if(adSoyad==uyeList[i].isim && giriskodu== uyeList[i].kod)
        {
          kontrol(); break;
        }
      else
        {
          _showDialog(context); break;

        }

    }
  }
  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Hata!!"),
          content: new Text("Kullanıcı Adı veya Şifre Yanlış!"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Tamam"),
              onPressed: () {
                Navigator.of(context).pushNamed('/');
              },
            ),
          ],
        );
      },
    );
  }
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

  void kontrol2() {
    var data = [];
    data.add(adSoyad);
    data.add(giriskodu);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>soru9(),
            settings: RouteSettings(
              arguments: data,
            )));
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
     drawer: MenuYapimi(),
      appBar: new AppBar(
        title: new Text('Bil Kazan', style: GoogleFonts.playfairDisplaySc()),
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
                            onPressed: butonpasif ? null : getData,
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
              padding: const EdgeInsets.all(3.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                        margin: EdgeInsets.only(left: 1.0, top: 1.0),
                        child: SizedBox(
                          height: 35.0,
                          child: TextButton.icon(
                            icon: Icon(Icons.file_download),
                            label: Text("Yarışma Kuralları"),
                            onPressed: () async {
                              final _openFile = await OpenFile.open(_filePath);
                              print(_openFile);
                              _downloadSamplePDF();
                            },
                          ),
                        )),
                  ),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: new GestureDetector(
                  child: Text(
                    'Hakkında..',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: yazibuyukluk,
                        color: baseColor),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Hakkinda(),
                        ));
                  },
                  onTapDown: (e) {
                    setState(() {
                      baseColor = Colors.red;
                      yazibuyukluk = 19;
                    });
                  },
                  onLongPress: () {
                    setState(() {
                      baseColor = Colors.black;
                    });
                  },
                  onLongPressUp: () {
                    setState(() {
                      baseColor = Colors.lightBlueAccent;
                      yazibuyukluk = 17;
                    });
                  },
                ),
              ),
            ),

         /*   Padding(
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
                            onPressed: kontrol2,
                            child: Text(
                              'İkinci aşama',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15.0),
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ), */
          ],
        ),
      ),
    );
  }
}
