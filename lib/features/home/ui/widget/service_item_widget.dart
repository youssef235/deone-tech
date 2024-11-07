// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:wasq_tech/features/home/data/models/home_response.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../../app/routes.dart';
// import '../../../../theme/app_assets.dart';
//
// class ServiceItem extends StatelessWidget {
//   final Service service;
//
//   const ServiceItem(this.service, {super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: (){
//         Navigator.pushNamed(context, Routes.serviceFormScreen, arguments: service);
//       },
//       child: Card(
//         elevation: 4,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             // Image (Replace with your image)
//             ClipRRect(
//               borderRadius: const BorderRadius.all(Radius.circular(10)),
//               child: CachedNetworkImage(
//                 height: 75.h,
//                 width: 75.h,
//                 fit: BoxFit.cover,
//                 imageUrl:
//                 "${service?.icon?.url}",
//                 placeholder: (context, url) =>
//                     Image.asset(AppAssets.recLogo, fit: BoxFit.cover),
//                 errorWidget: (context, url, error) =>
//                     Image.asset(AppAssets.recLogo, fit: BoxFit.cover),
//               ),
//             ),
//             // Text
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 service.name??"",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }