main() async {
  var res = {
    "predictions": [
      {
        "description": "Paris, France",
        "matched_substrings": [
          {"length": 5, "offset": 0}
        ],
        "place_id": "ChIJD7fiBh9u5kcRYJSMaMOCCwQ",
        "reference": "ChIJD7fiBh9u5kcRYJSMaMOCCwQ",
        "structured_formatting": {
          "main_text": "Paris",
          "main_text_matched_substrings": [
            {"length": 5, "offset": 0}
          ],
          "secondary_text": "France",
        },
        "terms": [
          {"offset": 0, "value": "Paris"},
          {"offset": 7, "value": "France"},
        ],
        "types": ["locality", "political", "geocode"],
      },
      {
        "description": "Paris, TX, USA",
        "matched_substrings": [
          {"length": 5, "offset": 0}
        ],
        "place_id": "ChIJmysnFgZYSoYRSfPTL2YJuck",
        "reference": "ChIJmysnFgZYSoYRSfPTL2YJuck",
        "structured_formatting": {
          "main_text": "Paris",
          "main_text_matched_substrings": [
            {"length": 5, "offset": 0}
          ],
          "secondary_text": "TX, USA",
        },
        "terms": [
          {"offset": 0, "value": "Paris"},
          {"offset": 7, "value": "TX"},
          {"offset": 11, "value": "USA"},
        ],
        "types": ["locality", "political", "geocode"],
      },
    ],
    "status": "OK",
  };

  var predictions = res['predictions'];
  
  //pakai forEach juga bisa
  (predictions as List).map((e) {
    var x = PlacePrediction.fromJson(e);
  }).toList();
}

class PlacePrediction {
  late String secondary_text;
  late String main_text;
  late String place_id;

  PlacePrediction({
    required this.secondary_text,
    required this.main_text,
    required this.place_id,
  });

  PlacePrediction.fromJson(Map<String, dynamic> json) {
    place_id = json['place_id'];
    main_text = json['structured_formatting']['main_text'];
    secondary_text = json['structured_formatting']['secondary_text'];
    print(place_id);
    print(main_text);
    print(secondary_text);
  }
}
