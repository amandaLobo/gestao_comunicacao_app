import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationTab extends StatelessWidget {

  final items = List<String>.generate(2, (i) => "notification $i");

  Widget _buildImage() {
    return  Container(
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


  @override
  Widget build(BuildContext context) {

    return ListView.separated(
      itemCount: items.length <= 15 ? items.length : 15,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (context, index) {
        return ListTile(
            leading: _buildImage(),
            title: Text('Novo comunicado',
                style: GoogleFonts.nunito(color: Colors.black, fontWeight: FontWeight.bold)),
            subtitle: Text('Support Flutter',
                style: GoogleFonts.nunito(color: Colors.black)),
            onTap: () {},

        );

      },
    );
  }
}
