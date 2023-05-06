import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../models/job_model.dart';

class MyJobController extends GetxController {
  List<JobModel> myJobs=[];
  Rx<bool> isJobsLoaded=false.obs;
  @override
  void onInit() {
    getJobs();
    // TODO: implement onInit
    super.onInit();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getJobs() {
    return FirebaseFirestore.instance.collection('jobs').where('uid',isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots();

  }

  void deleteJob(int index) {
    FirebaseFirestore.instance.collection('jobs').doc(myJobs[index].uid).delete();
  }
}