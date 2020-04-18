import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

enum SignUpState{IDLE, LOADING, SUCCESS, FAIL}

class SignUpBloc extends BlocBase{

  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser firebaseUser;

  Map<String, dynamic> userData = Map();

  final _stateController = BehaviorSubject<SignUpState>();

  Stream<SignUpState> get outState => _stateController.stream;


  SignUpBloc(){

        _stateController.add(SignUpState.IDLE);

  }

  void signUp({@required Map<String, dynamic> userData, @required String password}){
    _stateController.add(SignUpState.LOADING);

    _auth.createUserWithEmailAndPassword(
        email: userData['email'],
        password: password
    ).then((user) async {
      firebaseUser = user as FirebaseUser;
      await _saveUserData(userData);

      _stateController.add(SignUpState.SUCCESS);
    }).catchError((onError){
      _stateController.add(SignUpState.FAIL);
    });
  }

  Future<void> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await Firestore.instance.document(firebaseUser.uid).setData(userData);
  }


  @override
  void dispose() {

    _stateController.close();

    super.dispose();
  }

}