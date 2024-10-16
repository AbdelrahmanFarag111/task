class CustomerRequest {
  String? payeeName;
  int? id;
  String? typeCode;
  String? deliveryTypeCode;
  int? deliveryAgentId;
  int? branchId;
  int? customerId;
  int? manifestId;
  int? paymentId;
  String? date;
  String? notes;
  int? paymentBankId;
  String? paymentAccountNumber;

  CustomerRequest({
    this.payeeName,
    this.id,
    this.typeCode,
    this.deliveryTypeCode,
    this.deliveryAgentId,
    this.branchId,
    this.customerId,
    this.manifestId,
    this.paymentId,
    this.date,
    this.notes,
    this.paymentBankId,
    this.paymentAccountNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'payeeName': payeeName,
      'id': id,
      'typeCode': typeCode,
      'deliveryTypeCode': deliveryTypeCode,
      'deliveryAgentId': deliveryAgentId,
      'branchId': branchId,
      'customerId': customerId,
      'manifestId': manifestId,
      'paymentId': paymentId,
      'date': date,
      'notes': notes,
      'paymentBankId': paymentBankId,
      'paymentAccountNumber': paymentAccountNumber,
    };
  }
}
