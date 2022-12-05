import 'package:cloud_firestore/cloud_firestore.dart';

class Result {
  String? uid;
  num? que_one_score;
  num? que_two_score;
  String? atcid;
  String? name;
  String? mod_result;
  bool? request;
  Timestamp? time;

  Result(
      {this.uid,
      this.atcid,
      this.name,
      this.mod_result,
      this.que_one_score,
      this.que_two_score,
      this.request,
      this.time});

  Result.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    atcid = json['atcid'];
    name = json['name'];
    que_one_score = json['que_one_score'];
    que_two_score = json['que_one_score'];
    mod_result = json['mod_result'];
    request = json['request'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['atcid'] = atcid;
    data['name'] = name;
    data['que_one_score'] = que_one_score;
    data['que_two_score'] = que_two_score;
    data['mod_result'] = mod_result;
    data['request'] = request;
    data['time'] = time;
    return data;
  }
}
