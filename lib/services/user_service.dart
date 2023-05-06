import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:softech_hustlers/models/user_model.dart';

class UserService {
  static late UserModel userModel;

 static Future<void> initialize() async{
  DocumentSnapshot<Map<String,dynamic>> documentSnapshot =  await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
  userModel = UserModel.fromMap(documentSnapshot.data()!);
  }
}