import 'dart:async';
import 'dart:core';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:hafta6/bitir.dart';
import 'package:hafta6/cekil.dart';
import 'package:hafta6/soru3.dart';
import 'package:google_fonts/google_fonts.dart';

class soru2 extends StatefulWidget {
  @override
  _soru2State createState() => _soru2State();
}

String zamaniFormatla(int milisaniye) {
  var saniye = milisaniye ~/ 1000;
  var dakika = ((saniye % 3600) ~/ 60).toString().padLeft(2, '0');
  var saniyeler = (saniye % 60).toString().padLeft(2, '0');
  return "$dakika:$saniyeler";
}

class _soru2State extends State<soru2> {
  String adSoyad = '';
  String hakedis = '0 ₺';
  String odul = '0 ₺';
  var sorular = [
    {
      'soru': 'Gönülden ırak olan kimdir?',
      'cevaplar': ['Evi uzak olan ', 'İş yeri uzak olan', 'Evden kaçan', 'Gözden ırak olan'],
      'dogrucevap': 'Gözden ırak olan'
    }
  ];

  Stopwatch _sayac;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _sayac = Stopwatch();
    _timer = new Timer.periodic(new Duration(seconds: 1), (timer) {
      setState(() {});
    });

    mevcutsoru = 0;
    mevcutcevap = '';

  }

  int mevcutsoru = 0;
  String mevcutcevap = '';
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  void BitireYolla() {
    var data = [];
    data.add(adSoyad);
    data.add(odul);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Bitir(),
          settings: RouteSettings(
            arguments: data,
          ),
        ));
  }
  void CekileYolla() {
    var data = [];
    data.add(adSoyad);
    data.add(hakedis);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Cekil(),
          settings: RouteSettings(
            arguments: data,
          ),
        ));
  }
  void sonrakiekran() {
    var data = [];
    data.add(adSoyad);
    data.add(hakedis);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => soru3(),
          settings: RouteSettings(
            arguments: data,
          ),
        ));
  }
  void kontrolEt() {
    if (mevcutsoru > 0) {
      mevcutsoru = 0;
      _timer.cancel();
      BitireYolla();
    } else {
      if (mevcutcevap == sorular[mevcutsoru]['dogrucevap']) {
        hakedis = '1000 ₺';
        odul='1000 ₺';
        _sayac.reset();
        sonrakiekran();
      } else {
        _timer.cancel();
        BitireYolla();
      }
    }
  }
  void kontrolEt_cekil() {

        _timer.cancel();
        CekileYolla();
      }



  @override
  Widget build(BuildContext context) {
    var data = [];
    data = ModalRoute
        .of(context)
        .settings
        .arguments;
    adSoyad = data[0];
    hakedis = data[1];
    _sayac.start();
    if (_sayac.elapsedMilliseconds > 29997 && mevcutsoru < 0) {

      _sayac.reset();
    }
    if (mevcutsoru == 0 && _sayac.elapsedMilliseconds > 29997) {
      Future.delayed(Duration.zero, () async {
        _sayac.reset();
        _sayac.stop();
        _timer.cancel();
        mevcutsoru = 0;
        BitireYolla();
      });
    }
    final ButtonStyle cekil= ElevatedButton.styleFrom(
        primary: Colors.green
    );

    var cevaplistesi = [];
    cevaplistesi = sorular[mevcutsoru]['cevaplar'];

    return Scaffold(
      appBar: new AppBar(backgroundColor: Colors.indigo,
        title: new Text('Bil Kazan', style:GoogleFonts.playfairDisplaySc()),
        centerTitle: true,
      ),
      body: //Center(
      //  child:
      Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new SizedBox(
                    height: 25,
                    child: Text(
                      'Yarışmacı: ' + adSoyad,
                      style:
                      TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new SizedBox(
                      width: 75,
                      child: RaisedButton(
                        disabledColor: Colors.indigo,
                        child: Text(
                          "500 ₺",
                          style: TextStyle(
                              fontSize: 15, color: Colors.yellowAccent),
                        ),
                      ),
                    ),
                    new SizedBox(
                      width: 75,
                      child: RaisedButton(
                        disabledColor: Colors.amberAccent,
                        child: Text(
                          "1000 ₺",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ),
                    new SizedBox(
                      width: 75,
                      child: RaisedButton(
                        disabledColor: Colors.indigo,
                        child: Text(
                          "2000 ₺",
                          style: TextStyle(
                              fontSize: 15, color: Colors.yellowAccent),
                        ),
                      ),
                    ),
                    new SizedBox(
                      width: 75,
                      child: RaisedButton(
                        disabledColor: Colors.indigo,
                        child: Text(
                          "3000 ₺",
                          style: TextStyle(
                              fontSize: 15, color: Colors.yellowAccent),
                        ),
                      ),
                    ),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new SizedBox(
                      width: 75,
                      child: RaisedButton(
                        disabledColor: Colors.indigo,
                        child: Text(
                          '5000 ₺',
                          style: TextStyle(
                              fontSize: 15, color: Colors.yellowAccent),
                        ),
                      ),
                    ),
                    new SizedBox(
                      width: 75,
                      child: RaisedButton(
                        disabledColor: Colors.indigo,
                        child: Text(
                          '7500 ₺',
                          style: TextStyle(
                              fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ),
                    new SizedBox(
                      width: 75,
                      child: RaisedButton(
                        disabledColor: Colors.indigo,
                        child: Text(
                          '15000 ₺',
                          style: TextStyle(fontSize: 15, color: Colors.yellowAccent),
                        ),
                      ),
                    ),
                    new SizedBox(
                      width: 75,
                      child: RaisedButton(

                        disabledColor: Colors.indigo,
                        child: Text(
                          '30000 ₺',
                          style: TextStyle(
                              fontSize: 15, color: Colors.yellowAccent),
                        ),
                      ),
                    ),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    zamaniFormatla(_sayac.elapsedMilliseconds),
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new SizedBox(
                      width: 150,
                      child: ElevatedButton( style: cekil,
                        onPressed: () {
                          setState(() {
                            mevcutcevap = cevaplistesi[0].toString();
                          });
                          kontrolEt_cekil();
                        },
                        child: Align(
                          // Color:Colors.green,
                          alignment: Alignment.center,
                          child: Text(
                            'Yarışmadan Çekil',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ]
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: const Divider(
                        height: 10,
                        thickness: 3,
                        indent: 20,
                        endIndent: 20,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(child:
                  Text(
                    sorular[mevcutsoru]['soru'].toString(),
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new SizedBox(
                    width: 150,
                    child: ElevatedButton(

                      onPressed: () {
                        setState(() {
                          mevcutcevap = cevaplistesi[0].toString();
                        });
                        kontrolEt();
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'A) ' + cevaplistesi[0],
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                  new SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          mevcutcevap = cevaplistesi[1].toString();
                        });
                        kontrolEt();
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'B) ' + cevaplistesi[1],
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          mevcutcevap = cevaplistesi[2].toString();
                        });
                        kontrolEt();
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'C) ' + cevaplistesi[2],
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                  new SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          mevcutcevap = cevaplistesi[3].toString();
                        });
                        kontrolEt();
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'D) ' + cevaplistesi[3],
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
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
