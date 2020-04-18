import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedTab extends StatelessWidget {

  final items = List<String>.generate(1, (i) => "comunicado $i");

  Widget _buildImage(Size screenSize) {
    return Center(
      child: Container(
        width: screenSize.width - 10.0,
        height: 200.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/flutter.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.white,
            width: 1.0,
          ),
        ),
      ),
    );
  }

  Widget _buildDescription() {
    TextStyle _textStyle = GoogleFonts.nunito(
      color: Colors.black,
      fontSize: 16,
    );

    return Text(
      'Buscamos um perfil experiente no framework Flutter, disponível por 1 mês.'
          '\nAtividades: Auxiliar na manutenção.',
      style: _textStyle,
    );
  }

  Widget _buildTitle() {
    TextStyle _textStyle = GoogleFonts.nunito(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold
    );

    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          Text(
            'Suport: Flutter developer',
            style: _textStyle,
          ),
          _buildDescription(),
        ],
      ),
    );
  }


  Widget _buildButtons() {
    return ButtonBar(
            alignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(
                   icon: Icon(Icons.favorite_border),
                  iconSize: 25,
                  onPressed: (){

                  },
                ),
                IconButton(
                  icon: Icon(FontAwesomeIcons.paperPlane),
                  iconSize: 20,
                  onPressed: (){

                  },
                ),
              ],
          );

    }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery
        .of(context)
        .size;

    return ListView.separated(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Align(
          alignment: Alignment.centerLeft,
          child:
          Container(
            color: Color.fromARGB(10, 223, 223, 223),
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(2),
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _buildImage(screenSize),
                    _buildTitle(),
                    Divider()
                  ],
                ),
              ),
              _buildButtons()
            ],
          )
        ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => Divider(),
    );
  }
}
