import 'dart:async';

import 'package:driver/component/card_text.dart';
import 'package:driver/component/konstan.dart';
import 'package:driver/screen/map_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Jobs extends StatefulWidget {
  static const String id = 'jobs';
  const Jobs({super.key});

  @override
  State<Jobs> createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  Box? box;

  DatabaseReference rideRequestRef =
      FirebaseDatabase.instance.ref().child('ride request');

  List requestsList = [];

  Map requestsMap = {};

  List requestsListVal = [];

  @override
  void initState() {
    box = Hive.box('Box');
    readRequest();
    super.initState();
  }

  readRequest() async {
    requestsList.clear();
    requestsMap.clear();
    requestsListVal.clear();

    Stream<DatabaseEvent> stream = rideRequestRef.onValue;

    stream.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      setState(() {
        requestsList.add(data);
      });
      for (var element in requestsList) {
        requestsMap.addAll(element);
      }
      requestsMap.forEach((key, value) {
        requestsListVal.add(value);
      });
    });
  }

  void ambil(int index) async {
    //----persiapan buat firestore----

    //----persiapan buat firestore----
    //harus pakai if riderequest !=null untuk menghindari dobel
    User? firebaseUser = FirebaseAuth.instance.currentUser;

    DatabaseReference driverRef = FirebaseDatabase.instance
        .ref()
        .child('drivers')
        .child(firebaseUser!.uid);
    DatabaseEvent driverPhone = await driverRef.child('phone').once();
    DatabaseEvent driverName = await driverRef.child('name').once();

    DatabaseReference ongoingRef = FirebaseDatabase.instance.ref().child(
        'ongoing ride/${requestsListVal[index]['rider_id']}/${firebaseUser.uid}');

    await ongoingRef.set({
      'driver_id': firebaseUser.uid,
      'driver_name': driverName.snapshot.value,
      'driver_phone': driverPhone.snapshot.value,
      'pickup': requestsListVal[index]['pickup'],
      'dropoff': requestsListVal[index]['dropoff'],
      'created_at': DateTime.now().toString(),
      'rider_id': requestsListVal[index]['rider_id'],
      'rider_name': requestsListVal[index]['rider_name'],
      'rider_phone': requestsListVal[index]['rider_phone'],
      'pickup_address': requestsListVal[index]['pickup_address'],
      'dropoff_adress': requestsListVal[index]['dropoff_adress'],
      'tipe_truk': requestsListVal[index]['tipe_truk'],
      'weight': requestsListVal[index]['berat'],
      'vol': requestsListVal[index]['vol'],
      'cargo': requestsListVal[index]['cargo'],
      'price': requestsListVal[index]['ongkos'],
    });

    Map forBox = ({
      'riderID': requestsListVal[index]['rider_id'],
      'startLat': requestsListVal[index]['pickup']['latitude'],
      'startLng': requestsListVal[index]['pickup']['longitude'],
      'finishLat': requestsListVal[index]['dropoff']['latitude'],
      'finishLng': requestsListVal[index]['dropoff']['longitude'],
      'rider_name': requestsListVal[index]['rider_name'],
      'rider_phone': requestsListVal[index]['rider_phone'],
      'pickup_address': requestsListVal[index]['pickup_address'],
      'dropoff_adress': requestsListVal[index]['dropoff_adress'],
      'weight': requestsListVal[index]['berat'],
      'vol': requestsListVal[index]['vol'],
      'cargo': requestsListVal[index]['cargo'],
      'price': requestsListVal[index]['ongkos'],
    });
    box!.putAll(forBox);
    if (!mounted) return;
    Navigator.pushNamed(context, MapScreen.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kUngu,
        // leading: const CloseButton(color: Colors.black),
        title: const Text(
          'Pilih Job',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: ListView.builder(
          padding: const EdgeInsets.all(0),
          itemBuilder: (context, index) {
            return JobList(
              harga: requestsListVal[index]['ongkos'],
              nama: requestsListVal[index]['rider_name'],
              dari: requestsListVal[index]['pickup_address'],
              tujuan: requestsListVal[index]['dropoff_adress'],
              tipe: requestsListVal[index]['tipe_truk'],
              weight: requestsListVal[index]['berat'],
              vol: requestsListVal[index]['vol'],
              cargo: requestsListVal[index]['cargo'],
              ambil: () => ambil(index),
            );
          },
          itemCount: requestsListVal.length,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
        ),
      ),
    );
  }
}

class JobList extends StatelessWidget {
  const JobList(
      {super.key,
      required this.harga,
      required this.nama,
      required this.dari,
      required this.tujuan,
      required this.tipe,
      required this.weight,
      required this.vol,
      required this.cargo,
      required this.ambil});
  final String harga;
  final String nama;
  final String dari;
  final String tujuan;
  final String tipe;
  final String weight;
  final String vol;
  final String cargo;
  final VoidCallback ambil;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.grey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Text(
              'Rp. $harga',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ),
          CardText(headr: 'Name ', isi: ': $nama'),
          CardText(headr: 'From ', isi: ': $dari'),
          CardText(headr: 'To ', isi: ': $tujuan'),
          CardText(headr: 'Truck Type ', isi: ': $tipe'),
          CardText(headr: 'Berat ', isi: ': $weight Tons'),
          CardText(headr: 'Volume ', isi: ': $vol Meter Cubic'),
          CardText(headr: 'Cargo ', isi: ': $cargo'),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton.icon(
                    onPressed: ambil,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        // width: 3,
                        color: Colors.pinkAccent,
                        // style: BorderStyle.solid,
                      ),
                      foregroundColor: Colors.grey,
                      padding: const EdgeInsets.all(15),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                    label: const Text('Take Job'),
                    icon: const Icon(
                      Icons.check,
                      color: Colors.greenAccent,
                      size: 15,
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: OutlinedButton.icon(
                //     label: const Text('Chat'),
                //     icon: const Icon(
                //       Icons.message_outlined,
                //       color: Colors.greenAccent,
                //       size: 15,
                //     ),
                //     style: OutlinedButton.styleFrom(
                //       foregroundColor: Colors.grey,
                //       padding: const EdgeInsets.all(15),
                //       shape: const RoundedRectangleBorder(
                //         borderRadius: BorderRadius.all(
                //           Radius.circular(20),
                //         ),
                //       ),
                //     ),
                //     onPressed: () {/* ... */},
                //   ),
                // ),
              ],
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
