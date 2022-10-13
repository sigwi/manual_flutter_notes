
  List<dynamic>? dataDecode; //decode data from json file
  List<dynamic>? dataReady; //data to deploy on the screen

  @override
  void initState() {
    super.initState();
    _getData();
  }

  List<dynamic> docIDs = [];

  _getData() async {
    final String response =
        await rootBundle.loadString('assets/CountryCodes.json');
    dataDecode = await json.decode(response) as List<dynamic>;

    setState(() {
      dataReady = dataDecode;
    });
  }
