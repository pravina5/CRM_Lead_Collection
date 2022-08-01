class Lead{
  String? uid;
  String? cname;
  String? cemail;
  String? cphone;
  Lead();
  Map<String,dynamic> toJson()=>{'uid':uid, 'cname':cname, 'cemail' : cemail, 'cphone':cphone} ;
  Lead.fromSnapshot(snapshot)
  : uid =snapshot.data()['uid'],
  cname = snapshot.data()['cname'],
    cemail = snapshot.data()['cemail'],
  cphone = snapshot.data()['cphone']
;
}