import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wasq_tech/features/invoice/data/model/invoice.dart';
import 'package:wasq_tech/web_services/end_points.dart';
import 'package:wasq_tech/web_services/http_client.dart';
import 'package:path/path.dart' as path;

abstract class InvoiceRepository {
  Future getInvoice({required int project_id});
  Future getInvoicePdf(int invoice_id);

  Future updateInvoice({
    required int invoice_id,
    int? equipment_cost,
    String? note,
    List<XFile?>? attachments,
    required String methods,
  });
  Future createInvoice(
      {required int project_id,
      int? equipment_cost,
      String? note,
      List<XFile?>? attachments});
}

class InvoiceRepositoryImpl implements InvoiceRepository {
  @override
  Future getInvoicePdf(int invoice_id) async {
    try {
      var response = await HttpClient.dio.get(
        EndPoints.getInvoicePdf(invoice_id: invoice_id),
        options: Options(headers: {
          "Content-Type": "multipart/form-data",
          "Accept": "application/json",
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
        print("##############################");
        // Invoice fromjson = Invoice.fromJson(response.data['invoice']);
        // fromjson.pdf =
        return response.data['pdf'];
        // return response.data["status"];
      } else {
        throw (response.data["message"]);
      }
    } catch (e) {
      throw (e.toString());
    }
  }

  @override
  Future getInvoice({required int project_id}) async {
    try {
      var response = await HttpClient.dio.get(
        EndPoints.getInvoice(project_id: project_id),
        options: Options(headers: {
          "Accept": "application/json",
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        Invoice fromjson = Invoice.fromJson(response.data['invoice']);

        print("fromjson:  $fromjson");
        return fromjson;
        // return response.data["status"];
      } else {
        throw (response.data["message"]);
      }
    } catch (e) {
      print("qqqqqqqqqqqqqqqqqqqqqqqqqq $e");
    }
  }

  @override
  Future createInvoice({
    required int project_id,
    int? equipment_cost,
    String? note,
    List<XFile?>? attachments,
  }) async {
    try {
      List<MultipartFile> imageFiles = [];
      if (attachments != null) {
        for (XFile? imageFile in attachments) {
          if (imageFile != null) {
            File file = File(imageFile.path);
            imageFiles.add(await MultipartFile.fromFile(
              file.path,
              filename: path.basename(file.path),
            ));
          }
        }
      }

      print(
          "Image files From Create Invoice ${imageFiles.toList().toString()}");

      final formData = FormData.fromMap({
        "equipment_cost": equipment_cost,
        "notice_payee": "",
        "attachments[]": imageFiles,
      });
      var response = await HttpClient.dio.post(
        EndPoints.createInvoice(project_id: project_id),
        data: formData,
        options: Options(headers: {
          "Content-Type": "multipart/form-data",
          "Accept": "application/json",
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['invoice'] == null) {
          throw (response.data["message"]);
        } else {
          Invoice fromjson = Invoice.fromJson(response.data['invoice']);
          return fromjson;
        }
        // return response.data["status"];
      } else {
        throw (response.data["message"]);
      }
    } catch (e) {}
  }

  @override
  Future updateInvoice({
    required int invoice_id,
    int? equipment_cost,
    String? note,
    List<XFile?>? attachments,
    required String methods,
  }) async {
    try {
      List<MultipartFile> imageFiles = [];
      if (attachments != null) {
        for (XFile? imageFile in attachments) {
          if (imageFile != null) {
            File file = File(imageFile.path);
            imageFiles.add(await MultipartFile.fromFile(
              file.path,
              filename: path.basename(file.path),
            ));
          }
        }
      }

      final formData = FormData.fromMap({
        "equipment_cost": equipment_cost,
        "status": "unpaid",
        // "invoice_id": invoice_id,
        // for (int i = 0; i < attachments!.length; i++) ...{
        "attachments[]": imageFiles,
        //   },
        "_method": "PUT",
      });

      print("$formData");
      var response = await HttpClient.dio.post(
        EndPoints.updateInvoice(invoice_id: invoice_id),
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
            "Accept": "application/json",
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        Invoice fromjson = Invoice.fromJson(response.data['invoice']);
        return fromjson;
        // return response.data["status"];
      } else {
        throw (response.data["message"]);
      }
    } catch (e) {
      print("This IS ERRRRRRRRRRRRRRRRRRROR ----> ${e.toString()}");
    }
  }
}

final invoiceRepositoryProvider = Provider<InvoiceRepository>((ref) {
  return InvoiceRepositoryImpl();
});
