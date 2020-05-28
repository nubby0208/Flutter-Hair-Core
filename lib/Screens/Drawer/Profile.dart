import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:hair_cos/Constants/color.dart';
import 'package:hair_cos/Constants/input_form_field.dart';
import 'package:hair_cos/CustomViews/CustomButton.dart';
import 'package:hair_cos/Models/User.dart';
import 'package:hair_cos/Services/Database.dart';
import 'package:hair_cos/Services/Images.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool loading = false;
  File fileImage;
  TextEditingController name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController postcode = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController region = TextEditingController();
  Country selectedDialogCountry = CountryPickerUtils.getCountryByIsoCode('GB');

  @override
  void initState() {
    super.initState();
    name.text = User.userData.name ?? "No name";
    mobile.text = User.userData.userNumber ?? "";
    postcode.text = User.userData.postcode ?? "";
    street.text = User.userData.street ?? "";
    city.text = User.userData.city ?? "";
    region.text = User.userData.region ?? "";
    if (User.userData.countryCode != null) {
      selectedDialogCountry = CountryPickerUtils.getCountryByPhoneCode(
        User.userData.countryCode,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
      ),
      body: ModalProgressHUD(
        inAsyncCall: loading,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Stack(
                  children: <Widget>[
                    fileImage == null ? ImageServices.getProfileImage(User.userData.userPhoto, radius: 100)
                    : CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.white,
                      backgroundImage: ImageServices.getFileImage(fileImage),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: IconButton(
                        onPressed: pickImage,
                        icon: Icon(Icons.add_a_photo),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child: Divider(
                  color: Colors.black,
                  endIndent: 10,
                )),
                Text(
                  "Profile",
                  style: TextStyle(color: Colors.blueAccent),
                ),
                Expanded(
                    child: Divider(
                  color: Colors.black,
                  indent: 10,
                )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormFeild(
                icon: Icons.person,
                obsecure: false,
                controller: name,
                label: "Name",
                hint: "Enter Full Name",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: secondaryColor,
                elevation: 5,
                //margin: EdgeInsets.only(left: 20, right: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ListTile(
                  onTap: _openCountryPickerDialog,
                  title: buildDialogItem(selectedDialogCountry),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormFeild(
                icon: Icons.phone,
                obsecure: false,
                controller: mobile,
                label: "Mobile",
                hint: "Enter Mobile",
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child: Divider(
                  color: Colors.black,
                  endIndent: 10,
                )),
                Text(
                  "Address",
                  style: TextStyle(color: Colors.blueAccent),
                ),
                Expanded(
                    child: Divider(
                  color: Colors.black,
                  indent: 10,
                )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormFeild(
                controller: postcode,
                obsecure: false,
                label: 'Post code',
                hint: 'Enter your post code/ zip code',
                icon: FontAwesomeIcons.locationArrow,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormFeild(
                controller: street,
                obsecure: false,
                label: 'Street',
                hint: 'Enter apartment number, Street',
                icon: FontAwesomeIcons.locationArrow,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormFeild(
                controller: city,
                obsecure: false,
                label: 'City',
                hint: 'Enter your city',
                icon: Icons.location_city,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormFeild(
                controller: region,
                obsecure: false,
                label: 'State',
                hint: 'State, Province, Region ',
                icon: Icons.location_city,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 20, 50, 10),
              child: CustomButton.roundedButton(context, txt: "Save",
                  onPress: () async {
                if (!await save()) return;

                Navigator.of(context).pop();
              }),
            ),
          ],
        ),
      ),
    );
  }

  Future save() async {
    load();
    BaseDatabaseServices db = DatabaseServices(User.userData.userId);
    bool dbAccessed = false;
    if (fileImage != null) {
      await db.addUserProfilePicture(fileImage);
      dbAccessed = true;
    }
    if (User.userData.name != name.text && name.text.isNotEmpty) {
      await db.addUserName(name.text);
      dbAccessed = true;
    }

    if (User.userData.userNumber != mobile.text && mobile.text.isNotEmpty) {
      await db.addUserMobile(selectedDialogCountry.phoneCode, mobile.text);
      dbAccessed = true;
    }
    if (User.userData.street != street.text ||
        User.userData.city != city.text ||
        User.userData.region != region.text ||
        User.userData.postcode != postcode.text) {
      if (!await saveAddress(db)) {
        pauseLoad();
        return false;
      }
      dbAccessed = true;
    }

    if (dbAccessed) User.userData.fromSnapshot(await db.getUser());

    return Future.value(true);
  }

  Future<bool> saveAddress(BaseDatabaseServices db) async {
    try {
      String a = "${street.text}${city.text}${region.text}${postcode.text}";
      List<Address> address = await Geocoder.local.findAddressesFromQuery(a);
      if (address == null || address.isEmpty) {
        Fluttertoast.showToast(msg: "Incorrect input on address");
        return false;
      }
      Address result = await pickAddress(address);
      if (result == null) {
        return false;
      }
      double lat = result.coordinates.latitude;
      double lng = result.coordinates.longitude;

      Geoflutterfire geo = Geoflutterfire();
      GeoFirePoint myLocation = geo.point(latitude: lat, longitude: lng);

      await db.addUserAddress(
        postcode: postcode.text,
        street: street.text,
        city: city.text,
        region: region.text,
        geoPoint: myLocation,
      );
      return true;
    } on Exception catch (e) {
      Fluttertoast.showToast(msg: "Incorrect input on address");
      return false;
    }
  }

  void load() {
    setState(() {
      loading = true;
    });
  }

  void pauseLoad() {
    setState(() {
      loading = false;
    });
  }

  void pickImage() async {
    final imageSource = await showDialog<ImageSource>(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width / 1.2,
            height: MediaQuery.of(context).size.width * 0.6,
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        "Gallery",
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                      ),
                      onTap: () {
                        return Navigator.of(context).pop(ImageSource.gallery);
                      },
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        "Camera",
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        return Navigator.of(context).pop(ImageSource.camera);
                      },
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        "Close",
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    if (imageSource != null) {
      File file = await ImagePicker.pickImage(source: imageSource);
      if (file != null) {
        fileImage = file;
        setState(() {});
      }
    }
  }

  Future<Address> pickAddress(List<Address> address) async {
    return await showModalBottomSheet<Address>(
      context: context,
      builder: (context) {
        return Column(
          children: <Widget>[
            ListTile(
              title: Text("Select Address"),
            ),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      ListTile(
                        title: Text("${address[index].addressLine}"),
                        subtitle: Text("${address[index].postalCode}"),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          Navigator.of(context).pop(address[index]);
                        },
                      ),
                    ],
                  );
                },
                itemCount: address.length,
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Colors.black,
                    indent: 50,
                  );
                },
              ),
            ),
          ],
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
    );
  }

  void _openCountryPickerDialog() => showDialog(
        context: context,
        builder: (context) => Theme(
          data: Theme.of(context).copyWith(primaryColor: Colors.pink),
          child: CountryPickerDialog(
            titlePadding: EdgeInsets.all(8.0),
            searchCursorColor: Colors.pinkAccent,
            searchInputDecoration: InputDecoration(hintText: 'Search...'),
            isSearchable: true,
            title: Text('Select your phone code'),
            onValuePicked: (Country country) => setState(() {
              selectedDialogCountry = country;
            }),
            itemFilter: (c) => [
              /*'AR', 'DE',*/ 'GB' /*,'CN'*/
            ].contains(c.isoCode),
            priorityList: [
              CountryPickerUtils.getCountryByIsoCode('GB'),
            ],
            itemBuilder: buildDialogItem,
          ),
        ),
      );

  Widget buildDialogItem(Country country) => Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(width: 8.0),
          Text("+${country.phoneCode}"),
          SizedBox(width: 8.0),
          Flexible(child: Text(country.name))
        ],
      );

  Widget _buildDropdownItem(Country country) => Container(
        child: Row(
          children: <Widget>[
            CountryPickerUtils.getDefaultFlagImage(country),
            SizedBox(
              width: 8.0,
            ),
            Text("+${country.phoneCode}(${country.isoCode})"),
          ],
        ),
      );
}
