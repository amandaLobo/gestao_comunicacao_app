import 'package:br/blocs/signup_bloc.dart';
import 'package:br/widgets/bottom_navbar.dart';
import 'package:br/widgets/passwordFormField.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:masked_text/masked_text.dart';
import 'package:page_slider/page_slider.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();

}

class _SignUpScreenState extends State<SignUpScreen>{

  final _nameController = TextEditingController();
  final _professionController = TextEditingController();
  final _companyController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _signupBloc = SignUpBloc();

  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();

  GlobalKey<PageSliderState> _sliderKey = GlobalKey();



  final Color _color = Color.fromARGB(255, 103, 181, 254);

  @override
  void initState() {
    super.initState();
    _signupBloc.outState.listen((state){
      switch(state){
        case SignUpState.SUCCESS:
          Navigator.of(context).pushReplacementNamed('/');
          break;
        case SignUpState.FAIL:
          showDialog(context: context, builder: (context)=>AlertDialog(
            content: Text('Falha ao cadastrar.'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            elevation: 2.0,

            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: (){
                  Navigator.maybePop(context);
                },
              )
            ],
          ));
          break;
        case SignUpState.LOADING:
        case SignUpState.IDLE:
      }
    });
  }

  Widget _buildAppBar(){
    return AppBar(
      title: Text(
        'Criar conta',
        style: GoogleFonts.nunito(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20
        ),
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(FontAwesomeIcons.chevronLeft, size: 15),
        onPressed: (){
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _buildForm(){

    Widget _input({String label, bool obscure, TextEditingController controller}){
      return TextFormField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.nunito(),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: _color)
          ),
          contentPadding: EdgeInsets.fromLTRB(5, 20, 20, 10),
        ),
        style: GoogleFonts.nunito(color: Colors.black),
        obscureText: obscure,
        controller: controller,
        validator: (value){
          if(value.isEmpty)
            return 'Campo obrigatório';
          return null;
        },
      );
    }

    return PageSlider(
      key: _sliderKey,
      pages: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(20, 110, 20, 20),
          child: Form(
            key: _formKey1,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: GoogleFonts.nunito(),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: _color)
                    ),
                    contentPadding: EdgeInsets.fromLTRB(5, 20, 20, 10),
                  ),
                  style: GoogleFonts.nunito(color: Colors.black),
                  controller: _emailController,
                  validator: (value){
                    if(!EmailValidator.validate(value))
                      return 'Email inválido';
                    return null;
                  },
              ),
                PasswordFormField(
                    hasIcon: false,
                    label: 'Senha',
                    controller: _passwordController
                ),

                SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerRight,
                  child: RaisedButton(
                    color: _color,
                    elevation: 5.0,
                    padding: EdgeInsets.fromLTRB(30, 8, 30, 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text('Próximo', style: TextStyle(color: Colors.white, fontSize: 15.0)),
                    onPressed: () {
                      if(_formKey1.currentState.validate())
                        _sliderKey.currentState.next();
                      else{}
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(20, 50, 20, 20),
          child: Form(
            key: _formKey2,
            child: Column(
              children: <Widget>[
                _input(
                  label: 'Nome',
                  obscure: false,
                  controller: _nameController,
                ),
                _input(
                  label: 'Profissão',
                  obscure: false,
                  controller: _professionController,
                ),
                _input(
                  label: 'Empresa',
                  obscure: false,
                  controller: _companyController,
                ),
                MaskedTextField(
                  maskedTextFieldController: _dateOfBirthController,
                  mask: 'xx/xx/xxxx',
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  inputDecoration: InputDecoration(
                    labelText: 'Data de nascimento',
                    labelStyle: GoogleFonts.nunito(),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: _color)
                    ),
                    contentPadding: EdgeInsets.fromLTRB(5, 20, 20, 10),
                  ),
                ),
                SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RaisedButton(
                          color: Colors.white,
                          elevation: 5.0,
                          padding: EdgeInsets.fromLTRB(30, 8, 30, 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Text('Voltar', style: TextStyle(color: Colors.grey, fontSize: 15.0)),
                          onPressed: () => _sliderKey.currentState.previous(),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: RaisedButton(
                          color: _color,
                          elevation: 5.0,
                          padding: EdgeInsets.fromLTRB(30, 8, 30, 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Text('Próximo', style: TextStyle(color: Colors.white, fontSize: 15.0)),
                          onPressed: () {
                            if(_formKey2.currentState.validate())
                              _sliderKey.currentState.next();
                            else{}
                          },
                        ),
                      ),
                    ],
                  )
                )
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(20, 110, 20, 20),
          child: Form(
            key: _formKey3,
            child: Column(
              children: <Widget>[
                Center(
                  child: RaisedButton(
                    color: _color,
                    elevation: 5.0,
                    padding: EdgeInsets.fromLTRB(30, 8, 30, 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text('Criar conta', style: TextStyle(color: Colors.white, fontSize: 15.0)),
                    onPressed: (){
                        Map<String, dynamic> userData ={
                          'name': _nameController.text,
                          'profession': _professionController.text,
                          'company': _companyController.text,
                          'dateOfBirth': _dateOfBirthController.text,
                          'email': _emailController.text,
                        };
                        _signupBloc.signUp(userData: userData, password: _passwordController.text);
                    },
                  ),
                ),
                Center(
                  child: FlatButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Text('Voltar', style: TextStyle(color: Colors.grey, fontSize: 15)),
                    onPressed: () => _sliderKey.currentState.previous(),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );

  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: _buildAppBar(),
       // backgroundColor: Color.fromARGB(255,249, 255, 255),
        body: StreamBuilder<SignUpState>(
          stream: _signupBloc.outState,
          initialData: SignUpState.LOADING,
          // ignore: missing_return
          builder: (context, snapshot){
            switch(snapshot.data){
              case SignUpState.LOADING:
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(_color),
                  ),
                );
              case SignUpState.FAIL:
              case SignUpState.SUCCESS:
              case SignUpState.IDLE:
                return Stack(
                    children: <Widget>[
                      SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              _buildForm(),
                            ],
                          ),
                        ),
                      ),]
                );
            }
          },
        ),
      ),
    );
  }

}