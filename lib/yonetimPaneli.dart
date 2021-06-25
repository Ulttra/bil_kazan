import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:hafta6/views/list_uyes.dart';
import 'package:sqflite/sqflite.dart';
import 'package:hafta6/models/Uye.dart';
import 'package:hafta6/services/db_utils.dart';



class YonetimPaneli extends StatefulWidget {
  @override
  _YonetimPaneliState createState() => _YonetimPaneliState();
}

class _YonetimPaneliState extends State<YonetimPaneli> {

  String adSoyad = '';
  TextEditingController uyeAdController = TextEditingController();
  TextEditingController uyeKodController = TextEditingController();

  Future<Database> database;

  List<Uye> uyeList = [];

  _onPressedUpdate() async {
    final enik = Uye(
      kod: uyeKodController.text,
      isim: uyeAdController.text,

    );
    utils.updateUye(enik);
    uyeList = await utils.uyes();
    //print(dogList);
    getData();
  }

  _onPressedAdd() async {
    final enik = Uye(
      kod: uyeKodController.text,
      isim: uyeAdController.text,
    );
    utils.insertUye(enik);
   uyeList = await utils.uyes();
    //print(dogList);
    getData();
  }

  _deleteDogTable() {
    utils.deleteTable();
    uyeList = [];
    getData();
  }

  void getData() async {
    await utils.uyes().then((result) => {
      setState(() {
        uyeList = result;
      })
    });
    print(uyeList);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    getData();
  }

  @override
  Widget build(BuildContext context) {
    var data = [];
    data = ModalRoute.of(context).settings.arguments;
    adSoyad=data[0];
   final ButtonStyle basla = ElevatedButton.styleFrom(primary: Colors.indigo);
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Bil Kazan', style: GoogleFonts.playfairDisplaySc()),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: uyeAdController,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Uye İsmi'
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: uyeKodController,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Giriş Kodu'
                ),
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
                width: 200,
                 child: ElevatedButton(
                  onPressed: _onPressedAdd, child: Text("Üye Ekle")),
            ),
      ]
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
              width: 200,
              child: ElevatedButton(
                  onPressed: _onPressedUpdate, child: Text("Üye Güncelle")),
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
              width: 200,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ListUyes()),
                    );
                  },
                  child: Text("Üyeleri Listele")),
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
                    width: 200,
                    child: ElevatedButton(
                        onPressed: _deleteDogTable,
                        child: Text("Üye Tablosunu Sil")),
                  ),
                ],
              ),
            ),

        /*   Text(uyeList.length.toString()),
        SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: uyeList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(uyeList[index].isim),
                    );
                  },
                ),
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
