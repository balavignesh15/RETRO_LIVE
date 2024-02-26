class updates {
  String? message;
  UpdatedUser? updatedUser;

  updates({this.message, this.updatedUser});

  updates.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  String? name;
  String? username;
  String? password;
  String? userType;
  UserCreatedBy? userCreatedBy;
  UserCreatedBy? userUpdatedBy;
  String? isActive;
  bool? status;
  String? updatedAt;
  String? sId;
  String? createdAt;
  int? iV;

  UpdatedUser(
      {this.userId,
        this.name,
        this.username,
        this.password,
        this.userType,
        this.userCreatedBy,
        this.userUpdatedBy,
        this.isActive,
        this.status,
        this.updatedAt,
        this.sId,
        this.createdAt,
        this.iV});

  UpdatedUser.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    username = json['username'];
    password = json['password'];
    userType = json['user_type'];
    userCreatedBy = json['user_created_by'] != null
        ? new UserCreatedBy.fromJson(json['user_created_by'])
        : null;
    userUpdatedBy = json['user_updated_by'] != null
        ? new UserCreatedBy.fromJson(json['user_updated_by'])
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
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['username'] = this.username;
    data['password'] = this.password;
    data['user_type'] = this.userType;
    if (this.userCreatedBy != null) {
      data['user_created_by'] = this.userCreatedBy!.toJson();
    }
    if (this.userUpdatedBy != null) {
      data['user_updated_by'] = this.userUpdatedBy!.toJson();
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
