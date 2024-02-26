class getall1 {
  UserCreatedBy? userCreatedBy;
  String? sId;
  String? userId;
  String? name;
  String? username;
  String? password;
  String? userType;
  String? isActive;
  bool? status;
  String? createdAt;
  int? iV;

  getall1(
      {this.userCreatedBy,
        this.sId,
        this.userId,
        this.name,
        this.username,
        this.password,
        this.userType,
        this.isActive,
        this.status,
        this.createdAt,
        this.iV});

  getall1.fromJson(Map<String, dynamic> json) {
    userCreatedBy = json['user_created_by'] != null
        ? new UserCreatedBy.fromJson(json['user_created_by'])
        : null;
    sId = json['_id'];
    userId = json['user_id'];
    name = json['name'];
    username = json['username'];
    password = json['password'];
    userType = json['user_type'];
    isActive = json['isActive'];
    status = json['status'];
    createdAt = json['created_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userCreatedBy != null) {
      data['user_created_by'] = this.userCreatedBy!.toJson();
    }
    data['_id'] = this.sId;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['username'] = this.username;
    data['password'] = this.password;
    data['user_type'] = this.userType;
    data['isActive'] = this.isActive;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class UserCreatedBy {
  String? adminId;
  String? adminName;

  UserCreatedBy({this.adminId, this.adminName});

  UserCreatedBy.fromJson(Map<String, dynamic> json) {
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
