import 'dart:async';
import 'package:email_validator/email_validator.dart';

class LoginValidators {
  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink){
      if(EmailValidator.validate(email)){
        sink.add(email);
      }else{
        sink.addError('Insira um email válido');
      }
    }
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink){
      if(password.length >= 6){
        sink.add(password);
      }else{
        sink.addError('A senha deve conter, no mínimo, 6 caracteres');
      }
    }
  );

}