import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:softech_hustlers/models/bid_model.dart';
import 'package:softech_hustlers/models/user_model.dart';

import '../style/app_sizes.dart';

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

            print('handymen ids fetched');


            List<Map<String,dynamic>> bidMaps = event.docs.map((e) {
             Map<String,dynamic> map = e.data();
             map['id'] = e.id;
             return map;
           }).toList();

           for (var element in bidMaps) {
             element['handyman'] = userMaps.firstWhere((userElement) => userElement['id'] == element['handymanId']);
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
            List<Bid> bids = snapshot.data!.map((e) => Bid.fromMap(e)).toList();

            for (var element in snapshot.data!) {
              handyMenMap[element['id']] = UserModel.fromMap(element['handyman']);
            }

            return ListView.builder(               
              itemCount: bids.length,
                itemBuilder: (context,index){
                  return _buildListTile(bids[index],handyMenMap[bids[index].id]!,context);
                });
            
          }
      ),
    );
  }

  Widget _buildListTile(Bid bid, UserModel handyMan, BuildContext context){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kpHorizontalPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.2)
      ),
      child: Row(),
    );
  }

}
