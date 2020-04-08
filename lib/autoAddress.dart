import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_webservice/places.dart';

const kGoogleApiKey = "AIzaSyDVQnFGqc6NqY5jsBQzGQ1NDLeT8Rh1VCA";
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class AutoAddress extends StatefulWidget {
  @override
  _AutoAddressState createState() => _AutoAddressState();
}

class _AutoAddressState extends State<AutoAddress> {
  double latitude, longitude;
  String searchText = 'Search a Place';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Address Auto Complete'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          InkWell(
            onTap: () => _handlePressButton(),
            child: Container(
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey[400],
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('  '),
                  Expanded(
                      child: Text(
                    searchText,
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                    softWrap: false,
                    style: TextStyle(color: Colors.grey),
                  )),
                  InkWell(
                    child: Icon(
                      Icons.location_on,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          ),
          Text('Lattitude'),
          Text('$latitude'),
          Text('Longitude'),
          Text('$longitude')
        ],
      ),
    );
  }

  Future<void> _handlePressButton() async {
    try {
      Prediction p = await PlacesAutocomplete.show(
          context: context,
          apiKey: kGoogleApiKey,
          mode: Mode.overlay,
          components: [Component(Component.country, 'uk')]);
      print('this is what we got -----------------------' + p.description);
      displayPrediction(p);
      setState(() {});
    } catch (e) {
      print(e.toString());
      return;
    }
  }

  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      var detail =
          await _places.getDetailsByPlaceId(p.placeId);
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;
      await Geocoder.local.findAddressesFromQuery(p.description);
      setState(() {
        searchText = p.description;
      });
      print('this is what we got -----------------------' + p.description);
      latitude = lat;
      longitude = lng;

      print(lat);
      print(lng);
    }
  }
}
