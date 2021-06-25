import 'dart:async';
import 'dart:core';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:hafta6/bitir.dart';
import 'package:hafta6/cekil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/gestures.dart';
import 'package:hafta6/main.dart';
import 'dart:math' as math;
import 'dart:convert';
import 'package:hafta6/models/loadData.dart';
import 'package:hafta6/soru13.dart';
import 'dart:async';
import 'dart:core';
import 'package:http/http.dart' as http;

Future<LoadData> apiCall() async {
  final response = await http.get(Uri.parse(
    //'https://raw.githubusercontent.com/alimcevik/jsonapi/master/api.json')
      'https://raw.githubusercontent.com/Ulttra/jsonapi/main/api.json'));
  if (response.statusCode == 200) {
    return LoadData.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: soru12(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        accentColor: Colors.blueAccent,
      ),
    );
  }
}

class soru12 extends StatefulWidget {
  @override
  _soru12State createState() => _soru12State();
}

String zamaniFormatla(int milisaniye) {
  var saniye = milisaniye ~/ 1000;
  var dakika = ((saniye % 3600) ~/ 60).toString().padLeft(2, '0');
  var saniyeler = (30-(saniye % 60)).toString().padLeft(2, '0');
  return "$dakika:$saniyeler";
}

class _soru12State extends State<soru12> with TickerProviderStateMixin {
  AnimationController controller;

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  String adSoyad = '';
  String hakedis = '200000 ₺';
  String odul = '125000 ₺';
  var mydata = [];
  String a;
  String dogrucevap='Slalom';


  Stopwatch _sayac;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _sayac = Stopwatch();
    _timer = new Timer.periodic(new Duration(seconds: 1), (timer) {
      setState(() {});
    });
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 30),
    );
    mevcutsoru = 0;
    mevcutcevap = '';
    controller.isAnimating;
  }

  int mevcutsoru = 0;
  String mevcutcevap = '';

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void deneme() {
    if (controller.isAnimating)
    {  controller.stop();}
    else {
      controller.reverse(
          from: controller.value == 0.0 ? 1.0 : controller.value);

    }
  }

  void BitireYolla() {
    var data = [];
    data.add(adSoyad);
    data.add(odul.toString());
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
          builder: (context) => soru13(),
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
      if (mevcutcevap == dogrucevap) {
        hakedis = '300000 ₺';
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

  void _onVerticalDragStartHandler(DragStartDetails details) {
    setState(() {
      ScaffoldMessenger.of(context)
          .showSnackBar(new SnackBar(content: new Text('Geçersiz İşlem')));
    });
  }

  @override
  Widget build(BuildContext context) {
    var data = [];
    data = ModalRoute.of(context).settings.arguments;
    adSoyad = data[0];
    hakedis = data[1];

    _sayac.start();
    deneme();
    if (_sayac.elapsedMilliseconds > 29997 && mevcutsoru < 0) {
      _sayac.reset();
      mevcutsoru++;
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
    final ButtonStyle cekil = ElevatedButton.styleFrom(primary: Colors.green);
    /* List cevaplistesi=[];
    * for(var u in sorular[sorular]['cevaplar'])
    * {  cevaplistesi.add(u);               }*/

    ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.indigo,
        title: new Text('Bil Kazan', style: GoogleFonts.playfairDisplaySc()),
        centerTitle: true,
      ),
      body: //Center(
      //  child:

      FutureBuilder<LoadData>(
          future: apiCall(),
          // ignore: missing_return
          builder: (context, snapshot) {
            dogrucevap= snapshot.data.fnlsorular[3]["cevap"];
            if (snapshot.hasData) {
              //  var mydata = jsonDecode(snapshot.data.toString());
              return Container(
                child: Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: new GestureDetector(
                      onVerticalDragStart: _onVerticalDragStartHandler,
                      child: Container(
                        child: Column(

                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            /* FutureBuilder<LoadData>(
                                    future: apiCall(),
                                    // ignore: missing_return
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        //  var mydata = jsonDecode(snapshot.data.toString());
                                        return Container(
                                            child: Text(snapshot
                                                .data.fnlsorular[0]["soru"]));
                                      } else {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      }
                                    }),*/
                            Padding(
                              padding: const EdgeInsets.all(15.0),

                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: <Widget>[
                                  new SizedBox(
                                    height: 25,
                                    child: Text(
                                      'Yarışmacı: ' + adSoyad,
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new SizedBox(
                                      width: 95,
                                      child: RaisedButton(
                                        disabledColor: Colors.indigo,
                                        child: Text(
                                          "60000 ₺",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.yellowAccent),
                                        ),
                                      ),
                                    ),
                                    new SizedBox(
                                      width: 95,
                                      child: RaisedButton(
                                        disabledColor: Colors.indigo,
                                        child: Text(
                                          "125000 ₺",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    new SizedBox(                                      width: 95,
                                      child: RaisedButton(
                                        disabledColor: Colors.indigo,
                                        child: Text(
                                          "200000 ₺",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.yellowAccent),
                                        ),
                                      ),
                                    ),
                                    new SizedBox(
                                      width: 95,
                                      child: RaisedButton(
                                        disabledColor: Colors.amberAccent,
                                        child: Text(
                                          "300000 ₺",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.yellowAccent),
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new SizedBox(
                                      width: 95,
                                      child: RaisedButton(
                                        disabledColor: Colors.indigo,
                                        child: Text(
                                          '400000 ₺',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.yellowAccent),
                                        ),
                                      ),
                                    ),
                                    new SizedBox(
                                      width: 95,
                                      child: RaisedButton(
                                        disabledColor: Colors.indigo,
                                        child: Text(
                                          '500000 ₺',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    new SizedBox(
                                      width: 95,
                                      child: RaisedButton(
                                        disabledColor: Colors.indigo,
                                        child: Text(
                                          '750000 ₺',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.yellowAccent),
                                        ),
                                      ),
                                    ),
                                    new SizedBox(
                                      width: 95,
                                      child: RaisedButton(
                                        disabledColor: Colors.indigo,
                                        child: Text(
                                          '1000000 ₺',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.yellowAccent),
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    height: 75.0,
                                    width: 75.0,
                                    child: AnimatedBuilder(
                                        animation: controller,
                                        builder: (context, child) {


                                          return Stack(
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                EdgeInsets.all(1.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  children: <Widget>[
                                                    Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: SizedBox(
                                                            height: 70.0,
                                                            width: 70.0,
                                                            child: Align(
                                                              alignment:
                                                              FractionalOffset
                                                                  .center,
                                                              child:
                                                              AspectRatio(
                                                                aspectRatio:
                                                                1.0,
                                                                child:
                                                                Stack(
                                                                  children: <
                                                                      Widget>[
                                                                    Positioned
                                                                        .fill(
                                                                      child: CustomPaint(
                                                                          painter: CustomTimerPainter(
                                                                            animation:
                                                                            controller,
                                                                            backgroundColor:
                                                                            Colors.lightBlueAccent,
                                                                            color:
                                                                            themeData.indicatorColor,
                                                                          )),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                      FractionalOffset.center,
                                                                      child:
                                                                      Column(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment.spaceEvenly,
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment.center,
                                                                        children: <Widget>[
                                                                          Text(
                                                                            zamaniFormatla(_sayac.elapsedMilliseconds),
                                                                            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                                                                            overflow: TextOverflow.clip,
                                                                            textAlign: TextAlign.center,
                                                                            /*     timerString,
                                                                                style: TextStyle(fontSize: 23.0, color: Colors.black),
                                                                                overflow: TextOverflow.clip,
                                                                                textAlign: TextAlign.center,*/
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new SizedBox(
                                      width: 150,
                                      child: ElevatedButton(
                                        style: cekil,
                                        onPressed: () {
                                          setState(() {

                                          });
                                          kontrolEt_cekil();
                                        },
                                        child: Align(
                                          // Color:Colors.green,
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Yarışmadan Çekil',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: const Divider(
                                        height: 10,
                                        thickness: 3,
                                        indent: 10,
                                        endIndent: 10,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),

                            /*   Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      FutureBuilder<LoadData>(
                                          future: apiCall(),
                                          // ignore: missing_return
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              //  var mydata = jsonDecode(snapshot.data.toString());
                                              return Container(
                                                  child: Text(
                                                snapshot.data.fnlsorular[0]
                                                    ["soru"],
                                                style: TextStyle(
                                                    fontSize: 21,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 3,
                                                textAlign: TextAlign.center,
                                              ));
                                            } else {
                                              return Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            }
                                          }),
                                    ],
                                  ),
                                ),*/
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          snapshot.data.fnlsorular[3]["soru"],
                                          style: TextStyle(
                                              fontSize: 21,
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ])),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: <Widget>[
                                  new SizedBox(
                                    width: 150,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          mevcutcevap = snapshot
                                              .data.fnlsorular[3]["sika"]
                                              .toString();
                                        });
                                        kontrolEt();
                                      },
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'A) ' +
                                              snapshot.data
                                                  .fnlsorular[3]["sika"].toString(),
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  ),
                                  new SizedBox(
                                    width: 150,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          mevcutcevap = snapshot
                                              .data.fnlsorular[3]["sikb"]
                                              .toString();
                                        });
                                        kontrolEt();
                                      },
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text('B) ' +
                                            snapshot
                                                .data.fnlsorular[3]["sikb"]
                                                .toString(),  style: TextStyle(fontSize: 15),),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: <Widget>[
                                  new SizedBox(
                                    width: 150,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          mevcutcevap = snapshot
                                              .data.fnlsorular[3]["sikc"]
                                              .toString();
                                        });
                                        kontrolEt();
                                      },
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'C) ' +
                                              snapshot.data
                                                  .fnlsorular[3]["sikc"]
                                                  .toString(),  style: TextStyle(fontSize: 15),),
                                      ),
                                    ),
                                  ),
                                  new SizedBox(
                                    width: 150,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          mevcutcevap = snapshot
                                              .data.fnlsorular[3]["sikd"]
                                              .toString();
                                        });
                                        kontrolEt();
                                      },
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'D) ' +
                                              snapshot.data
                                                  .fnlsorular[3]["sikd"]
                                                  .toString(),  style: TextStyle(fontSize: 15),),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      onDoubleTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            new SnackBar(
                                content: new Text(
                                    'Seçeneklerden Birini Tıklayınız')));
                      },
                    ),
                  ),
                  /* AnimatedBuilder(
                      animation: controller,
                      builder: (context, child) {
                        return FloatingActionButton.extended(
                            onPressed: () {
                              if (controller.isAnimating)
                                controller.stop();
                              else {
                                controller.reverse(
                                    from: controller.value == 0.0
                                        ? 1.0
                                        : controller.value);
                              }
                            },
                            icon: Icon(controller.isAnimating
                                ? Icons.pause
                                : Icons.play_arrow),
                            label: Text(
                                controller.isAnimating ? "Pause" : "Play"));
                      }), */
                ]),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

class CustomTimerPainter extends CustomPainter {
  CustomTimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 7.0
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color =Colors.red;
    double progress = (1.0 - animation.value) * 4 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(CustomTimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
