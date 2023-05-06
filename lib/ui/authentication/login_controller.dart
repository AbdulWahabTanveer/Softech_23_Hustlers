import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:softech_hustlers/utils/global.dart';

class SignInController extends GetxController{
  TextEditingController loginEmailCont = TextEditingController();
  TextEditingController loginPassCont = TextEditingController();
  Rx<bool> loading = false.obs;

 String? emailValidation(String? v){
   if(v==null || v.isEmpty){
     return "Email is required";
   }

   if(!isEmailValid(v)){
     return "Invalid Email";
   }

   return null;
 }

 Future<void> signIn(String email, String password) async{
   FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

 }

}