        Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: kA,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.popAndPushNamed(context, MapScreen.id);
                  },
                  child: SizedBox(
                    width: 200,
                    height: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.place,
                            size: 20,
                            color: Colors.red,
                          ),
                        ),
                        Container(width: 2, color: Colors.white),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: const [
                              Text(
                                'Cari Driver',
                                style: TextStyle(color: kD, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
