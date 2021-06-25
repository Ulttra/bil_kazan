import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hafta6/main.dart';
import 'package:hafta6/yonetimPaneli.dart';
import 'package:open_file/open_file.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'package:hafta6/dosyaokuyaz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hafta6/hakkinda.dart';
import 'package:hafta6/hata.dart';
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

class YonetimPaneliGiris extends StatefulWidget {
  @override
  _YonetimPaneliGirisState createState() => _YonetimPaneliGirisState();
}

class _YonetimPaneliGirisState extends State<YonetimPaneliGiris> {
  Color baseColor = Colors.lightBlueAccent;
  double yazibuyukluk = 19.0;
  String adSoyad = '';
  String sifre = '';
  var _filePath;




  void kontrol() {
    if ((adSoyad.length > 4) && (sifre.length >4)) {
      var data = [];
      data.add(adSoyad);
      data.add(sifre);
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
    var data = [];
    data = ModalRoute.of(context).settings.arguments;

    if ((adSoyad.length > 4) && (sifre.length >4)) {
      butonpasif = false;
    } else {
      butonpasif = true;
    }

    void _adSoyadKaydet(String text) {
      setState(() {
        adSoyad = text;
      });
    }

    void _sifrekaydet(String text) {
      setState(() {
       sifre = text;
      });
    }
    void yonetimpanel() {
      if (adSoyad == 'admin' && sifre == '12345') {
        var data = [];
        data.add(adSoyad);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => YonetimPaneli(),
                settings: RouteSettings(
                  arguments: data,
                )));
      }
      else{
        _showDialog(context);

      }
    }


    final ButtonStyle basla = ElevatedButton.styleFrom(primary: Colors.indigo);
    return Scaffold(
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
                  Text('Yönetim Paneli Giriş', style: TextStyle(fontSize: 25.0)),
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
                        Text('Kullanıcı Adı:', style: TextStyle(fontSize: 15.0)),
                      )),
                  Expanded(
                      flex: 2,
                      child: Container(
                          margin: EdgeInsets.only(left: 20.0, top: 20.0),
                          child: TextField(
                            decoration: const InputDecoration(
                                hintText: 'Kullanıcı Adınız',
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
                        child: Text('Şifre: ',
                            style: TextStyle(fontSize: 15.0)),
                      )),
                  Expanded(
                      flex: 2,
                      child: Container(
                          margin: EdgeInsets.only(left: 20.0, top: 20.0),
                          child: TextField(
                            decoration: const InputDecoration(
                                hintText: 'Şifrenizi Giriniz',
                                border: OutlineInputBorder()),
                            obscureText: true,

                            onChanged: (text) {
                              _sifrekaydet(text);
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
                          height: 45.0,
                          child: ElevatedButton(
                            style: basla,
                            onPressed: butonpasif ? null : yonetimpanel ,
                            child: Text(
                              'Giriş',
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
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
