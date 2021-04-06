class ApprovalList {
  String modelErrors;
  List<ResultObject> resultObject;
  int statusCode;
  bool isSuccess;
  String commonErrors;

  ApprovalList(
      {this.modelErrors,
      this.resultObject,
      this.statusCode,
      this.isSuccess,
      this.commonErrors});

  ApprovalList.fromJson(Map<String, dynamic> json) {
    modelErrors = json['ModelErrors'];
    if (json['ResultObject'] != null) {
      resultObject = new List<ResultObject>();
      json['ResultObject'].forEach((v) {
        resultObject.add(new ResultObject.fromJson(v));
      });
    }
    statusCode = json['StatusCode'];
    isSuccess = json['IsSuccess'];
    commonErrors = json['CommonErrors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ModelErrors'] = this.modelErrors;
    if (this.resultObject != null) {
      data['ResultObject'] = this.resultObject.map((v) => v.toJson()).toList();
    }
    data['StatusCode'] = this.statusCode;
    data['IsSuccess'] = this.isSuccess;
    data['CommonErrors'] = this.commonErrors;
    return data;
  }
}

class ResultObject {
  int appID;
  String appNo;
  String appDate;
  String title;
  String businessUnitName;
  double totalAmount;
  String appStatus;
  String appType;
  String currencyName;

  ResultObject(
      {this.appID,
      this.appNo,
      this.appDate,
      this.title,
      this.businessUnitName,
      this.totalAmount,
      this.appStatus,
      this.appType,
      this.currencyName});

  ResultObject.fromJson(Map<String, dynamic> json) {
    appID = json['AppID'];
    appNo = json['AppNo'];
    appDate = json['AppDate'];
    title = json['Title'];
    businessUnitName = json['BusinessUnitName'];
    totalAmount = json['TotalAmount'];
    appStatus = json['AppStatus'];
    appType = json['AppType'];
    currencyName = json['CurrencyName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AppID'] = this.appID;
    data['AppNo'] = this.appNo;
    data['AppDate'] = this.appDate;
    data['Title'] = this.title;
    data['BusinessUnitName'] = this.businessUnitName;
    data['TotalAmount'] = this.totalAmount;
    data['AppStatus'] = this.appStatus;
    data['AppType'] = this.appType;
    data['CurrencyName'] = this.currencyName;
    return data;
  }
}
