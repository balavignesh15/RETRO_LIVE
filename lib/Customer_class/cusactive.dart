class cusactive {
  CustomerCreatedBy? customerCreatedBy;
  String? sId;
  String? customerId;
  String? customerName;
  int? phonenumber;
  String? description;
  String? isActive;
  bool? status;
  String? createdAt;
  int? iV;

  cusactive(
      {this.customerCreatedBy,
        this.sId,
        this.customerId,
        this.customerName,
        this.phonenumber,
        this.description,
        this.isActive,
        this.status,
        this.createdAt,
        this.iV});

  cusactive.fromJson(Map<String, dynamic> json) {
    customerCreatedBy = json['customer_created_by'] != null
        ? new CustomerCreatedBy.fromJson(json['customer_created_by'])
        : null;
    sId = json['_id'];
    customerId = json['customer_id'];
    customerName = json['customer_name'];
    phonenumber = json['phonenumber'];
    description = json['description'];
    isActive = json['isActive'];
    status = json['status'];
    createdAt = json['created_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customerCreatedBy != null) {
      data['customer_created_by'] = this.customerCreatedBy!.toJson();
    }
    data['_id'] = this.sId;
    data['customer_id'] = this.customerId;
    data['customer_name'] = this.customerName;
    data['phonenumber'] = this.phonenumber;
    data['description'] = this.description;
    data['isActive'] = this.isActive;
    data['status'] = this.status;
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
