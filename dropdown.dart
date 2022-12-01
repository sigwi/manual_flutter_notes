import 'package:flutter/material.dart';
import 'package:mangga/constant.dart';

//----dihalaman satunya----
const List<String> jenisTrukList = <String>[
  'Tronton',
  'Engkel',
  'Trailer',
  'Container',
];
jenisTrukValue = jenisTrukList.first;
DropDownInput(val: jenisTrukValue, text: 'Jenis Truk', list: jenisTrukList,),
//----dihalaman satunya----

class DropDownInput extends StatefulWidget {
  DropDownInput({required this.val, required this.text, required this.list});

  String val;
  String text;
  List<String> list;

  @override
  State<DropDownInput> createState() => _DropDownInputState();
}

class _DropDownInputState extends State<DropDownInput> {
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListTile(
        title: Text(
          widget.text,
          style: TextStyle(
            fontSize: 17,
            color: Colors.grey,
          ),
        ),
        subtitle: DropdownButton<String>(
          value: widget.val,
          underline: Container(
            height: 1,
            color: EdgeInsets.symmetric(horizontal: 15),
          ),
          isExpanded: true,
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              widget.val = value!;
            });
          },
          items: widget.list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
