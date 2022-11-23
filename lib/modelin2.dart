class user2 {
  String? id;
  String? acId;
  String? date;
  String? type;
  String? amount;
  String? particular;

  user2(
      {this.id, this.acId, this.date, this.type, this.amount, this.particular});

  user2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    acId = json['ac_id'];
    date = json['date'];
    type = json['type'];
    amount = json['amount'];
    particular = json['particular'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ac_id'] = this.acId;
    data['date'] = this.date;
    data['type'] = this.type;
    data['amount'] = this.amount;
    data['particular'] = this.particular;
    return data;
  }
}