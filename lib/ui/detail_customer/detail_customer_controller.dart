import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:softech_hustlers/models/review_model.dart';

import '../../services/user_service.dart';

class DetailCustomerController extends GetxController {
  double ratingBar = 0.0;

  var review = TextEditingController();

  uploadReview(String id) {
    ReviewModel reviewModel = ReviewModel(
      review: review.text,
      rating: ratingBar, name: UserService.userModel.userName,
    );
    FirebaseFirestore.instance.collection('users').doc(id).update({"reviews":FieldValue.arrayUnion([reviewModel.toJson()])});
  }
}