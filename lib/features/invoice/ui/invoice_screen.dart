// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:wasq_tech/features/invoice/data/model/invoice.dart';
// import 'package:wasq_tech/features/invoice/data/provider/invoice_provider.dart';
// import 'package:wasq_tech/features/notifications/data/model/notification_response.dart';
// import 'package:wasq_tech/features/service_form/ui/widgets/pick_image.dart';
// import 'package:wasq_tech/theme/app_assets.dart';
// import 'package:wasq_tech/theme/app_colors.dart';
// import 'package:wasq_tech/utils/utils.dart';
// import 'package:wasq_tech/features/home/data/models/home_response.dart';
//
// class InvoiceScreen extends StatefulHookConsumerWidget {
//   final Projects project;
//   const InvoiceScreen({super.key, required this.project});
//
//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _InvoiceScreenState();
// }
//
// class _InvoiceScreenState extends ConsumerState<InvoiceScreen> {
//   TextEditingController costController = TextEditingController();
//   TextEditingController notesController = TextEditingController();
//
//   final formKey = GlobalKey<FormState>();
//
//   String? initialNoteValue;
//   Invoice? invoice;
//   List<XFile?>? pickedImages;
//
//   var result;
//
//   @override
//   void initState() {
//     Future.delayed(const Duration(seconds: 0), () async {
//       ref
//           .read(invoiceNotifierProvider.notifier)
//           .getInvoice(projectId: widget.project.id!);
//     });
//
//     super.initState();
//   }
//
//   void checkInputValues() {
//     if (costController.text == '') {
//       costController = TextEditingController()
//         ..text = ref
//                 .read(invoiceNotifierProvider)
//                 .invoiceResponse
//                 ?.equipmentCost!
//                 .toString() ??
//             "";
//     }
//     if (notesController.text == '') {
//       notesController = TextEditingController()
//         ..text =
//             ref.read(invoiceNotifierProvider).invoiceResponse?.noticePayee ??
//                 "";
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     checkInputValues();
//     invoice = ref.watch(invoiceNotifierProvider).invoiceResponse;
//
//     return Scaffold(
//         appBar: AppBar(
//             centerTitle: true,
//             actions: [
//               Image.asset(AppAssets.logo,
//                   width: MediaQuery.of(context).size.width * 0.15,
//                   height: MediaQuery.of(context).size.width * 0.15),
//             ],
//             title: const Text(
//               "الفاتورة",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//               ),
//             )),
//         body: ref.watch(invoiceNotifierProvider).loading
//             ? const Center(child: CircularProgressIndicator())
//             : techUserView());
//   }
//
//   Widget techUserView() {
//     return Form(
//       key: formKey,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 15.0),
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 20,
//             ),
//             Container(
//               margin: const EdgeInsets.all(10.0),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(color: AppColors.grayWhite), // Add a border
//               ),
//               height: 50.0, // Fixed height
//               child: Padding(
//                 padding: const EdgeInsets.only(right: 10.0),
//                 child: TextFormField(
//                   controller: costController,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return ' من فضلك ادخل التكلفة الاضافية';
//                     }
//                     return null;
//                   },
//                   maxLines: null, // Allow multiple lines for notes
//                   decoration: const InputDecoration(
//                     hintText: "التكلفات الاضافية ",
//                     border: InputBorder.none, // Remove the default input border
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             ImagesPicker(
//               onImagePicked: (images) {
//                 pickedImages = images;
//                 setState(() {});
//               },
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(0),
//                 border: Border.all(color: AppColors.grayWhite), // Add a border
//               ),
//               height: 100.0, // Fixed height
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "ملحوظات",
//                       style: TextStyle(
//                           fontSize: 16, color: AppColors.primaryColor),
//                     ),
//                     TextFormField(
//                       controller: notesController,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'من فضلك ادخل ملحوظاتك';
//                         }
//                         return null;
//                       },
//                       decoration: const InputDecoration(
//                         hintText: 'اكتب ملحوظاتك هنا',
//                         border:
//                             InputBorder.none, // Remove the default input border
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Container(
//                 width: MediaQuery.of(context).size.width * 0.893,
//                 height: MediaQuery.of(context).size.height * 0.075,
//                 decoration: BoxDecoration(
//                   color: AppColors.primaryColor,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: TextButton(
//                   onPressed: () async {
//                     if (formKey.currentState!.validate()) {
//                       if (invoice == null) {
//                         result = await ref
//                             .read(invoiceNotifierProvider.notifier)
//                             .createInvoice(
//                               project_id: widget.project.id!,
//                               equipment_cost: costController.value.text != ""
//                                   ? int.parse(costController.value.text)
//                                   : 0,
//                               note: notesController.value.text,
//                               attachments: pickedImages,
//                             );
//                       } else {
//                         result = await ref
//                             .read(invoiceNotifierProvider.notifier)
//                             .updateInvoice(
//                                 invoice_id: invoice!.id!,
//                                 equipment_cost: costController.value.text != ""
//                                     ? int.parse(costController.value.text)
//                                     : 0,
//                                 note: notesController.value.text,
//                                 attachments: pickedImages);
//                       }
//                     }
//
//                     if (result != null) {
//                       ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(
//                           text: 'تم انشاء الفاتورة بنجاح',
//                           backgroundColor: Colors.green));
//                       Navigator.pop(context, result);
//                     }
//                   },
//                   child: const Text(
//                     "رفع الفاتورة",
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.white,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ))
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// Widget imageCard(image, deleteAction) {
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Stack(
//       alignment: Alignment.center,
//       children: [
//         Container(
//           width: 100, // Customize the width of the container as needed
//           height: 100, // Customize the height of the container as needed
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(
//                 20), // Adjust the radius as needed for curved edges
//             border: Border.all(
//                 color: AppColors.primaryColor,
//                 width: 2), // Customize border properties
//             image: DecorationImage(
//               image: image != null
//                   ? (false ? image : FileImage(File(image!.path)))
//                   : const AssetImage("res/assets/logo_rec.png"),
//               fit: BoxFit.cover, // You can customize the fit property
//             ),
//           ),
//         ),
//         Positioned(
//           right: -10,
//           top: -10,
//           child: IconButton(
//             icon: const Icon(
//               Icons.cancel,
//               color: Color.fromARGB(255, 10, 10, 10),
//             ),
//             onPressed: deleteAction,
//           ),
//         ),
//       ],
//     ),
//   );
// }
