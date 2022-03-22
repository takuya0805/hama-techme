import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tech_me/registrations/user_registration/user_registration_page.dart';

class UserRegistration extends ChangeNotifier {

  Future<void> addFirestoreUser(Map userInformation) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    // Call the user's CollectionReference to add a new user
    return users
        .add({
      'name': userInformation['name'],
      'mail_address': userInformation['mail_address'],
      'password': userInformation['password'],
      'age': userInformation['age'],
      'sex': userInformation['sex'],
      'invitation_code': userInformation['invitation_code'],
    })
        .then((value) => print("User Added $userInformation"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
