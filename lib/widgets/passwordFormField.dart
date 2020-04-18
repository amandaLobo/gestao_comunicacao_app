import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordFormField extends StatefulWidget{
  final bool hasIcon;
  final String label;
  final TextEditingController controller;
  final Stream<String> stream;
  final Function(String) onChanged;

  PasswordFormField({this.hasIcon, this.label, this.controller, this.stream, this.onChanged});

  @override
  _PasswordFormFieldState createState() => _PasswordFormFieldState(hasIcon, label, controller: controller, stream: stream, onChanged: onChanged);


}

class _PasswordFormFieldState extends State<PasswordFormField>{
  final bool hasIcon;
  final String label;
  final TextEditingController controller;
  final Stream<String> stream;
  final Function(String) onChanged;

  _PasswordFormFieldState(this.hasIcon, this.label,{ this.controller, this.stream, this.onChanged});

  bool _showPassword = false;

  Widget icon(){
    if(hasIcon) return Icon(
        FontAwesomeIcons.lock,
        color: Color.fromARGB(255, 103, 181, 254),
        size: 15);
    else return null;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: stream,
      builder: (context, snapshot) {
        return TextFormField(
          onChanged: onChanged,
          controller: controller,
          decoration: InputDecoration(
            icon: icon(),
            labelText: label,
            suffixIcon: GestureDetector(
              onTap: (){
                setState(() {
                  _showPassword = !_showPassword;
                });
              },
              child: Icon(
                _showPassword ? Icons.visibility : Icons.visibility_off
              ),
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 103, 181, 254))
            ),
            contentPadding: EdgeInsets.fromLTRB(5, 20, 20, 10),
          ),
          style: GoogleFonts.nunito(color: Colors.black),

          obscureText: !_showPassword,
          // ignore: missing_return
          validator: (String value){
            if(value.length < 6){
              return 'A senha deve conter, no mínimo, 6 caracteres.';
            }
          },
        );
      }
    );
  }
}