class catgetactive {
  ExpenseCategoryCreatedBy? expenseCategoryCreatedBy;
  String? sId;
  String? categoryId;
  String? expenseCategory;
  String? isActive;
  bool? status;
  String? createdAt;
  int? iV;

  catgetactive(
      {this.expenseCategoryCreatedBy,
        this.sId,
        this.categoryId,
        this.expenseCategory,
        this.isActive,
        this.status,
        this.createdAt,
        this.iV});

  catgetactive.fromJson(Map<String, dynamic> json) {
    expenseCategoryCreatedBy = json['expense_category_created_by'] != null
        ? new ExpenseCategoryCreatedBy.fromJson(
        json['expense_category_created_by'])
        : null;
    sId = json['_id'];
    categoryId = json['category_id'];
    expenseCategory = json['expense_category'];
    isActive = json['isActive'];
    status = json['status'];
    createdAt = json['created_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.expenseCategoryCreatedBy != null) {
      data['expense_category_created_by'] =
          this.expenseCategoryCreatedBy!.toJson();
    }
    data['_id'] = this.sId;
    data['category_id'] = this.categoryId;
    data['expense_category'] = this.expenseCategory;
    data['isActive'] = this.isActive;
    data['status'] = this.status;
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
