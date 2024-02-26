class Getallactive {
  ExpenseCategory? expenseCategory;
  SpendMode? spendMode;
  ExpenseCreatedBy? expenseCreatedBy;
  ExpenseCreatedBy? expenseUpdatedBy;
  String? sId;
  String? expenseId;
  String? expenseDate;
  int? expenseAmount;
  String? attachment;
  String? isActive;
  bool? status;
  String? updatedAt;
  String? createdAt;
  int? iV;

  Getallactive(
      {this.expenseCategory,
        this.spendMode,
        this.expenseCreatedBy,
        this.expenseUpdatedBy,
        this.sId,
        this.expenseId,
        this.expenseDate,
        this.expenseAmount,
        this.attachment,
        this.isActive,
        this.status,
        this.updatedAt,
        this.createdAt,
        this.iV});

  Getallactive.fromJson(Map<String, dynamic> json) {
    expenseCategory = json['expense_category'] != null
        ? new ExpenseCategory.fromJson(json['expense_category'])
        : null;
    spendMode = json['spend_mode'] != null
        ? new SpendMode.fromJson(json['spend_mode'])
        : null;
    expenseCreatedBy = json['expense_created_by'] != null
        ? new ExpenseCreatedBy.fromJson(json['expense_created_by'])
        : null;
    expenseUpdatedBy = json['expense_updated_by'] != null
        ? new ExpenseCreatedBy.fromJson(json['expense_updated_by'])
        : null;
    sId = json['_id'];
    expenseId = json['expense_id'];
    expenseDate = json['expense_date'];
    expenseAmount = json['expense_amount'];
    attachment = json['attachment'];
    isActive = json['isActive'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.expenseCategory != null) {
      data['expense_category'] = this.expenseCategory!.toJson();
    }
    if (this.spendMode != null) {
      data['spend_mode'] = this.spendMode!.toJson();
    }
    if (this.expenseCreatedBy != null) {
      data['expense_created_by'] = this.expenseCreatedBy!.toJson();
    }
    if (this.expenseUpdatedBy != null) {
      data['expense_updated_by'] = this.expenseUpdatedBy!.toJson();
    }
    data['_id'] = this.sId;
    data['expense_id'] = this.expenseId;
    data['expense_date'] = this.expenseDate;
    data['expense_amount'] = this.expenseAmount;
    data['attachment'] = this.attachment;
    data['isActive'] = this.isActive;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class ExpenseCategory {
  String? categoryId;
  String? categoryExpense;

  ExpenseCategory({this.categoryId, this.categoryExpense});

  ExpenseCategory.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryExpense = json['category_expense'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category_expense'] = this.categoryExpense;
    return data;
  }
}

class SpendMode {
  String? paymentId;
  String? paymentMode;

  SpendMode({this.paymentId, this.paymentMode});

  SpendMode.fromJson(Map<String, dynamic> json) {
    paymentId = json['payment_id'];
    paymentMode = json['payment_mode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_id'] = this.paymentId;
    data['payment_mode'] = this.paymentMode;
    return data;
  }
}

class ExpenseCreatedBy {
  String? adminId;
  String? adminName;

  ExpenseCreatedBy({this.adminId, this.adminName});

  ExpenseCreatedBy.fromJson(Map<String, dynamic> json) {
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
