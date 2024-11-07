//
// import 'dart:async';
// import 'dart:math';
//
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:wasq_tech/app/app_keys.dart';
// import 'package:wasq_tech/features/service_form/ui/widgets/pick_image.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:wasq_tech/features/home/data/models/home_response.dart';
// import 'package:flutter_sound_lite/public/flutter_sound_recorder.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// import '../../../app/widgets/animation/shimmer/shimmer_loading_anim.dart';
// import '../../../app/widgets/wave_visualizer.dart';
// import '../../../theme/app_colors.dart';
// import '../../../utils/utils.dart';
// import '../data/models/service_form_response.dart';
// import '../data/providers/service_form_provider.dart';
//
//
// class ServiceFormScreen extends StatefulHookConsumerWidget {
//   final Service service;
//   const ServiceFormScreen({super.key, required this.service});
//
//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _ServiceFormScreenState();
// }
//
// class _ServiceFormScreenState extends ConsumerState<ServiceFormScreen> {
//   FlutterSoundRecorder? _audioRecorder;
//   bool isRecording = false;
//   bool isPlaying = false;
//   String? recordedFilePath;
//   late AudioPlayer _audioPlayer;
//   final notesController = TextEditingController();
//   List<XFile?>? pickedImages;
//   late Position currentLocation;
//   double lat =0, lange =0;
//   CameraPosition? _kGooglePlex;
//   final Completer<GoogleMapController> _controller =
//   Completer<GoogleMapController>();
//   Set<Marker> marker={
//     const Marker(
//       markerId: MarkerId("1"),
//       position: LatLng(0, 0),
//     )
//   };
//
//   Future<void> getPos() async {
//     currentLocation =
//     await Geolocator.getCurrentPosition().then((value) => value);
//
//     lat = currentLocation.latitude;
//     lange = currentLocation.longitude;
//
//     print("lat : $lat");
//     print("lange : $lange");
//     marker={
//       Marker(
//         markerId: MarkerId("1"),
//         position: LatLng(lat, lange),
//       )
//     };
//     _kGooglePlex = CameraPosition(
//       target: LatLng(currentLocation.latitude, currentLocation.longitude),
//       zoom: 20,
//     );
//     setState(() {});
//   }
//
//
//   Future<bool> getPer() async {
//     bool services;
//     LocationPermission per;
//     services = await Geolocator.isLocationServiceEnabled();
//
//     if (services != true) {
//       AwesomeDialog(
//           headerAnimationLoop: true,
//           context: context,
//           title: "Gps",
//           desc: "من فضلك قم بتشغل الGPS",
//           btnCancelOnPress: () {},
//           dialogType: DialogType.warning,
//           animType: AnimType.scale)
//           .show();
//     }
//
//     per = await Geolocator.checkPermission();
//     if (per == LocationPermission.denied) {
//       per =await Geolocator.requestPermission();
//       if (per == LocationPermission.whileInUse) {
//         getPos();
//       }
//       else{
//         AppSnackbar.show(buildSnackBar(text: "لتجربة أفضل من فضلك اعطي التطبيق صلاحيات الموقع"));
//
//         lat = 24.774265;
//         lange = 46.738586;
//
//         print("lat : $lat");
//         print("lange : $lange");
//         marker={
//           Marker(
//             markerId: MarkerId("1"),
//             position: LatLng(lat, lange),
//           )
//         };
//         _kGooglePlex = CameraPosition(
//           target: LatLng(lat,lange),
//           zoom: 11,
//         );
//         setState(() {});
//       }
//     }
//     else{
//       getPos();
//     }
//
//     return per == LocationPermission.whileInUse;
//   }
//
//
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(const Duration(seconds: 0), () async {
//       bool result = await getPer();
//
//     });
//     _audioRecorder = FlutterSoundRecorder();
//     _audioRecorder?.openAudioSession();
//     _audioPlayer = AudioPlayer();
//
//   }
//
//   @override
//   void dispose() {
//     _audioRecorder?.closeAudioSession();
//     _audioPlayer.dispose();
//     super.dispose();
//   }
//
//   Future<void> _startRecording() async {
//     if (_audioPlayer.playing) await _pauseRecording();
//     if (await Permission.microphone.request().isGranted) {
//       await _audioRecorder!.startRecorder(toFile: 'recorded_audio.aac');
//       setState(() {
//         isRecording = true;
//       });
//     } else {
//       print('Microphone permission denied');
//     }
//   }
//
//   Future<void> _stopRecording() async {
//     recordedFilePath = await _audioRecorder!.stopRecorder();
//     setState(() {
//       print("File path: $recordedFilePath");
//       isRecording = false;
//     });
//   }
//
//   Future<void> _playRecording() async {
//     if (recordedFilePath != null) {
//       setState(() {
//         isPlaying = true;
//       });
//       await _audioPlayer.setFilePath(recordedFilePath!);
//       await _audioPlayer.play();
//     } else {
//       print('No recorded audio to play');
//     }
//   }
//
//   Future<void> _pauseRecording() async {
//     if (recordedFilePath != null) {
//       await _audioPlayer.pause();
//       setState(() {
//         isPlaying = false;
//       });
//     } else {
//       print('No recorded audio to pause');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//
//
//     ref.listen(serviceFormNotifierProvider.select((value) => value.errorMessage),
//             (previous, nextErrorMessage) {
//               if (nextErrorMessage != null && nextErrorMessage != '') {
//             AppSnackbar.show(buildSnackBar(text: nextErrorMessage));
//           }
//         });
//
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.service.name ?? ""),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child:ref.watch(serviceFormNotifierProvider).loading
//             ? ShimmerLoadingAnim(
//             isLoading: ref.watch(serviceFormNotifierProvider).loading,
//             child: _buildShimmerServiceForm())
//             : Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Form(
//             key: AppKeys.serviceFormKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Container(
//                   width: double.infinity,
//                   height: 300,
//                   child:_kGooglePlex==null?Center(child: CircularProgressIndicator(),):
//                   GoogleMap(
//                     markers: marker,
//                     mapType: MapType.normal,
//                     initialCameraPosition: _kGooglePlex!,
//                     gestureRecognizers: Set()
//                       ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
//                       ..add(Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()))
//                       ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
//                       ..add(Factory<VerticalDragGestureRecognizer>(
//                               () => VerticalDragGestureRecognizer())),
//                     onCameraMove: (CameraPosition position) {
//                       _kGooglePlex = position;
//                       setState(() {
//                       lat = _kGooglePlex!.target.latitude;
//                       lange = _kGooglePlex!.target.longitude;
//                       marker={
//                         Marker(
//                           markerId: const MarkerId("1"),
//                           position: LatLng(_kGooglePlex!.target.latitude, _kGooglePlex!.target.longitude),
//                         )
//                       };
//                       });
//                     },
//                     onMapCreated: (GoogleMapController controller) {
//                       _controller.complete(controller);
//                     },
//                   ),
//                 ),
//                 Container(
//                   margin: const EdgeInsets.all(10.0),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     border: Border.all(color: AppColors.grayWhite), // Add a border
//                   ),
//                   height: 100.0, // Fixed height
//                   child: SingleChildScrollView(
//                     // Add a SingleChildScrollView for scrolling
//                     child: Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             "ملحوظات",
//                             style: TextStyle(
//                                 fontSize: 16, color: AppColors.primaryColor),
//                           ),
//                           TextFormField(
//                             controller: notesController,
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'من فضلك ادخل ملحوظاتك';
//                               }
//                               return null;
//                             },
//                             maxLines: null, // Allow multiple lines for notes
//                             decoration: const InputDecoration(
//                               hintText: 'اكتب ملحوظاتك هنا',
//                               border: InputBorder
//                                   .none, // Remove the default input border
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(20),
//                   width: double.maxFinite,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.primaryColor,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(60),
//                         side: BorderSide(
//                           color: AppColors.primaryColor,
//                           width: 3,
//                         ),
//                       ),
//                     ),
//                     onPressed: isRecording ? _stopRecording : _startRecording,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 8.0,
//                         horizontal: 2.0,
//                       ),
//                       child: Row(
//                         children: [
//                           Container(
//                             decoration: const BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: AppColors.white,
//                             ),
//                             child: Padding(
//                               padding: EdgeInsets.all(16.0),
//                               child: Icon(
//                                 isRecording ? Icons.stop : Icons.mic,
//                                 color: Colors.black,
//                                 size: 24,
//                               ),
//                             ),
//                           ),
//                           const Spacer(),
//                           isRecording
//                               ? SizedBox(
//                                   height: 50,
//                                   width: MediaQuery.of(context).size.width * 0.6,
//                                   child: WaveVisualizer(
//                                     columnHeight: 40,
//                                     columnWidth: 10,
//                                     isPaused: false,
//                                     isBarVisible: false,
//                                     color: AppColors.white,
//                                   ),
//                                 )
//                               : const Text(
//                                   'سجل',
//                                   style: TextStyle(
//                                     fontSize: 22,
//                                     color: AppColors.white,
//                                   ),
//                                 ),
//                           const Spacer(),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 (recordedFilePath != null && !isRecording)?
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Container(
//                       width: MediaQuery.of(context).size.width * 0.44,
//                       height: MediaQuery.of(context).size.height * 0.068,
//                       decoration: BoxDecoration(
//                         color: AppColors.primaryColor,
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child: TextButton(
//                         onPressed: isPlaying?
//                         _pauseRecording
//                             :_playRecording,
//
//                         child: Row(
//                           children: [
//                             Text(
//                               isPlaying?"ايقاف \nالتسجيل":"تشغيل \nالتسجيل",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             Spacer(),
//                             Icon(isPlaying?Icons.stop_circle:Icons.play_circle,color: Colors.white,)
//                           ],
//                         ),
//                       ),
//                     ),
//                     Container(
//                       width: MediaQuery.of(context).size.width * 0.44,
//                       height: MediaQuery.of(context).size.height * 0.068,
//                       decoration: BoxDecoration(
//                         color: AppColors.primaryColor,
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child: TextButton(
//                         onPressed: () {
//                           setState(() {
//                             if(isPlaying) _pauseRecording();
//                             recordedFilePath = null;// Clear recorded file path
//
//                           });
//                         },
//
//                         child: const Row(
//                           children: [
//                             Text(
//                               'مسح \nالتسجيل',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             Spacer(),
//                             Icon(Icons.delete_forever_outlined,color: Colors.white,)
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ):SizedBox(height: MediaQuery.of(context).size.height * 0.068,),
//                 SizedBox(height: 20,),
//                 ImagesPicker(
//                     onImagePicked: (images) {
//                       pickedImages = images;
//                     }),
//                 SizedBox(height: 50,),
//                 Container(
//                   width: MediaQuery.of(context).size.width * 0.893,
//                   height: MediaQuery.of(context).size.height * 0.068,
//                   decoration: BoxDecoration(
//                     color: AppColors.green6E,
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   child: TextButton(
//                     onPressed: ()  async {
//                       if(lange==0&&lat==0){
//                         AppSnackbar.show(buildSnackBar(text: "من فضلك انتظر لحظات لتحديد موقعك"));
//                         return;
//                       }
//                       if(AppKeys.serviceFormKey.currentState!.validate()) {
//                         var result = await ref.read(serviceFormNotifierProvider.notifier).submitServiceForm(
//                         service_id: widget.service.id??0,
//                         description:  notesController.text,
//                         audioPath: recordedFilePath,
//                         pickedImages: pickedImages,
//                           lat: lat,
//                           lang: lange,
//                       );
//                         if(result == true) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                               buildSnackBar(text: 'تم نشر المهمة بنجاح',backgroundColor: Colors.green)
//                           );
//                           Navigator.pop(context);
//                         }
//                       }
//                     },
//
//                     child: const Text(
//                       'تسجيل الطلب',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.white,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   _buildShimmerServiceForm(){
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Container(
//             width: double.infinity,
//             height: 300,
//             color: Colors.grey,
//           ),
//           Container(
//             margin: const EdgeInsets.all(10.0),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(color: AppColors.grayWhite), // Add a border
//             ),
//             height: 100.0, // Fixed height
//             child: SingleChildScrollView(
//               // Add a SingleChildScrollView for scrolling
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
//                       maxLines: null, // Allow multiple lines for notes
//                       decoration: const InputDecoration(
//                         hintText: 'اكتب ملحوظاتك هنا',
//                         border: InputBorder
//                             .none, // Remove the default input border
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.all(20),
//             width: double.maxFinite,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.primaryColor,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(60),
//                   side: BorderSide(
//                     color: AppColors.primaryColor,
//                     width: 3,
//                   ),
//                 ),
//               ),
//               onPressed: null,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                   vertical: 8.0,
//                   horizontal: 2.0,
//                 ),
//                 child: Row(
//                   children: [
//                     Container(
//                       decoration: const BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: AppColors.white,
//                       ),
//                       child: Padding(
//                         padding: EdgeInsets.all(16.0),
//                         child: Icon(
//                           isRecording ? Icons.stop : Icons.mic,
//                           color: Colors.black,
//                           size: 24,
//                         ),
//                       ),
//                     ),
//                     const Spacer(),
//                     isRecording
//                         ? SizedBox(
//                       height: 50,
//                       width: MediaQuery.of(context).size.width * 0.6,
//                       child: WaveVisualizer(
//                         columnHeight: 40,
//                         columnWidth: 10,
//                         isPaused: false,
//                         isBarVisible: false,
//                         color: AppColors.white,
//                       ),
//                     )
//                         : const Text(
//                       'سجل',
//                       style: TextStyle(
//                         fontSize: 22,
//                         color: AppColors.white,
//                       ),
//                     ),
//                     const Spacer(),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Container(
//                 width: MediaQuery.of(context).size.width * 0.44,
//                 height: MediaQuery.of(context).size.height * 0.068,
//                 decoration: BoxDecoration(
//                   color: AppColors.primaryColor,
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//                 child: TextButton(
//                   onPressed: null,
//
//                   child: Row(
//                     children: [
//                       Text(
//                         isPlaying?"ايقاف \nالتسجيل":"تشغيل \nالتسجيل",
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.white,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       Spacer(),
//                       Icon(isPlaying?Icons.stop_circle:Icons.play_circle,color: Colors.white,)
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width * 0.44,
//                 height: MediaQuery.of(context).size.height * 0.068,
//                 decoration: BoxDecoration(
//                   color: AppColors.primaryColor,
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//                 child: TextButton(
//                   onPressed: null,
//
//                   child: const Row(
//                     children: [
//                       Text(
//                         'مسح \nالتسجيل',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.white,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       Spacer(),
//                       Icon(Icons.delete_forever_outlined,color: Colors.white,)
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 20,),
//           ImagesPicker(
//               onImagePicked: (images) {
//                 pickedImages = images;
//               }),
//           SizedBox(height: 50,),
//           Container(
//             width: MediaQuery.of(context).size.width * 0.893,
//             height: MediaQuery.of(context).size.height * 0.068,
//             decoration: BoxDecoration(
//               color: AppColors.green6E,
//               borderRadius: BorderRadius.circular(5),
//             ),
//             child: TextButton(
//               onPressed: null,
//
//               child: const Text(
//                 'تسجيل الطلب',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.white,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//
//
// }
//
