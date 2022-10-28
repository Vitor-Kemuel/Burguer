import 'package:burguer/Core/Container/user.container.dart';
import 'package:burguer/Model/user.model.dart';
import 'package:burguer/View/Home/home.view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationException implements Exception {
  String message;
  AuthenticationException(this.message);
}

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  userIsLogaded() {
    return _auth.currentUser;
  }

  getUid() {
    return _auth.currentUser!.uid;
  }

  Future<UserModel> getUserInformation() async {
    UserModel user = UserModel(
      name: null,
      uid: null,
      cellphone: null,
      admin: null,
    );
    await firestore
        .collection("users")
        .doc(userIsLogaded().uid)
        .get()
        .then((event) {
      user = UserModel.fromJson(event.data()!);
    });
    return user;
  }

  login(BuildContext context, String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.toString(),
        password: password.toString(),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthenticationException('Usuário não encontrado.');
      }
      if (e.code == 'wrong-password') {
        throw AuthenticationException('Senha incorreta. Tente novamente');
      }
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => UserContainer(),
      ),
    );
  }

  register(
      String email, String senha, UserModel model, BuildContext context) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthenticationException('A senha é muito fraca!');
      } else if (e.code == 'email-already-in-use') {
        throw AuthenticationException('Este email já está cadastrado');
      }
    }
    print(userIsLogaded());
    firestore.collection('users').doc(userIsLogaded().uid).set({
      "name": model.name,
      "cellphone": model.cellphone,
      "admin": model.admin,
      "uid": userIsLogaded().uid,
    });
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const HomeView(),
      ),
    );
  }

  logout(BuildContext context) async {
    await _auth.signOut();
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/',
      (Route<dynamic> route) => false,
    );
  }

  getInformationUser() {
    return firestore
        .collection("users")
        .where("uid", isEqualTo: _auth.currentUser!.uid)
        .snapshots();
  }
}
