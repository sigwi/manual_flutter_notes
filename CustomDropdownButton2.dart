List<String> jenisTrukList = <String>[
    'Tronton',
    'Engkel',
    'Trailer',
    'Container',
  ];

String? jenisTrukValue;

CustomDropdownButton2(
  buttonWidth: double.infinity,
  dropdownWidth: double.infinity,
  hint: 'Jenis Truk',
  dropdownItems: jenisTrukList,
  value: jenisTrukValue,
  onChanged: (value) {
    setState(() {
      jenisTrukValue = value;
    });
  },
),

