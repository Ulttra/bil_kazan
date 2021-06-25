import 'package:flutter/material.dart';
import 'package:hafta6/readwrite.dart';

class Dosyaokuyaz extends StatefulWidget {
  Dosyaokuyaz() : super();

  final String title = "Görüşleriniz Bizim İçin Kıymetlidir..";

  @override
  _DosyaokuyazState createState() => _DosyaokuyazState();
}

class _DosyaokuyazState extends State<Dosyaokuyaz> {
  @override
  Widget build(BuildContext context) {
    var data = [];
    data = ModalRoute.of(context).settings.arguments;
    String fileContents = "Veri Yok";
    final myController = TextEditingController(text: data[0] + ' - ');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: myController,
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
                    child: Text("Görüş Bildir"),
                    onPressed: () {
                      FileUtils.saveToFile(myController.text);
                      Navigator.pushReplacementNamed(context, '/');
                    },
                  ),
                ),
                new SizedBox(
                  width: 150,
                  child: ElevatedButton(
                      child: Text("Vazgeç"),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/');
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
