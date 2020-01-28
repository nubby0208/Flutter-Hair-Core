class User{
  String uid;
  String name;
  String email;
  String mobile;
  String address;
  User({this.uid , this.name, this.email, this.mobile, this.address});

  bool isUidEmpty(){
    return uid == null;
  }

  bool isNameEmpty(){
    return name == null;
  }

  bool isEmailEmpty(){
    return email == null;
  }

  bool isMobileEmpty(){
    return mobile == null;
  }

  bool isAddressEmpty(){
    return address == null;
  }
}