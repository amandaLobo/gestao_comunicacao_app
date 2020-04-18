import 'package:br/assets/custom_icons_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileTab extends StatelessWidget {

  final String _fullName = "Amanda Lobo";
  final String _status = "Software Developer";

  /*Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 2.5,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/cover.jpeg'),
          fit: BoxFit.cover,
       color: Color.fromARGB(255, 103, 181, 254),
      ),
    );
  }
*/
  Widget _buildProfileImage() {
    return Center(
      child: Container(
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/woman.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(100.0),
          border: Border.all(
            color: Color.fromARGB(255, 244, 244, 244),
            width: 5.0,
          ),
        ),
      ),
    );
  }

  Widget _buildFullName() {
    TextStyle _nameTextStyle = GoogleFonts.nunito(
        fontSize: 28,
        fontWeight: FontWeight.bold,
    );

    return Center(
      child: Text(
        _fullName,
        style: _nameTextStyle,
      ),
    );
  }

  Widget _buildStatus(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text(
            _status,
          style: GoogleFonts.nunito(
              fontSize: 20,
              fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }

  Widget _buildSeparator(Size screenSize) {
    return Container(
      width: screenSize.width / 1.15,
      height: 0.8,
      color: Color.fromARGB(100, 197, 197, 197),
      margin: EdgeInsets.only(top: 4.0),
    );
  }

  Widget _buildList(BuildContext context){
    EdgeInsetsGeometry _padding = EdgeInsets.fromLTRB(30, 15, 30, 15);

    Color _color = Color.fromARGB(255, 30, 54, 76);

    TextStyle _style = GoogleFonts.nunito(color: _color, fontSize: 18);

    ShapeBorder _shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14.0),
    );


    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        FlatButton(
            child: Center(
              child: Row(
                children: <Widget>[
                  Icon(FontAwesomeIcons.userCircle, color: _color),
                  SizedBox(width: 30),
                  Text('minha conta', style: _style),
                ],
              ),
            ),
           // color: Colors.white,
            splashColor: Colors.grey.withAlpha(40),
            highlightColor: Colors.grey.withAlpha(40),
            shape: _shape,
            padding: _padding,
            onPressed: (){
            }
        ),
        FlatButton(
            child: Center(
              child: Row(
                children: <Widget>[
                  Icon(Icons.favorite_border, color: _color),
                  SizedBox(width: 30),
                  Text('favoritos', style: _style),
                ],
              ),
            ),
            // color: Colors.white,
            splashColor: Colors.grey.withAlpha(40),
            highlightColor: Colors.grey.withAlpha(40),
            shape: _shape,
            padding: _padding,
            onPressed: (){
            }
        ),
        FlatButton(
            child: Center(
              child: Row(

                children: <Widget>[
                  Icon(CustomIcons.engrenagem, color: _color, size: 25),
                  SizedBox(width: 30),
                  Text('configurações', style: _style),
                ],
              ),
            ),
        //    color: Colors.white,
            splashColor: Colors.grey.withAlpha(40),
            highlightColor: Colors.grey.withAlpha(40),
            shape: _shape,
            padding: _padding,
            onPressed: (){
            }
        ),
        FlatButton(
            child: Center(
              child: Row(

                children: <Widget>[
                  Icon(Icons.exit_to_app, color: _color),
                  SizedBox(width: 30),
                  Text('sair', style: _style),
                ],
              ),
            ),
        //    color: Colors.white,
            splashColor: Colors.grey.withAlpha(40),
            highlightColor: Colors.grey.withAlpha(40),
            shape: _shape,
            padding: _padding,
            onPressed: (){
              showDialog(context: context, builder: (context)=>AlertDialog(
                title: Text('Sair',  style: GoogleFonts.nunito()),
                content: Text('Tem certeza que deseja sair?', style: GoogleFonts.nunito()),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 2.0,

                actions: <Widget>[
                  FlatButton(
                    child: Text('CANCELAR'),
                    onPressed: (){
                      Navigator.maybePop(context);
                    },
                  ),
                  FlatButton(
                    child: Text('OK'),
                    onPressed: (){
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushReplacementNamed('/');
                    },
                  )
                ],
              ));

            }
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
         // _buildCoverImage(screenSize),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 40),
                    _buildProfileImage(),
                    _buildFullName(),
                    _buildStatus(context),
                   // _buildStatContainer(),
                    _buildSeparator(screenSize),
                    SizedBox(height: 20),
                    _buildList(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}