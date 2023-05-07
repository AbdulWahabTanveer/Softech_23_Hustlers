import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:softech_hustlers/enum/app_mode.dart';
import 'package:softech_hustlers/models/bid_model.dart';
import 'package:softech_hustlers/models/job_model.dart';
import 'package:softech_hustlers/models/user_model.dart';

import '../../style/app_sizes.dart';
import '../../utils/common_image_view.dart';

class UserViewBidScreen extends StatelessWidget {
  const UserViewBidScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Bids'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('bids')
              // .where('customerId',isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots().
          asyncMap((event) async{

            print('into async map');

            print("docs length: ${event.docs.length}");

            List<String> handyManIds = event.docs.map((QueryDocumentSnapshot<Map<String,dynamic>> e) => ((e.data())['handymanId']).toString()).toSet().toList();
            print('handymen ids length: ${handyManIds.length}');
            List<Map<String,dynamic>> userMaps = [];
            if(handyManIds.isNotEmpty) {
              userMaps =  (await FirebaseFirestore.instance.collection('users').where(FieldPath.documentId,whereIn: handyManIds ).get()).docs.map((e){
             Map<String,dynamic> userMap = e.data();
             userMap['id'] = e.id;
             return userMap;
           }).toList();
            }

            List<String> jobIds = event.docs.map((QueryDocumentSnapshot<Map<String,dynamic>> e) => ((e.data())['jobId']).toString()).toSet().toList();
            print('job ids length: ${jobIds.length}');
            List<Map<String,dynamic>> jobMaps = [];
            if(jobIds.isNotEmpty) {
              jobMaps =  (await FirebaseFirestore.instance.collection('jobs').where('id',whereIn: jobIds ).get()).docs.map((e){
                Map<String,dynamic> userMap = e.data();
                return userMap;
              }).toList();
            }

            print('jobs ids fetched');



            List<Map<String,dynamic>> bidMaps = event.docs.map((e) {
             Map<String,dynamic> map = e.data();
             map['id'] = e.id;
             return map;
           }).toList();

           for (var element in bidMaps) {
             element['handyman'] = userMaps.firstWhere((userElement) => userElement['id'] == element['handymanId']);
             element['job'] = jobMaps.firstWhere((userElement) => userElement['id'] == element['jobId']);
           }

           return bidMaps;
          }),
          builder: (context,AsyncSnapshot<List<Map<String,dynamic>>> snapshot){
            if(snapshot.connectionState==ConnectionState.waiting || !(snapshot.hasData)){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            Map<String,UserModel> handyMenMap = {};
            Map<String,JobModel> jobsMap = {};
            List<Bid> bids = snapshot.data!.map((e) => Bid.fromMap(e)).toList();


            for (var element in snapshot.data!) {
              handyMenMap[element['id']] = UserModel.fromMap(element['handyman']);
              jobsMap[element['id']] = JobModel.fromJson(element['job']);
            }

            return ListView.builder(               
              itemCount: bids.length,
                itemBuilder: (context,index){
                  return ViewUserBidTile(bid: bids[index],handyMan:handyMenMap[bids[index].id]!,job: jobsMap[bids[index].id]!);
                });
          }
      ),
    );
  }

}

class ViewUserBidTile extends StatefulWidget {
  const ViewUserBidTile({Key? key, required this.bid, required this.handyMan, required this.job}) : super(key: key);
  final Bid bid;
  final UserModel handyMan;
  final JobModel job;

  @override
  State<ViewUserBidTile> createState() => _ViewUserBidTileState();
}

class _ViewUserBidTileState extends State<ViewUserBidTile> {

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return _buildListTile(widget.bid, widget.handyMan, context, widget.job);
  }

  Widget _buildListTile(Bid bid, UserModel handyMan, BuildContext context,JobModel job){

    if(bid.accepted || bid.rejected){
      return const SizedBox();
    }
    if(job.handymanId!=null){
      return const SizedBox();
    }

    return Container(
      padding: EdgeInsets.all(15.h),
      margin: EdgeInsets.only(top: 12.h),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .primaryColor
            .withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CommonImageView(
              height: 60.h,
              width: 60.h,
              url: job.images[0],
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 12.w),
            child: Column(
              mainAxisAlignment:
              MainAxisAlignment.start,
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  job.title,
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700),
                ),
                5.verticalSpace,
                Text(
                  "\$${bid.amount}",
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600),
                ),
                10.verticalSpace,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 50.w,
                      child: Text(
                        handyMan.userName,
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            overflow: TextOverflow.ellipsis

                        ),
                      ),
                    ),
                    10.horizontalSpace,
                    RatingBarWidget(onRatingChanged: (v){}, disable: true,size: 15,rating: (handyMan.reviewModel.fold(0.0, (previousValue, element) => previousValue + element.rating))/5, spacing: 1,),
                  ],
                ),
                // 5.verticalSpace,

              ],
            ),
          ),
          Spacer(),
          Column(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              acceptReject(bid, job, handyMan),
            ],
          ),
        ],
      ),
    );
  }

  Widget acceptReject(Bid bid,JobModel jobModel, UserModel handyman){
    return
      loading ? const CircularProgressIndicator() :
      Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildApproveRejectCircleIcon(Icons.check, Colors.green.withOpacity(0.75), () async {

          setState(() {
            loading = true;
          });

          await  FirebaseFirestore.instance.collection('bids').doc(bid.id).update({
            'accept' : true,
            'reject' : false
          });

          await FirebaseFirestore.instance.collection('jobs').doc(jobModel.id).update({
            'handymanId': handyman.id
          });
          setState(() {
            loading = false;
          });


          Get.snackbar("Success", "${handyman.userName} hired for ${jobModel.title}",backgroundColor: Colors.green.withOpacity(0.2),colorText: Colors.white);

        }),
        10.horizontalSpace,
        _buildApproveRejectCircleIcon(Icons.close, Colors.red.withOpacity(0.75), () async{
          await FirebaseFirestore.instance.collection('bids').doc(bid.id).update({
            'accept' : false,
            'reject' : true
          });

        })
      ],
    );
  }

  _buildApproveRejectCircleIcon(IconData icon,Color color, void Function() onTap){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(5.r),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,

        ),
        child: Icon(icon, color: Colors.white,),
      ),
    );
  }
}

