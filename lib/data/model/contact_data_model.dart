class ContactDataModel {
  final int? id;
  String name;
  String mobileNumber;
  String landlineNumber;
  bool isFavorite;

  String profilePicture;

  ContactDataModel({
    this.id,
    this.name = "",
    this.mobileNumber = "",
    this.landlineNumber = "",
    this.isFavorite = false,
    this.profilePicture = "",
  });
}
