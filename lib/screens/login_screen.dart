import 'package:br/blocs/login_bloc.dart';
import 'package:br/screens/home_screen.dart';
import 'package:br/screens/signup_screen.dart';
import 'package:br/widgets/passwordFormField.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget{
  @override
  _LoginScreenState createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen>{

  final _loginBloc = LoginBloc();
  final Color _color = Color.fromARGB(255, 103, 181, 254);

  @override
  void initState(){
    super.initState();
    _loginBloc.outState.listen((state){
      switch(state){
        case LoginState.SUCCESS:
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context)=>HomeScreen())
          );
          break;
        case LoginState.FAIL:
          showDialog(context: context, builder: (context)=>AlertDialog(
            content: Text('Este usuário não existe.', style: GoogleFonts.nunito()),
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
        case LoginState.LOADING:
        case LoginState.IDLE:
      }
    });
  }

  Widget _buildLogo(){
    return Center(
      child: Container(
        width: 150.0,
        height: 150.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/logo2.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildInputs(){

    Widget _input({IconData icon, String label, bool obscure, Widget suffixIcon, Stream<String> stream, Function(String) onChanged}){
      return StreamBuilder<String>(
          stream: stream,
          builder: (context, snapshot) {
            return TextFormField(
              onChanged: onChanged,
              decoration: InputDecoration(
                icon: Icon(icon, color: _color, size: 15),
                labelText: label,
                labelStyle: GoogleFonts.nunito(),
                suffixIcon: suffixIcon,
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: _color)
                ),
                contentPadding: EdgeInsets.fromLTRB(5, 20, 20, 10),
                errorText: snapshot.hasError ? snapshot.error : null,
              ),
              style: GoogleFonts.nunito(color: Colors.black),
              obscureText: obscure,
            );
          }
      );
    }

    return Form(
      child: Column(
        children: <Widget>[
          _input(
            icon: FontAwesomeIcons.solidUser,
            label: 'email',
            obscure: false,
            stream: _loginBloc.outEmail,
            onChanged: _loginBloc.changeEmail,
          ),
         PasswordFormField(
           hasIcon: true,
           label: 'senha',
           stream: _loginBloc.outPassword,
           onChanged: _loginBloc.changePassword,
         )
        ],
      ),
    );
  }

  Widget _buildForgetPass(){

    final _emailController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    AlertDialog _emailSendedDialog(String email) => AlertDialog(
        content: Text('Enviamos um email para $email. Clique no link do email para redefinir sua senha.', style: GoogleFonts.nunito()),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 2.0,
        actions: <Widget>[
            FlatButton(
                child: Text('OK'),
                onPressed: (){
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context)=>LoginScreen())
                    );
                },
            )
        ]
    );

    AlertDialog _resetPassDialog = AlertDialog(
      title: Center(child: Text('Recuperar senha', style: GoogleFonts.nunito())),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 100,
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text('Insira o email cadastrado. Você receberá um link para redefinir sua senha.', style: GoogleFonts.nunito()),
              TextFormField(

                controller: _emailController,
                  validator:  (value) {
                      if(!EmailValidator.validate(_emailController.text)){
                        return 'Email inválido';
                      }else return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'email',
                      labelStyle: GoogleFonts.nunito(),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: _color))
                  )
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('CANCELAR'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          onPressed: (){
            Navigator.maybePop(context);
          },
        ),
        FlatButton(
          child: Text('ENVIAR'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          onPressed: (){
            if(_formKey.currentState.validate()){
              _loginBloc.recoverPassword(_emailController.text);
              showDialog(context: context, builder: (context)=> _emailSendedDialog(_emailController.text));
            }else {

            }
          },
        )
      ],
    );

    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Row(
        children: <Widget>[
          Text('Esqueceu sua senha?', style: TextStyle(color: Colors.grey)),
        ],
      ),
      onPressed: (){
        showDialog(context: context, builder: (context)=>_resetPassDialog);
      },
    );
  }


  Widget _buildButtons(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        StreamBuilder<bool>(
            stream: _loginBloc.onSubmitValid,
            builder: (context, snapshot) {
              return RaisedButton(
                color: Colors.white,
                elevation: 5.0,
                padding: EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Text('login', style: TextStyle(color: _color, fontSize: 15.0)),
                onPressed: snapshot.hasData ? _loginBloc.submit : null,
                disabledColor: Colors.white.withAlpha(200),
                disabledElevation: 2.0,
              );
            }
        ),
      ],
    );
  }

  Widget _buildSignUp(){
    return FlatButton(
      padding: EdgeInsets.only(left: 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Row(
        children: <Widget>[
          Text('Não tem uma conta? ', style: TextStyle(color: Colors.grey)),
          Text('Cadastre-se.', style: TextStyle(color: _color, fontWeight: FontWeight.bold)),
        ],
      ),
      onPressed: (){
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=>SignUpScreen())
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Scaffold(
        //backgroundColor: Color.fromARGB(255,249, 255, 255),
        body: StreamBuilder<LoginState>(
          stream: _loginBloc.outState,
          initialData: LoginState.LOADING,
          // ignore: missing_return
          builder: (context, snapshot) {
            switch(snapshot.data){
              case LoginState.LOADING:
                return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(_color)
                    )
                );
              case LoginState.FAIL:
              case LoginState.SUCCESS:
              case LoginState.IDLE:
              return Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(left: 40, top: 100, right: 40, bottom: 20),
                      child: Column(
                        //  crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(height: 50),
                          _buildLogo(),
                          SizedBox(height: 10),
                          _buildInputs(),
                          _buildForgetPass(),
                          SizedBox(height: 25.0),
                          _buildButtons(),
                          _buildSignUp(),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          }
        ),
      ),
    );
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

}
