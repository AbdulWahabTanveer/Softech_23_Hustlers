import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softech_hustlers/enum/account_type.dart';
import 'package:softech_hustlers/models/user_model.dart';
import 'package:softech_hustlers/ui/authentication/login/login_screen.dart';
import 'package:softech_hustlers/utils/global.dart';

class SignUpController extends GetxController{
  TextEditingController loginEmailCont = TextEditingController();
  TextEditingController loginPassCont = TextEditingController();
  TextEditingController nameCont = TextEditingController();
  Rx<String> selectedRole = ''.obs;




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

  String? nameValidation(String? v){
    if(v==null || v.isEmpty){
      return "Name is required";
    }
    return null;
  }

  String? accountTypeValidation(String? v){
    if(v==null || v.isEmpty){
      return "Please Select Account Type";
    }
    return null;
  }


  String? passValidation(String? v){
    if(v==null || v.isEmpty){
      return "Password is required";
    }

    if(v.length<6){
      return "Password length can't be less then 6";
    }

    return null;
  }



  Future<void> signUp(String email, String password) async{
  loading.value = true;

  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModel userModel = UserModel(
          userName: nameCont.text,
          accountType: selectedRole.value.toLowerCase() == 'handyman'
              ? AccountType.handyman
              : AccountType.customer,
          email: email,
        emailVerified: false,
      );
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();



      await Future.wait([
        FirebaseAuth.instance.currentUser!.updateDisplayName(nameCont.text),
        FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(userModel.toMap()),
      ]);

      await FirebaseAuth.instance.signOut();

    Get.to(()=>LoginScreen());
    Get.snackbar("Success", 'Verification Link sent to Email', backgroundColor: Colors.green,colorText: Colors.white);

  }
    on FirebaseAuthException catch (e){
      Get.snackbar("Request Failed", e.code, backgroundColor: Colors.red,colorText: Colors.white);
      // rethrow;
    }
    catch (e){
      Get.snackbar("Request Failed", e.toString(), backgroundColor: Colors.red,colorText: Colors.white);
      // rethrow;
    }

    loading.value = false;
  }

}