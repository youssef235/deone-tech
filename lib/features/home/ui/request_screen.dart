import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_sound_lite/public/flutter_sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wasq_tech/app/app_keys.dart';
import 'package:wasq_tech/app/routes.dart';
import 'package:wasq_tech/features/home/data/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:video_player/video_player.dart';
import 'package:wasq_tech/features/notifications/ui/galary.dart';
import 'package:wasq_tech/features/notifications/ui/video_widget.dart';
import 'package:wasq_tech/features/notifications/ui/widgets.dart';
import 'package:wasq_tech/theme/el_icons.dart';

import '../../../app/widgets/text_field.dart';
import '../../../app/widgets/wave_visualizer.dart';
import '../../../theme/app_assets.dart';
import '../../../theme/app_colors.dart';
import '../../../utils/utils.dart';
import '../../notifications/data/model/notification_response.dart';
import '../data/models/home_response.dart';

class RequestService extends StatefulHookConsumerWidget {
  final Projects project;
  final bool isEdit;
  const RequestService({Key? key, required this.project, required this.isEdit})
      : super(key: key);

  @override
  ConsumerState<RequestService> createState() => _RequestServiceState();
}

class _RequestServiceState extends ConsumerState<RequestService> {
  List<GalleryItem> galaryImages = [];
  late AudioPlayer _audioPlayer;
  // FlutterSoundRecorder? _audioRecorder;
  bool isRecording = false;
  bool isPlaying = false;
  String? recordedFilePath;
  final TextEditingController notesController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  late VideoPlayerController _controller;
  double? _price;

  @override
  void initState() {
    super.initState();

    if (widget.project.attachment_images!.isNotEmpty) {
      galaryImages = widget.project.attachment_images!
          .map((e) => GalleryItem(id: e.id.toString(), resource: e.url ?? ""))
          .toList();
    }

    Future.delayed(const Duration(seconds: 0), () async {
      ref.read(homeNotifierProvider.notifier).getAddressFromCoordinates(
          widget.project.location_lat ?? 0 ,
          widget.project.location_lang ?? 0 ,
          );
      if (widget.isEdit) {
        Proposals result =
            await ref.read(homeNotifierProvider.notifier).getProposal(
                  id: widget.project.id ?? 0,
                );
        if (result != null) {
          _priceController.text = result.original_price.toString();
          notesController.text = result.description ?? "";
        }
      }
    });
    if (widget.project.attachments_videos != null &&
        widget.project.attachments_videos!.isNotEmpty &&
        widget.project.attachments_videos?[0].url != null &&
        widget.project.attachments_videos?[0].url != "") {
      _controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.project.attachments_videos![0].url!),
      )..initialize().then((_) {
          _controller.setLooping(true);
          setState(() {});
        });
    }

    // _audioRecorder = FlutterSoundRecorder();
    // _audioRecorder?.openAudioSession();
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    if (widget.project.attachments_videos != null &&
        widget.project.attachments_videos!.isNotEmpty &&
        widget.project.attachments_videos?[0].url != null &&
        widget.project.attachments_videos?[0].url != "") {
      _controller.dispose();
    }
    _audioPlayer.dispose();
    // _audioRecorder?.closeAudioSession();
    super.dispose();
  }

  Future<void> _startRecording() async {
    if (_audioPlayer.playing) await _pauseRecording();
    if (await Permission.microphone.request().isGranted) {
      // await _audioRecorder!.startRecorder(toFile: 'recorded_audio.aac');
      setState(() {
        isRecording = true;
      });
    } else {
      print('Microphone permission denied');
    }
  }

  Future<void> _stopRecording() async {
    // recordedFilePath = await _audioRecorder!.stopRecorder();
    setState(() {
      print("File path: $recordedFilePath");
      isRecording = false;
    });
  }

  Future<void> _playRecording() async {
    if (recordedFilePath != null) {
      setState(() {
        isPlaying = true;
      });
      await _audioPlayer.setFilePath(recordedFilePath!);
      await _audioPlayer.play();
    } else {
      print('No recorded audio to play');
    }
  }

  Future<void> _pauseRecording() async {
    if (recordedFilePath != null) {
      await _audioPlayer.pause();
      setState(() {
        isPlaying = false;
      });
    } else {
      print('No recorded audio to pause');
    }
  }

  Future<void> _playRecordin() async {
    if (widget.project.attachment_audios?[0].url != null &&
        widget.project.attachment_audios?[0].url != "") {
      setState(() {
        isPlaying = true;
      });
      print("audio source iz ${widget.project.attachment_audios![0].url!}");
      await _audioPlayer.setUrl(widget.project.attachment_audios![0].url!);
      await _audioPlayer.play();
    } else {
      print('No recorded audio to play');
    }
  }

  Future<void> _pauseRecordin() async {
    if (widget.project.attachment_audios?[0].url != null &&
        widget.project.attachment_audios?[0].url != "") {
      await _audioPlayer.pause();
      setState(() {
        isPlaying = false;
      });
    } else {
      print('No recorded audio to pause');
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
        homeNotifierProvider.select((value) => value.requestErrorMessage),
        (previous, nextErrorMessage) {
      if (nextErrorMessage != null && nextErrorMessage != '') {
        AppSnackbar.show(buildSnackBar(text: nextErrorMessage));
      }
    });
    return Scaffold(
        appBar: AppBar(
          title: const Text('رجوع'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: ref.watch(homeNotifierProvider).requestLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox(
                width: double.infinity,
                child: Form(
                  key: AppKeys.requestFormKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'العميل ',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  widget.project.customer?.name ?? "",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'منذ ',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 11),
                                ),
                                Text(
                                  // Calculate the time difference from notification.date to now
                                  getTimeDifference(DateTime.parse(
                                      widget.project.created_at ??
                                          DateTime.now().toString())),
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 11),
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        .039),
                                const Text(
                                  'الخدمة ',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 11),
                                ),
                                Text(
                                  widget.project.name ?? "",
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 11),
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        .039),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "تفاصيل الطلب",
                                    style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: AppColors.primaryColor,
                                    size: 30,
                                  )
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                widget.project.description ?? "",
                                style:
                                    const TextStyle(color: AppColors.grayWhite),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              if (widget.project.available_time != null)
                                Text(
                                  getAvailableTimeDifference(
                                      widget.project.available_time),
                                  style: const TextStyle(
                                      color: AppColors.grayWhite),
                                ),
                              SizedBox(
                                height: 5,
                              ),
                              GreyButtonTile(
                                color: Color(0xFFf5f5f5),
                                title: " موقع العميل ",
                                context: context,
                                icon: El.locaion_pin,
                                iconLeft: true,
                                pressed: () async {
                                  var lat = widget.project.location_lat!;
                                  var lng = widget.project.location_lang!;
                                  if (Platform.isAndroid) {
                                    String googleUrl =
                                        'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
                                    if (await canLaunch(googleUrl)) {
                                      await launch(googleUrl);
                                    } else {
                                      throw 'Could not open the map.';
                                    }
                                  } else {
                                    //for apple
                                    var urlAppleMaps =
                                        'https://maps.apple.com/?q=$lat,$lng';
                                    var url =
                                        'comgooglemaps://?saddr=&daddr=$lat,$lng&directionsmode=driving';
                                    if (await canLaunchUrl(Uri.parse(url))) {
                                      await launchUrl(Uri.parse(url));
                                    } else if (await canLaunchUrl(
                                        Uri.parse(urlAppleMaps))) {
                                      await launchUrl(Uri.parse(urlAppleMaps));
                                    }
                                  }
                                  //Navigator.pushNamed(context, Routes.map,arguments: latlng(latitude: double.parse(widget.proposal.project!.location_lat!) , longitude: double.parse(widget.proposal.project!.location_lang!)));
                                },
                              ),
                              if (widget.project!.attachments_videos != null &&
                                  widget.project!.attachments_videos!
                                      .isNotEmpty &&
                                  widget.project!.attachments_videos?[0].url !=
                                      null &&
                                  widget.project!.attachments_videos?[0].url !=
                                      "") ...[
                                SizedBox(
                                  height: 10,
                                ),
                                GreyButtonTile(
                                  color: Color(0xFFf5f5f5),
                                  title: " مقطع فيديو مشكلة العميل  ",
                                  context: context,
                                  icon: El.eye,
                                  iconLeft: true,
                                  pressed: () {
                                    VideoDialog alert = VideoDialog(
                                        title: "الفيديو المسجل من العميل",
                                        controller: _controller);

                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return alert;
                                      },
                                    );
                                    //Navigator.pushNamed(context, Routes.map,arguments: latlng(latitude: double.parse(widget.proposal.project!.location_lat!) , longitude: double.parse(widget.proposal.project!.location_lang!)));
                                  },
                                ),
                              ],
                              if (widget
                                      .project.attachment_audios!.isNotEmpty &&
                                  widget.project.attachment_audios?[0].url !=
                                      null &&
                                  widget.project.attachment_audios?[0].url !=
                                      "") ...[
                                SizedBox(
                                  height: 10,
                                ),
                                GreyButtonTile(
                                  color: Color(0xFFf5f5f5),
                                  title: "  الملاحظة الصوتية من العميل ",
                                  context: context,
                                  icon: isPlaying
                                      ? Icons.stop_circle
                                      : Icons.play_circle,
                                  iconLeft: true,
                                  pressed: isPlaying
                                      ? _pauseRecordin
                                      : _playRecordin,
                                ),
                              ],
                              if (widget
                                  .project.attachment_images!.isNotEmpty) ...[
                                SizedBox(
                                  height: 10,
                                ),
                                GreyButtonTile(
                                  color: Color(0xFFf5f5f5),
                                  title: "  صور قطع الغيار ",
                                  context: context,
                                  icon: Icons.chevron_right_outlined,
                                  iconLeft: true,
                                  pressed: () {
                                    open(context, 0, galaryImages);
                                    //Navigator.pushNamed(context, Routes.map,arguments: latlng(latitude: double.parse(widget.proposal.project!.location_lat!) , longitude: double.parse(widget.proposal.project!.location_lang!)));
                                  },
                                ),
                              ],
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),

                        // if(widget.project.status=="opened")
                        // Container(
                        //   padding: EdgeInsets.symmetric(horizontal: 20),
                        //   alignment: Alignment.centerRight,
                        //   child: SizedBox(
                        //     // width: MediaQuery.of(context).size.width * 0.6,
                        //     width: double.infinity,
                        //     child: AppTextField(
                        //       hintText: 'ادخل السعر',
                        //       textDirection: TextDirection.rtl,
                        //       textInputType:
                        //           TextInputType.numberWithOptions(decimal: true),
                        //       controller: _priceController,
                        //       hintStyle: const TextStyle(
                        //         fontWeight: FontWeight.w400,
                        //         fontSize: 14,
                        //         color: Color(0xff7C7C7C),
                        //       ),
                        //       color: Colors.transparent,
                        //       validator: (value) {
                        //         if (value == null || value.isEmpty) {
                        //           return 'السعر مطلوب';
                        //         }
                        //         try {
                        //           double.parse(value);
                        //         } catch (e) {
                        //           return 'رقم غير صحيح';
                        //         }
                        //         return null; // Return null if the value is valid
                        //       },
                        //       suffixIcon: SizedBox(),
                        //     ),
                        //   ),
                        // ),
                        if (widget.project.status == "opened")
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Color.fromARGB(
                                      255, 230, 230, 230)), // Add a border
                            ),
                            height: 100.0, // Fixed height
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "قدم عرض بأفضل الأسعار ليتم اختيارك",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.primaryColor),
                                  ),
                                  TextFormField(
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: true),
                                    controller: _priceController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'السعر مطلوب';
                                      }
                                      try {
                                        double.parse(value);
                                      } catch (e) {
                                        return 'رقم غير صحيح';
                                      }
                                      return null; // Return null if the value is valid
                                    },
                                    maxLines: 1,
                                    decoration: const InputDecoration(
                                      hintText: 'ادخل السعر',
                                      border: InputBorder
                                          .none, // Remove the default input border
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        const SizedBox(height: 10),

                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Text("تفاصيل عرضك")),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            width: double.maxFinite,
                            height: 80,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 1,
                                backgroundColor: AppColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    width: 3,
                                  ),
                                ),
                              ),
                              onPressed: isRecording
                                  ? _stopRecording
                                  : _startRecording,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 0.0,
                                  horizontal: 0.0,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Icon(
                                          isRecording ? Icons.stop : Icons.mic,
                                          color: AppColors.primaryColor,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    isRecording
                                        ? SizedBox(
                                            height: 50,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.6,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: WaveVisualizer(
                                                columnHeight: 35,
                                                columnWidth: 5,
                                                isPaused: false,
                                                isBarVisible: false,
                                                color: AppColors.black,
                                              ),
                                            ),
                                          )
                                        :  Text(
                                            'سجل تفاصيل عرضك',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              color: AppColors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        (recordedFilePath != null && !isRecording)
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.44,
                                    height: MediaQuery.of(context).size.height *
                                        0.058,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 5,
                                          spreadRadius: 1,
                                        )
                                      ],
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: TextButton(
                                      onPressed: isPlaying
                                          ? _pauseRecording
                                          : _playRecording,
                                      child: Row(
                                        children: [
                                          Text(
                                            isPlaying
                                                ? "ايقاف التسجيل"
                                                : "تشغيل التسجيل",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const Spacer(),
                                          Icon(
                                              isPlaying
                                                  ? Icons.stop_circle
                                                  : Icons.play_circle,
                                              color: AppColors.blackGrey)
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.44,
                                    height: MediaQuery.of(context).size.height *
                                        0.058,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 5,
                                          spreadRadius: 1,
                                        )
                                      ],
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          if (isPlaying) _pauseRecording();
                                          recordedFilePath =
                                              null; // Clear recorded file path
                                        });
                                      },
                                      child: const Row(
                                        children: [
                                          Text(
                                            'مسح  التسجيل',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Spacer(),
                                          Icon(
                                            Icons.delete_forever_outlined,
                                            color: AppColors.blackGrey,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox(),

                        SizedBox(
                          height: 30,
                        ),
                        // if (widget.project.status == "opened")
                        //   Container(
                        //     margin: const EdgeInsets.symmetric(
                        //         horizontal: 20.0, vertical: 10),
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(10),
                        //       border: Border.all(
                        //           color: Color.fromARGB(
                        //               255, 230, 230, 230)), // Add a border
                        //     ),
                        //     height: 100.0, // Fixed height
                        //     child: SingleChildScrollView(
                        //       // Add a SingleChildScrollView for scrolling
                        //       child: Padding(
                        //         padding: const EdgeInsets.all(10.0),
                        //         child: Column(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             const Text(
                        //               "تفاصيل عرضك",
                        //               style: TextStyle(
                        //                   fontSize: 16,
                        //                   color: AppColors.primaryColor),
                        //             ),
                        //             TextFormField(
                        //               controller: notesController,
                        //               // validator: (value) {
                        //               //   if (value == null || value.isEmpty) {
                        //               //     return 'من فضلك ادخل تفاصيل عرضك';
                        //               //   }
                        //               //   return null;
                        //               // },
                        //               maxLines:
                        //                   null, // Allow multiple lines for notes
                        //               decoration: const InputDecoration(
                        //                 hintText: 'اكتب تفاصيل عرضك هنا',
                        //                 border: InputBorder
                        //                     .none, // Remove the default input border
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        if (widget.project.status == "opened")
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.88,
                                height:
                                    MediaQuery.of(context).size.height * 0.068,
                                decoration: BoxDecoration(
                                  color: widget.isEdit == true
                                      ? AppColors.blue
                                      : AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextButton(
                                  onPressed: () async {
                                    if (AppKeys.requestFormKey.currentState!
                                        .validate()) {
                                      print(recordedFilePath);
                                      String? result = await ref
                                          .read(homeNotifierProvider.notifier)
                                          .createProposal(
                                            id: widget.project.id ?? 0,
                                            price: double.parse(
                                                _priceController.text),
                                            dis: notesController.text,
                                            audioPath: recordedFilePath,
                                          );

                                      if (result != null && result.isNotEmpty) {
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            Routes.initRoute,
                                            (route) => false);

                                        AppSnackbar.show(buildSnackBar(
                                            text: result.toString(),
                                            backgroundColor: Colors.green));
                                      }
                                    }
                                  },
                                  child: Text(
                                    widget.isEdit == true
                                        ? 'عدل عرضك'
                                        : 'قدم عرضك',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ));
  }
}
