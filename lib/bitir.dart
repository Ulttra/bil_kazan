import 'package:flutter/material.dart';

class Bitir extends StatefulWidget {
  @override
  _BitirState createState() => _BitirState();
}

class _BitirState extends State<Bitir> {
  @override
  Widget build(BuildContext context) {
    var data = [];
    data = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: new AppBar(
        title: new Text('Bil Kazan'),
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
            child: Text('Bitti!!', style: TextStyle(fontSize: 25.0)),),
            Padding(
              padding: const EdgeInsets.all(8.0),child:Text('Yarışmacı:  ' + data[0].toString(),
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),),
            Padding(
              padding: const EdgeInsets.all(8.0), child:Text('Kazanılan Ödül:  ' + data[1].toString(),
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.green)),),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(

              onPressed: () {
                Navigator.pushReplacementNamed(context, '/');
              },
              child: Text('       Yeniden Başla       ',  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),

            ),
        ),
          ],

        ),
      ),
    );
  }
}
