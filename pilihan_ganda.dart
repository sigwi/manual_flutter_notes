import 'package:flutter/material.dart';
import 'package:mangga/components/elev_button.dart';
import 'package:mangga/constant.dart';

import '../components/profile_drawer.dart';

const List<String> jenisTrukList = <String>[
  'Tronton',
  'Engkel',
  'Trailer',
];
List<String> pjgBakList = <String>['isi 1', 'isi 2'];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? _selectedIndex;

  int? tag;

  _onSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _onSelList(int index) {
    if (index == 0) {
      setState(() {
        pjgBakList = [
          '1-3 meter (3-12 ft)',
          '4-7 meter (3-12 ft)',
          '8-12 meter (3-12 ft)',
        ];
      });
    } else if (index == 1) {
      setState(() {
        pjgBakList = [
          'coba 1',
          'coba 2',
        ];
      });
    } else {
      setState(() {
        pjgBakList = [
          'try 1',
          'try 2',
        ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kUngu,
        title: const Text('Luru App'),
      ),
      drawer: Container(
        color: Colors.white,
        width: 250,
        child: const ProfileDrawer(),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              color: Colors.white,
              shadowColor: Colors.black,
              elevation: 5,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'Order Truck',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Text(
                    'Tipe',
                    style: kTitleStyle,
                  ),
                  kDivider,
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: jenisTrukList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: kSymHor,
                        child: ListTile(
                          tileColor:
                              _selectedIndex != null && _selectedIndex == index
                                  ? Colors.cyanAccent[100]
                                  : null,
                          leading: const CircleAvatar(
                              backgroundColor: Colors.purple),
                          title: Text(jenisTrukList[index]),
                          onTap: () {
                            _onSelected(index);
                            _onSelList(index);
                          },
                        ),
                      );
                    },
                  ),
                  const Text('Panjang', style: kTitleStyle),
                  kDivider,
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: pjgBakList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: kSymHor,
                        child: RadioListTile(
                          value: index,
                          groupValue: tag,
                          onChanged: (val) {
                            setState(() {
                              tag = val;
                            });
                          },
                          title: Text(pjgBakList[index]),
                        ),
                      );
                    },
                  ),
                  const ElevButt(text: 'Next', ikon: Icons.arrow_forward_ios),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
