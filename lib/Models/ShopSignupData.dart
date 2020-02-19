class ShopSignUpData {
  String creatorID;
  String shopName;
  List<String> members = [];
  List<String> type = [];
  String about;
  String email;
  String contact;
  String address;
  bool isIndipendant = false;

  ShopSignUpData({
    this.creatorID,
    this.shopName,
    this.members,
    this.type,
    this.about,
    this.email,
    this.contact,
    this.address,
    this.isIndipendant,
  });

  Map<String, dynamic> toJson() =>
      {
        'CreatorID' : creatorID,
        'ShopName': shopName,
        'Email': email,
        'Contact': contact,
        'Address': address,
        'dateCreated': "${DateTime.now()}",
        'Indipendant': isIndipendant,
        'Members': members,
        'Type': type,
        'About' : about,
      };
}
