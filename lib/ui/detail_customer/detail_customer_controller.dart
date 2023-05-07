import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:softech_hustlers/models/review_model.dart';

import '../../services/user_service.dart';

class DetailCustomerController extends GetxController {
  double ratingBar = 0.0;

  var review = TextEditingController();

  uploadReview() {
    ReviewModel reviewModel = ReviewModel(
      review: review.text,
      rating: ratingBar, name: UserService.userModel.userName,
    );
  }
}