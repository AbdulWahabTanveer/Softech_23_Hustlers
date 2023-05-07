import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:softech_hustlers/global_widgets/custom_shimmer_container_border.dart';
import 'package:softech_hustlers/ui/userhome/userhome.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../global_widgets/custom_shimmer.dart';
import '../../style/app_sizes.dart';

class UserHomeShimmer extends StatelessWidget {
  const UserHomeShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding:  const EdgeInsets.symmetric(horizontal: kpHorizontalPadding),
        width: 1.sw,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            30.verticalSpace,
            CustomShimmer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomShimmerBorderedContainer(
                    child: Text(
                      "Hello, UserName",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp),
                    ),
                  ),
                  5.verticalSpace,
                  CustomShimmerBorderedContainer(
                    child: Text(
                      "Welcome back!",
                      style: TextStyle(color: Colors.grey, fontSize: 15.sp),
                    ),
                  ),
                ],
              ),
            ),
            20.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildInfoContainer(context,
                    title: "\$100",
                    subtitle: "Total Spent",
                    icon: Icons.price_change_outlined),
                buildInfoContainer(context,
                    title: '100',
                    subtitle: "Total Booking",
                    icon: Icons.request_page_outlined),
              ],
            ),
            20.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildInfoContainer(context,
                    title: '100'.toString(),
                    subtitle: "Jobs in Progress",
                    icon: Icons.task),
                buildInfoContainer(context,
                    title: 100.toString(),
                    subtitle: "Jobs Completed",
                    icon: Icons.request_page_outlined),
                // SizedBox(
                //   width: 0.42.sw,
                // )
              ],
            ),
            20.verticalSpace,
            _buildChart(context),
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
          ],
        ),
      ),
    );
  }

  Widget buildInfoContainer(BuildContext context,
      {required String title,
        required String subtitle,
        required IconData icon}) {
    BoxShadow boxShadow =   BoxShadow(
      color: const Color(0XFF2C406E).withOpacity(0.10),
      spreadRadius: 0,
      blurRadius: 9,
      offset: const Offset(3, 3),
    );

    return Material(
      elevation: 2,
      child: Container(

        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.h),
        width: 0.44.sw,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [boxShadow],
        ),

        // decoration: BoxDecoration(
        //     color: Theme.of(context).primaryColor,
        //     borderRadius: BorderRadius.circular(15.w)),
        child: CustomShimmer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomShimmerBorderedContainer(
                    child: Text(
                      title,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp),
                    ),
                  ),
                  Container(
                    decoration:
                    const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
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
              CustomShimmerBorderedContainer(
                child: Text(
                  subtitle,
                  style: TextStyle(color: Colors.white, fontSize: 18.sp),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChart(BuildContext context){
    return    CustomShimmer(
      child: Container(
        color: Colors.white,
        child: SfCartesianChart(

          // Initialize category axis
            primaryXAxis: CategoryAxis(),
            palette: [
              Theme.of(context).primaryColor
            ],
            series: <LineSeries<SalesData, String>>[
              LineSeries<SalesData, String>(
                // Bind data source
                  dataSource: <SalesData>[

                    SalesData('Jan', 1),
                    SalesData('Feb', 2),
                    SalesData('Mar', 3),
                    SalesData('Apr', 4),
                    SalesData('May', 5),
                  ],
                  xValueMapper: (SalesData sales, _) => sales.year,
                  yValueMapper: (SalesData sales, _) => sales.sales)
            ]),
      ),
    );

  }


}
