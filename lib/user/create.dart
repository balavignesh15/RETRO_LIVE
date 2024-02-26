class create {
  String? userId;
  String? name;
  String? username;
  String? password;
  String? userType;
  UserCreatedBy? userCreatedBy;
  String? isActive;
  bool? status;
  String? sId;
  String? createdAt;
  int? iV;

  create(
      {this.userId,
        this.name,
        this.username,
        this.password,
        this.userType,
        this.userCreatedBy,
        this.isActive,
        this.status,
        this.sId,
        this.createdAt,
        this.iV});

  create.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    username = json['username'];
    password = json['password'];
    userType = json['user_type'];
    userCreatedBy = json['user_created_by'] != null
        ? new UserCreatedBy.fromJson(json['user_created_by'])
        : null;
    isActive = json['isActive'];
    status = json['status'];
    sId = json['_id'];
    createdAt = json['created_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['username'] = this.username;
    data['password'] = this.password;
    data['user_type'] = this.userType;
    if (this.userCreatedBy != null) {
      data['user_created_by'] = this.userCreatedBy!.toJson();
    }
    data['isActive'] = this.isActive;
    data['status'] = this.status;
    data['_id'] = this.sId;
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
