import 'package:driver/component/cool_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class TestDrive extends StatefulWidget {
  static const String id = 'test';
  const TestDrive({super.key});

  @override
  State<TestDrive> createState() => _TestDriveState();
}

class _TestDriveState extends State<TestDrive> {
  DatabaseReference rideRequestRef =
      FirebaseDatabase.instance.ref().child('ride request');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: rideRequestRef.onValue,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            // final map = Map<dynamic, dynamic>.from(
            //     (snapshot.data! as DatabaseEvent).snapshot.value
            //         as Map<dynamic, dynamic>);
            DatabaseEvent event = snapshot.data!;
            DataSnapshot snap = event.snapshot;
            Map<dynamic, dynamic> map = snap.value as Map<dynamic, dynamic>;
            List list = [];
            if (snapshot.hasData && !snapshot.hasError && map.isNotEmpty) {
              map.forEach(
                (key, value) {
                  list.add(value);
                },
              );
            }
            print(map);
            return Column();

            // return ListView.builder(
            //   itemCount: list.length,
            //   itemBuilder: (context, index) {
            //     return Card(
            //       child: Column(
            //         children: [
            //           CoolText(headr: 'headr', isi: list[index]['rider_name'])
            //         ],
            //       ),
            //     );
            //   },
            // );
          },
        ),
      ),
    );
  }
}
