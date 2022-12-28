class ContactDataModel {
  final int? id;
  String name;
  String mobileNumber;
  String landlineNumber;
  bool isfavorite;

  String profilePicture;

  ContactDataModel({
    this.id,
    this.name = "",
    this.mobileNumber = "",
    this.landlineNumber = "",
    this.isfavorite = false,
    this.profilePicture = "",
  });
}
