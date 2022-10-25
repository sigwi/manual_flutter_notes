import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';

class InputLoc extends StatefulWidget {
  InputLoc({required this.controller, required this.text});

  late TextEditingController controller = TextEditingController();
  late String text;

  @override
  State<InputLoc> createState() => _InputLocState();
}

class _InputLocState extends State<InputLoc> {
  Timer? _debounce;

  DetailsResult? position;

  FocusNode focusNode = FocusNode();

  GooglePlace googlePlace =
      GooglePlace('AIzaSyCpuxxqFQrsMohkLMa30tJAsc_59sQP-dg');

  //List tempat yg cocok
  List<AutocompletePrediction> predictions = [];

  autoCompleteSearh(String value) async {
    var result = await googlePlace.autocomplete.get(value);

    //predictions = list tempat yg cocok dari api, state mounted
    if (result != null && result.predictions != null && mounted) {
      print(result.predictions!.first.description);
      setState(() {
        predictions = result.predictions!;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          TextField(
            focusNode: focusNode,
            controller: widget.controller,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.deepPurple),
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: widget.text,
              hintStyle: TextStyle(color: Colors.grey),
              fillColor: Colors.white,
              filled: true,
              //menampilkan tanda silang di ujung kanan
              suffixIcon: widget.controller.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          predictions = [];
                          widget.controller.clear(); //menghilangkan text di x
                        });
                      },
                      icon: Icon(Icons.clear_outlined),
                    )
                  : null,
            ),
            onChanged: (value) {
              //jika debaounce aktif & mau ketik lagi, harus cancel
              if (_debounce?.isActive ?? false) _debounce!.cancel();
              _debounce = Timer(const Duration(milliseconds: 1000), () {
                if (value.isNotEmpty) {
                  autoCompleteSearh(value);
                } else {
                  predictions = [];
                  position = null;
                }
              });
            },
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: predictions.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  predictions[index].description.toString(),
                ),
                //memilih tempat
                onTap: () async {
                  final placeID = predictions[index].placeId!;
                  //detail dari placeID
                  final details = await googlePlace.details.get(placeID);
                  if (details != null && details.result != null && mounted) {
                    //detect which textfield is selected
                    if (focusNode.hasFocus) {
                      setState(() {
                        focusNode = details.result as FocusNode;
                        //only use the name without detail
                        widget.controller.text = details.result!.name!;
                        //utk menghilangkan list d bawah input setelah di click
                        predictions = [];
                      });
                    }
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
