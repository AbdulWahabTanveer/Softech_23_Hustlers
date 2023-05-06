import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softech_hustlers/ui/authentication/sign_up/sign_up_screen.dart';
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


  String? passValidation(String? v){
    if(v==null || v.isEmpty){
      return "Password is required";
    }

    return null;
  }




  Future<void> signIn(String email, String password) async{
   loading.value=true;
   try{
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (FirebaseAuth.instance.currentUser != null) {
        Get.snackbar("Success", "Signing in",
            backgroundColor: Colors.green, colorText: Colors.white);
        Get.to(() => SignUpScreen());
      }
    }
   on FirebaseAuthException catch (e){
     Get.snackbar("Request Failed", e.code.replaceAll('-', ' '), backgroundColor: Colors.red,colorText: Colors.white);
     // rethrow;
   }

   catch (e){
      Get.snackbar("Request Failed", e.toString(), backgroundColor: Colors.red,colorText: Colors.white);
      // print(e);
     // rethrow;
    }
    loading.value = false;
 }

}