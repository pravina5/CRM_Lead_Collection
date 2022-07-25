class DUser {
  String uid;
  String? email;
  String? name;
  DUser({required this.uid, required this.name,required this.email});

   String get id {
    return this.uid;
  }
}
