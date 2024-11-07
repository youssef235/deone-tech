import '../../../home/data/models/home_response.dart';

List<Attachment> attachmentFromJson(List str) => List<Attachment>.from(
      str.map(
        (x) => Attachment.fromJson(x),
      ),
    );

class Invoice {
  int? id;
  String? invoiceNo;
  num? projectCost;
  num? equipmentCost;
  num? totalCost;
  String? status;
  String? noticePayee;
  String? noticePayer;
  List<Attachment>? attachments;

  Invoice(
      {this.id,
      this.invoiceNo,
      this.projectCost,
      this.equipmentCost,
      this.totalCost,
      this.status,
      this.noticePayee,
      this.attachments,
      this.noticePayer});

  Invoice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoiceNo = json['invoice_no'];
    projectCost = json['project_cost'].toDouble();
    equipmentCost = json['equipment_cost'].toDouble();
    totalCost = json['total_cost'].toDouble();
    status = json['status'];
    attachments = json['attachment'] == null
        ? []
        : attachmentFromJson(json['attachment']);
    noticePayee = json['notice_payee'];
    noticePayer = json['notice_payer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['invoice_no'] = this.invoiceNo;
    data['project_cost'] = this.projectCost;
    data['equipment_cost'] = this.equipmentCost;
    data['total_cost'] = this.totalCost;
    data['status'] = this.status;
    data['attachment'] = this.attachments;
    data['notice_payee'] = this.noticePayee;
    data['notice_payer'] = this.noticePayer;
    return data;
  }
}
