import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:softech_hustlers/models/job_model.dart';
import 'package:softech_hustlers/services/user_service.dart';
import 'package:softech_hustlers/style/app_sizes.dart';
import 'package:softech_hustlers/ui/userhome/user_home_shimmer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../enum/job_status.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('jobs').where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>>  snapshot){
            // if(snapshot.connectionState==ConnectionState.waiting || !(snapshot.hasData)){
            if(snapshot.connectionState==ConnectionState.waiting || !(snapshot.hasData)){
              return const UserHomeShimmer();
            }
            
            List<JobModel> jobsList = snapshot.data!.docs.map((e) => JobModel.fromJson(e.data())).toList();

            double totalSpent = jobsList.fold(0, (previousValue, element) =>
            element.status == JobStatus.completed.name ?
            previousValue+element.price : previousValue
            );
            
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: kpHorizontalPadding),
              width: 1.sw,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    30.verticalSpace,
                    Text(
                      "Hello, ${UserService.userModel.userName}",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp),
                    ),
                    5.verticalSpace,
                    Text(
                      "Welcome back!",
                      style: TextStyle(color: Colors.grey, fontSize: 15.sp),
                    ),
                    20.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildInfoContainer(context,
                            title: "\$$totalSpent",
                            subtitle: "Total Spent",
                            icon: Icons.price_change_outlined),
                        buildInfoContainer(context,
                            title: jobsList.length.toString(),
                            subtitle: "Total Booking",
                            icon: Icons.request_page_outlined),
                      ],
                    ),
                    20.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildInfoContainer(context,
                            title: jobsList.where((element) => element.status==JobStatus.inProgress.name).length.toString(),
                            subtitle: "Jobs in Progress",
                            icon: Icons.task),
                        buildInfoContainer(context,
                            title: jobsList.where((element) => element.status==JobStatus.completed.name).length.toString(),
                            subtitle: "Jobs Completed",
                            icon: Icons.request_page_outlined),
                        // SizedBox(
                        //   width: 0.42.sw,
                        // )
                      ],
                    ),
                    20.verticalSpace,
                    _buildChart(jobsList),
                    10.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Reviews",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "View all",
                          style: TextStyle(color: Colors.grey, fontSize: 15.sp),
                        )
                      ],
                    ),
                    10.verticalSpace,
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.all(15.h),
                            margin: EdgeInsets.only(bottom: 10),
                            width: 1.sw,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10.sp)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 60.h,
                                  width: 60.h,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: Image.network(
                                                  "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg")
                                              .image)),
                                ),
                                10.horizontalSpace,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Demo User',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.h,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '28 Apr',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12.sp),
                                    ),
                                    8.verticalSpace,
                                    Text(
                                      'Service: House Hold',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.h,
                                      ),
                                    ),
                                    Text(
                                      'Good Service',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12.sp),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Icon(
                                  Icons.star,
                                  color: Theme.of(context).primaryColor,
                                  size: 20,
                                ),
                                Text(
                                  "5.0",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Theme.of(context).primaryColor),
                                )
                              ],
                            ),
                          );
                        })
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }

  Container buildInfoContainer(BuildContext context,
      {required String title,
      required String subtitle,
      required IconData icon}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.h),
      width: 0.44.sw,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(15.w)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp),
              ),
              Container(
                decoration:
                    BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                height: 40.h,
                width: 40.h,
                child: Icon(
                  icon,
                  color: Theme.of(context).primaryColor,
                ),
              )
            ],
          ),
          10.verticalSpace,
          Text(
            subtitle,
            style: TextStyle(color: Colors.white, fontSize: 18.sp),
          )
        ],
      ),
    );
  }

 Widget _buildChart(List<JobModel> jobsList){
    return    SfCartesianChart(

      // Initialize category axis
        primaryXAxis: CategoryAxis(),
        palette: [
          Theme.of(context).primaryColor
        ],
        series: <LineSeries<SalesData, String>>[
          LineSeries<SalesData, String>(
            // Bind data source
              dataSource: <SalesData>[

                SalesData('Jan', getTotalSpentByMonth(1, jobsList).toInt()),
                SalesData('Feb', getTotalSpentByMonth(2, jobsList).toInt()),
                SalesData('Mar', getTotalSpentByMonth(3, jobsList).toInt()),
                SalesData('Apr', getTotalSpentByMonth(4, jobsList).toInt()),
                SalesData('May', getTotalSpentByMonth(5, jobsList).toInt()),
              ],
              xValueMapper: (SalesData sales, _) => sales.year,
              yValueMapper: (SalesData sales, _) => sales.sales)
        ]);

  }

 double getTotalSpentByMonth(int monthNo, List<JobModel> jobsList){
    double x = jobsList.fold(0.0, (previousValue, element){

      // print('elemen')

      if(element.date.month==monthNo){
        return previousValue + element.price;
      }
      return previousValue;
    });

    print('sum for month $monthNo is $x');
    return x;
 }
}

class SalesData {
  final String year;
  final int sales;
  SalesData(this.year, this.sales);
}
