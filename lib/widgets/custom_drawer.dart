import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomDrawer extends StatelessWidget {

  final TabController tabController;

  CustomDrawer(this.tabController);

  @override
  Widget build(BuildContext context) {
    Color _color = Color.fromARGB(255, 30, 54, 76);
    TextStyle _style = GoogleFonts.nunito(fontSize: 18, color: _color);

    Widget _background(){
      return Container(
        decoration: BoxDecoration(
         color: Color.fromARGB(255, 103, 181, 254)
          )

      );
    }

    Widget _header() {
      return Container(
        margin: EdgeInsets.fromLTRB(0,20, 5, 10),
        padding: EdgeInsets.fromLTRB(0, 20, 5, 10),
        child: Column(
          children: <Widget>[
            Container(

              margin: EdgeInsets.only(bottom: 20),
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/woman.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(100.0),
                border: Border.all(
                  color: Color.fromARGB(255, 244, 244, 244),
                  width: 0.5,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text('Olá, admin.',
                  style: GoogleFonts.nunito(
                      color: _color,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)
              ),
              alignment: Alignment.centerLeft,
            )
          ],
        ),
      );
    }

    Widget _tile() {
      return Column(
        children: <Widget>[
          ListTile(
            leading: Icon(FontAwesomeIcons.users, color: _color),
            title: Text('Usuários', style: _style),
          ),
          ListTile(
            leading: Icon(Icons.assignment_ind, color: _color),
            title: Text('Perfis', style: _style),
            onTap: () {

            },
          ),
          ListTile(
            leading: Icon(Icons.business, color: _color),
            title: Text('Empresas', style: _style),
          ),
          ListTile(
            leading: Icon(Icons.group_work, color: _color),
            title: Text('Equipes', style: _style),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.projectDiagram, color: _color),
            title: Text('Projetos', style: _style),
          ),
          ListTile(
            leading: Icon(Icons.markunread, color: _color),
            title: Text('Comunicados', style: _style),
          ),
        ],
      );
    }

    return Drawer(
      child: Stack(
        children: <Widget>[
          _background(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 10.0),
            children: <Widget>[

              _header(),
              Divider(),
              _tile(),
            ],
          )
        ]

      ),
    );
  }
}