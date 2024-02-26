class category {
  String? categoryId;
  String? expenseCategory;
  ExpenseCategoryCreatedBy? expenseCategoryCreatedBy;
  String? isActive;
  bool? status;
  String? sId;
  String? createdAt;
  int? iV;

  category(
      {this.categoryId,
        this.expenseCategory,
        this.expenseCategoryCreatedBy,
        this.isActive,
        this.status,
        this.sId,
        this.createdAt,
        this.iV});

  category.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    expenseCategory = json['expense_category'];
    expenseCategoryCreatedBy = json['expense_category_created_by'] != null
        ? new ExpenseCategoryCreatedBy.fromJson(
        json['expense_category_created_by'])
        : null;
    isActive = json['isActive'];
    status = json['status'];
    sId = json['_id'];
    createdAt = json['created_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['expense_category'] = this.expenseCategory;
    if (this.expenseCategoryCreatedBy != null) {
      data['expense_category_created_by'] =
          this.expenseCategoryCreatedBy!.toJson();
    }
    data['isActive'] = this.isActive;
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['created_at'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class ExpenseCategoryCreatedBy {
  String? adminId;
  String? adminName;

  ExpenseCategoryCreatedBy({this.adminId, this.adminName});

  ExpenseCategoryCreatedBy.fromJson(Map<String, dynamic> json) {
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
