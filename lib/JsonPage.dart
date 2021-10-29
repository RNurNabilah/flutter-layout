class JsonPage{
  //data Type
  int? id;
  String? fName;
  String? lName;
  String? uName;
  String? lastSeenTime;
  String? avatar;
  String? status;
  int? messages;
// constructor
  JsonPage(
      {
       this.id,
      this.fName,
      this.lName,
      this.uName,
      this.lastSeenTime,
      this.avatar,
      this.status,
      this.messages
      }
   );
  //method that assign values to respective datatype vairables
  JsonPage.fromJson(Map<String,dynamic> json)
  {
    id = json['id'];
    fName =json['first_name'];
    lName = json['last_name'];
    uName = json['username'];
    lastSeenTime = json['last_seen_time'];
    avatar = json['avatar'];
    status = json['status'];
    messages = json['messages'];
  }
}