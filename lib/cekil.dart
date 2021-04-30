import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Cekil extends StatefulWidget {
  @override
  _CekilState createState() => _CekilState();
}

class _CekilState extends State<Cekil> {
  @override
  Widget build(BuildContext context) {
    var data = [];
    data = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: new AppBar(
        title: new Text('Bil Kazan', style:GoogleFonts.playfairDisplaySc()),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Yarışmadan Çekildiniz!!',
                  style: TextStyle(fontSize: 25.0)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Yarışmacı:  ' + data[0].toString(),
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Kazanılan Ödül:  ' + data[1].toString(),
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.green)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/');
                },
                child: Text('     Ana Sayfaya Dön     '),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
