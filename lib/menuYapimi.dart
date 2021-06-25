import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hafta6/yonetimPaneligiris.dart';
import 'package:google_fonts/google_fonts.dart';
class MenuYapimi extends StatefulWidget {
  @override
  _MenuYapimiState createState() => _MenuYapimiState();
}

class _MenuYapimiState extends State<MenuYapimi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bil Kazan", style: GoogleFonts.playfairDisplaySc()), centerTitle: true, backgroundColor: Colors.indigo,),
      body: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo),
              accountName: Text(
                "Coşkun BALKESEN",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              accountEmail: Text(
                "bilkazan.com ",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              currentAccountPicture: Image.asset(
                "assets/images/logoo.png",
                alignment: Alignment.center,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.admin_panel_settings,
                    ),
                    title: Text("Yönetim Paneli"),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => YonetimPaneliGiris()));
                    },
                  ),

                  AboutListTile(
                    applicationName: " Lisans",
                    applicationIcon: Icon(Icons.settings_applications),
                    applicationVersion: "25.15",
                    child: Text("Uygulama Hakkında"),
                    icon: Icon(Icons.save),
                    applicationLegalese: null,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
