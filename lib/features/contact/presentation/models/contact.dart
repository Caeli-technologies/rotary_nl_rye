class Contact {
  final String name;
  //final String role;
  final String bio;
  final String imageUrl;
  final String? email;
  final String? phoneNumber;
  Contact(
      {required this.name,
        //required this.role,
        required this.bio,
        required this.imageUrl,
        this.email,
        this.phoneNumber});
}
