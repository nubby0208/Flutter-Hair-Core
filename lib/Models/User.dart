class User {
  String uid;
  String profileUrl;
  String name;
  String email;
  String mobile;
  String address;
  bool anonymous = false;

  User({
    this.profileUrl,
    this.uid,
    this.name,
    this.email,
    this.mobile,
    this.address,
    this.anonymous,
  });

  bool isUidEmpty() {
    return uid == null;
  }

  bool isNameEmpty() {
    return name == null;
  }

  bool isEmailEmpty() {
    return email == null;
  }

  bool isMobileEmpty() {
    return mobile == null;
  }

  bool isAddressEmpty() {
    return address == null;
  }

  bool isProfileUrlEmpty() {
    return profileUrl == null;
  }
}
