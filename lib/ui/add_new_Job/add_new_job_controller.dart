import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';

class AddNewJobController extends GetxController{
  var jobTitle=TextEditingController();
  var jobDescription=TextEditingController();
  var price=TextEditingController();

  RxList<XFile?> jobImages=RxList<XFile?>([]);

  Future<void> pickImage() async {
    var image=await ImagePicker.platform.getImage(source: ImageSource.gallery);
    if(image!=null){
      jobImages.add(image);
    }
  }


}