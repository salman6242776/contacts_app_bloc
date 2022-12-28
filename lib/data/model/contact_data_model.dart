class ContactDataModel {
  final int? id;
  String name;
  String mobileNumber;
  String landlineNumber;
  String profilePicture;

  ContactDataModel({
    this.id,
    this.name = "",
    this.mobileNumber = "",
    this.landlineNumber = "",
    this.profilePicture = "",
  });
}
