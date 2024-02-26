class Getall {
  PaymentCreatedBy? paymentCreatedBy;
  String? sId;
  String? paymentId;
  String? paymentMode;
  String? isActive;
  bool? status;
  String? createdAt;
  int? iV;

  Getall(
      {this.paymentCreatedBy,
        this.sId,
        this.paymentId,
        this.paymentMode,
        this.isActive,
        this.status,
        this.createdAt,
        this.iV});

  Getall.fromJson(Map<String, dynamic> json) {
    paymentCreatedBy = json['payment_created_by'] != null
        ? new PaymentCreatedBy.fromJson(json['payment_created_by'])
        : null;
    sId = json['_id'];
    paymentId = json['payment_id'];
    paymentMode = json['payment_mode'];
    isActive = json['isActive'];
    status = json['status'];
    createdAt = json['created_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.paymentCreatedBy != null) {
      data['payment_created_by'] = this.paymentCreatedBy!.toJson();
    }
    data['_id'] = this.sId;
    data['payment_id'] = this.paymentId;
    data['payment_mode'] = this.paymentMode;
    data['isActive'] = this.isActive;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class PaymentCreatedBy {
  String? adminId;
  String? adminName;

  PaymentCreatedBy({this.adminId, this.adminName});

  PaymentCreatedBy.fromJson(Map<String, dynamic> json) {
    adminId = json['admin_id'];
    adminName = json['admin_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['admin_id'] = this.adminId;
    data['admin_name'] = this.adminName;
    return data;
  }
}