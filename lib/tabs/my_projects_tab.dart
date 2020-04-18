import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProjectsTab extends StatelessWidget {

  final items = List<String>.generate(1, (i) => "project $i");

  Widget _buildImage() {
   return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/flutter.png'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: Color.fromARGB(255, 244, 244, 244),
          width: 1.0,
        ),
      ),
    );
  }

  /*
  Widget _buildTitle() {
    TextStyle _textStyle = GoogleFonts.nunito(
        fontSize: 15,
        color: Colors.black
    );

    return Text(
      '${items[index]}',
      style: _textStyle,
    );
  }
   */

  /*
  Widget _buildDescription() {
    TextStyle _textStyle = GoogleFonts.nunito(
        fontSize: 10,
        color: Colors.black
    );

    return Text(
      '${items[index]}',
      style: _textStyle,
    );
  }
   */

  Widget _buildButtons(){
    return ButtonBar(
      children: <Widget>[
        FlatButton(
            child: Text('ABRIR', style: GoogleFonts.nunito()),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              ),
            onPressed: (){

            }
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: _buildImage(),
                    title: Text('Support Flutter',
                        style: GoogleFonts.nunito(color: Colors.black, fontWeight: FontWeight.bold)),
                    subtitle: Text('ITSS Tecnologia',
                        style: GoogleFonts.nunito(color: Colors.black)),
                    //isThreeLine: ,
                  ),
                  _buildButtons(),
                ],
              ),
              margin: EdgeInsets.all(5),
              elevation: 1.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ));
        });
  }
}
