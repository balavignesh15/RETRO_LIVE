class expcreate {
  String? expenseId;
  String? expenseDate;
  ExpenseCategory? expenseCategory;
  int? expenseAmount;
  SpendMode? spendMode;
  String? attachment;
  ExpenseCreatedBy? expenseCreatedBy;
  String? isActive;
  bool? status;
  String? sId;
  String? createdAt;
  int? iV;

  expcreate(
      {this.expenseId,
        this.expenseDate,
        this.expenseCategory,
        this.expenseAmount,
        this.spendMode,
        this.attachment,
        this.expenseCreatedBy,
        this.isActive,
        this.status,
        this.sId,
        this.createdAt,
        this.iV});

  expcreate.fromJson(Map<String, dynamic> json) {
    expenseId = json['expense_id'];
    expenseDate = json['expense_date'];
    expenseCategory = json['expense_category'] != null
        ? new ExpenseCategory.fromJson(json['expense_category'])
        : null;
    expenseAmount = json['expense_amount'];
    spendMode = json['spend_mode'] != null
        ? new SpendMode.fromJson(json['spend_mode'])
        : null;
    attachment = json['attachment'];
    expenseCreatedBy = json['expense_created_by'] != null
        ? new ExpenseCreatedBy.fromJson(json['expense_created_by'])
        : null;
    isActive = json['isActive'];
    status = json['status'];
    sId = json['_id'];
    createdAt = json['created_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expense_id'] = this.expenseId;
    data['expense_date'] = this.expenseDate;
    if (this.expenseCategory != null) {
      data['expense_category'] = this.expenseCategory!.toJson();
    }
    data['expense_amount'] = this.expenseAmount;
    if (this.spendMode != null) {
      data['spend_mode'] = this.spendMode!.toJson();
    }
    data['attachment'] = this.attachment;
    if (this.expenseCreatedBy != null) {
      data['expense_created_by'] = this.expenseCreatedBy!.toJson();
    }
    data['isActive'] = this.isActive;
    data['status'] = this.status;
    data['_id'] = this.sId;
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