class cuscreate {
  String? customerId;
  String? isActive;
  bool? status;
  String? sId;
  String? createdAt;
  int? iV;

  cuscreate(
      {this.customerId,
        this.isActive,
        this.status,
        this.sId,
        this.createdAt,
        this.iV});

  cuscreate.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    isActive = json['isActive'];
    status = json['status'];
    sId = json['_id'];
    createdAt = json['created_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['isActive'] = this.isActive;
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['created_at'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}