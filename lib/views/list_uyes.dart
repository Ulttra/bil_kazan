import "package:flutter/material.dart";
import 'package:hafta6/main.dart';
import 'package:hafta6/models/Uye.dart';
import 'package:hafta6/services/db_utils.dart';

DbUtils utils = DbUtils();

class ListUyes extends StatefulWidget {
  @override
  _ListUyesState createState() => _ListUyesState();
}

class _ListUyesState extends State<ListUyes> {
  List<Uye> uyeList = [];

  void getData() async {
    await utils.uyes().then((result) => {
      setState(() {
       uyeList = result;
      })
    });
    print(uyeList);
  }

  void showAlert(String alertTitle, String alertContent) {
    AlertDialog alertDialog;
    alertDialog =
        AlertDialog(title: Text(alertTitle), content: Text(alertContent));
    showDialog(context: context, builder: (_) => alertDialog);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(uyeList.length.toString() + " Uye Listelenmektedir")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: uyeList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Uye İsmi: '+ uyeList[index].isim+'       Giris Kodu: '+ uyeList[index].kod),
                    onTap: () {
                      showAlert("Uye " + index.toString() + " clicked",
                          "Uye " + index.toString() + " clicked");
                    },
                    onLongPress: () async {
                      await utils.deleteUye(uyeList[index].kod).then((value) => {
                        showAlert("Uye " + index.toString() + " deleted",
                            "Uye " + index.toString() + " deleted")
                      });
                      getData();
                    },
                  );
                },
              ),
            ),
          /*  Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                  },
                  child: Text("Return Homepage")),
            ),*/
          ],
        ),
      ),
    );
  }
}