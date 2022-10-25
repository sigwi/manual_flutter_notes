import 'package:flutter/material.dart';
import 'package:mangga/components/input_loc.dart';
import 'package:provider/provider.dart';

import '../model/update_address.dart';

class SearchScreen extends StatefulWidget {
  static const String id = 'search_screen';
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _pickLoc = TextEditingController();
  final TextEditingController _dropLoc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String pickAddress =
        Provider.of<UpdateAddress>(context).pickUpLocation?.placeName ??
            "Karangmalang";
    _pickLoc.text = pickAddress;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: const Text('Manage Location'),
      ),
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              height: 135,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5,
                    spreadRadius: 0.5,
                    offset: Offset(0.5, 0.5),
                  )
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  InputLoc(
                    controller: _pickLoc,
                    text: 'Pick Up Location',
                  ),
                  const SizedBox(height: 10),
                  InputLoc(
                    controller: _dropLoc,
                    text: 'Drop Location',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
