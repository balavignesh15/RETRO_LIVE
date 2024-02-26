class catupdate {
  String? message;
  UpdatedCategory? updatedCategory;

  catupdate({this.message, this.updatedCategory});

  catupdate.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    updatedCategory = json['updatedCategory'] != null
        ? new UpdatedCategory.fromJson(json['updatedCategory'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.updatedCategory != null) {
      data['updatedCategory'] = this.updatedCategory!.toJson();
    }
    return data;
  }
}

class UpdatedCategory {
  String? categoryId;
  String? expenseCategory;
  ExpenseCategoryUpdatedBy? expenseCategoryUpdatedBy;
  String? isActive;
  bool? status;
  String? updatedAt;
  String? sId;
  String? createdAt;
  int? iV;

  UpdatedCategory(
      {this.categoryId,
        this.expenseCategory,
        this.expenseCategoryUpdatedBy,
        this.isActive,
        this.status,
        this.updatedAt,
        this.sId,
        this.createdAt,
        this.iV});

  UpdatedCategory.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    expenseCategory = json['expense_category'];
    expenseCategoryUpdatedBy = json['expense_category_updated_by'] != null
        ? new ExpenseCategoryUpdatedBy.fromJson(
        json['expense_category_updated_by'])
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
    data['category_id'] = this.categoryId;
    data['expense_category'] = this.expenseCategory;
    if (this.expenseCategoryUpdatedBy != null) {
      data['expense_category_updated_by'] =
          this.expenseCategoryUpdatedBy!.toJson();
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

class ExpenseCategoryUpdatedBy {
  String? adminId;
  String? adminName;

  ExpenseCategoryUpdatedBy({this.adminId, this.adminName});

  ExpenseCategoryUpdatedBy.fromJson(Map<String, dynamic> json) {
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
