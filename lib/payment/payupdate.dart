class update {
  String? message;
  UpdatedPayment? updatedPayment;

  update({this.message, this.updatedPayment});

  update.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    updatedPayment = json['updatedPayment'] != null
        ? new UpdatedPayment.fromJson(json['updatedPayment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.updatedPayment != null) {
      data['updatedPayment'] = this.updatedPayment!.toJson();
    }
    return data;
  }
}

class UpdatedPayment {
  String? paymentId;
  String? paymentMode;
  PaymentUpdatedBy? paymentUpdatedBy;
  String? isActive;
  bool? status;
  String? updatedAt;
  String? sId;
  String? createdAt;
  int? iV;

  UpdatedPayment(
      {this.paymentId,
        this.paymentMode,
        this.paymentUpdatedBy,
        this.isActive,
        this.status,
        this.updatedAt,
        this.sId,
        this.createdAt,
        this.iV});

  UpdatedPayment.fromJson(Map<String, dynamic> json) {
    paymentId = json['payment_id'];
    paymentMode = json['payment_mode'];
    paymentUpdatedBy = json['payment_updated_by'] != null
        ? new PaymentUpdatedBy.fromJson(json['payment_updated_by'])
        : null;
    isActive = json['isActive'];
    status = json['status'];
    updatedAt = json['updated_at'];
    sId = json['_id'];
    createdAt = json['created_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_id'] = this.paymentId;
    data['payment_mode'] = this.paymentMode;
    if (this.paymentUpdatedBy != null) {
      data['payment_updated_by'] = this.paymentUpdatedBy!.toJson();
    }
    data['isActive'] = this.isActive;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    data['_id'] = this.sId;
    data['created_at'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class PaymentUpdatedBy {
  String? adminId;
  String? adminName;

  PaymentUpdatedBy({this.adminId, this.adminName});

  PaymentUpdatedBy.fromJson(Map<String, dynamic> json) {
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
