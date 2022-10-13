import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CountryList extends StatefulWidget {
  const CountryList({super.key});

  @override
  State<CountryList> createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  late List<dynamic> dataDecode; //decode data from json file

  @override
  void initState() {
    super.initState();
    _getData();
  }

  List dataReady = [];

  Future<void> _getData() async {
    final String response =
        await rootBundle.loadString('assets/CountryCodes.json');
    dataDecode = await json.decode(response);

    setState(() {
      dataReady = dataDecode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[500],
        elevation: 5,
        title: Text('Select Country'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            //Display the data loaded from sample.json
            dataReady.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: dataReady.length,
                      itemBuilder: (context, index) {
                        return Card(
                          key: ValueKey(dataReady[index]["name"]),
                          margin: const EdgeInsets.all(3),
                          color: Colors.amber.shade100,
                          child: ListTile(
                            leading: Text(dataReady[index]["name"]),
                            // subtitle: Text(dataReady[index]["code"]),
                            // title: Text(dataReady[index]["name"]),
                            trailing: Text(dataReady[index]["dial_code"]),
                          ),
                        );
                      },
                    ),
                  )
                : Center(
                    child: Text('Loading...'),
                  )
          ],
        ),
      ),
    );
  }
}
