class cusupdate {
  String? message;
  UpdatedUser? updatedUser;

  cusupdate({this.message, this.updatedUser});

  cusupdate.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    updatedUser = json['updatedUser'] != null
        ? new UpdatedUser.fromJson(json['updatedUser'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.updatedUser != null) {
      data['updatedUser'] = this.updatedUser!.toJson();
    }
    return data;
  }
}

class UpdatedUser {
  String? customerId;
  String? customerName;
  CustomerCreatedBy? customerCreatedBy;
  String? isActive;
  bool? status;
  String? updatedAt;
  String? sId;
  String? createdAt;
  int? iV;

  UpdatedUser(
      {this.customerId,
        this.customerName,
        this.customerCreatedBy,
        this.isActive,
        this.status,
        this.updatedAt,
        this.sId,
        this.createdAt,
        this.iV});

  UpdatedUser.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    customerName = json['customer_name'];
    customerCreatedBy = json['customer_created_by'] != null
        ? new CustomerCreatedBy.fromJson(json['customer_created_by'])
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
    data['customer_id'] = this.customerId;
    data['customer_name'] = this.customerName;
    if (this.customerCreatedBy != null) {
      data['customer_created_by'] = this.customerCreatedBy!.toJson();
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

class CustomerCreatedBy {
  String? adminId;
  String? adminName;

  CustomerCreatedBy({this.adminId, this.adminName});

  CustomerCreatedBy.fromJson(Map<String, dynamic> json) {
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