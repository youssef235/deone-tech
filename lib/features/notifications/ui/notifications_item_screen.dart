import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wasq_tech/features/chat/data/providers/chat_provider.dart';
import 'package:wasq_tech/features/notifications/data/model/notification_response.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wasq_tech/features/notifications/ui/widgets.dart';

import 'package:wasq_tech/features/notifications/ui/galary.dart';
import 'package:wasq_tech/features/notifications/ui/video_widget.dart';
import 'package:wasq_tech/web_services/end_points.dart';
import '../../../app/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/el_icons.dart';
import '../../../utils/constants.dart';
import '../../../utils/hive_manager.dart';
import '../../../utils/utils.dart';
import '../../auth/data/providers/auth_provider.dart';
import '../../invoice/data/model/invoice.dart';
import '../../invoice/data/provider/invoice_provider.dart';
import '../../service_form/ui/widgets/pick_image.dart';
import '../data/providers/notification_provider.dart';
import 'package:just_audio/just_audio.dart';
import 'package:video_player/video_player.dart';
import 'dart:io' show Platform;

class NotificationItem extends StatefulHookConsumerWidget {
  final Proposals proposal;

  const NotificationItem({Key? key, required this.proposal}) : super(key: key);

  @override
  ConsumerState<NotificationItem> createState() => _RequestServiceState();
}

class _RequestServiceState extends ConsumerState<NotificationItem> {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;
  late VideoPlayerController _controller;
  List<XFile?>? pickedImages;
  String? initialNoteValue;
  String? projectStatus;
  Invoice? invoice;
  var result;

  late Timer _timer;

  List<GalleryItem> galaryImages = [];

  TextEditingController costController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  @override
  void dispose() {
    if (widget.proposal.project!.attachments_videos != null &&
        widget.proposal.project!.attachments_videos!.isNotEmpty &&
        widget.proposal.project!.attachments_videos?[0].url != null &&
        widget.proposal.project!.attachments_videos?[0].url != "") {
      _controller.dispose();
    }
    _audioPlayer.dispose();
    _timer.cancel();
    super.dispose();
  }

  getProjectStatus(int projectID) async {
    try {
      final response = await Dio()
          .get("$baseUrl/single-project-status/$projectID",
              options: Options(headers: {
                "Authorization":
                    "Bearer ${HiveManager.getData(StorageKeys.tokenKey)}",
                "Accept": "application/json"
              }));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        setState(() {
          projectStatus = data['status'];
        });
        return data['status'];
      } else {
        print("Error: ${response.statusCode} - ${response.data}");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future<void> _playRecording() async {
    if (widget.proposal.project!.attachment_audios?[0].url != null &&
        widget.proposal.project!.attachment_audios?[0].url != "") {
      setState(() {
        isPlaying = true;
      });
      print(
          "audio source iz ${widget.proposal.project!.attachment_audios![0].url!}");
      await _audioPlayer
          .setUrl(widget.proposal.project!.attachment_audios![0].url!);
      await _audioPlayer.play();
    } else {
      // print('No recorded audio to play');
    }
  }

  Future<void> _pauseRecording() async {
    if (widget.proposal.project!.attachment_audios?[0].url != null &&
        widget.proposal.project!.attachment_audios?[0].url != "") {
      await _audioPlayer.pause();
      setState(() {
        isPlaying = false;
      });
    } else {
      // print('No recorded audio to pause');
    }
  }

  @override
  void initState() {
    costController.clear();
    getProjectStatus(widget.proposal.project!.id!);
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      getProjectStatus(widget.proposal.project!.id!);
    });
    Future.delayed(const Duration(seconds: 0), () async {
      invoice = await ref
          .read(invoiceNotifierProvider.notifier)
          .getInvoice(projectId: widget.proposal.project!.id!);
    });

    Future.delayed(const Duration(seconds: 0), () {
      if (widget.proposal.project!.attachment_images!.isNotEmpty) {
        galaryImages = widget.proposal.project!.attachment_images!
            .map((e) => GalleryItem(id: e.id.toString(), resource: e.url ?? ""))
            .toList();
      }
      if (widget.proposal.project!.attachments_videos != null &&
          widget.proposal.project!.attachments_videos!.isNotEmpty &&
          widget.proposal.project!.attachments_videos?[0].url != null &&
          widget.proposal.project!.attachments_videos?[0].url != "") {
        _controller = VideoPlayerController.networkUrl(
          Uri.parse(widget.proposal.project!.attachments_videos![0].url!),
        )..initialize().then((_) {
            _controller.setLooping(true);
            setState(() {});
          });
      }
      _audioPlayer = AudioPlayer();
      ref
          .read(notificationsNotifierProvider.notifier)
          .getAddressFromCoordinates(
          widget.proposal.project?.location_lat ?? 0,
          widget.proposal.project?.location_lang ?? 0);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    invoice = ref.watch(invoiceNotifierProvider).invoiceResponse;

    if (costController.text == '') {
      costController.text = ref.watch(invoiceNotifierProvider).invoiceResponse
          ?.equipmentCost
          .toString() ??
          "";
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('رجوع'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: ref.watch(notificationsNotifierProvider).addLoading ||
                ref.watch(invoiceNotifierProvider).loading == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'تم قبول عرضك من العميل ',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                widget.proposal.customer?.name ?? "",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor),
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
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                // Calculate the time difference from notification.date to now
                                getTimeDifference(DateTime.parse(
                                    widget.proposal.created_at ??
                                        DateTime.now().toString())),
                                style: const TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                ' الخدمة ',
                                style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                widget.proposal.project?.name ?? "",
                                style: const TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                ' السعر ',
                                style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${(widget.proposal.price!.toDouble() + widget.proposal.project!.equipment_cost.toDouble()).toStringAsFixed(2)} ريال',
                                style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      if (widget.proposal.project!.status == "completed") ...[
                        SizedBox(height: 50),
                      ] else ...[
                        GreyButtonTile(
                          color: Color(0xFFf5f5f5),
                          title: " موقع العميل ",
                          context: context,
                          icon: El.locaion_pin,
                          iconLeft: true,
                          pressed: () async {
                            var lat = widget.proposal.project!.location_lat!;
                            var lng = widget.proposal.project!.location_lang!;
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
                              } else {
                                throw 'Could not launch $url';
                              }
                            }
                            //Navigator.pushNamed(context, Routes.map,arguments: latlng(latitude: double.parse(widget.proposal.project!.location_lat!) , longitude: double.parse(widget.proposal.project!.location_lang!)));
                          },
                        ),
                        if (widget
                                    .proposal.project!.attachments_videos !=
                                null &&
                            widget.proposal.project!.attachments_videos!
                                .isNotEmpty &&
                            widget.proposal.project!.attachments_videos?[0]
                                    .url !=
                                null &&
                            widget.proposal.project!.attachments_videos?[0]
                                    .url !=
                                "") ...[
                          const SizedBox(
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
                          const SizedBox(
                            height: 10,
                          ),
                          const Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(right: 30.0),
                              child: Text("تواصل مع العميل",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: AppColors.primaryColor)),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                        if (widget.proposal.project!.attachment_audios!
                                .isNotEmpty &&
                            widget.proposal.project!.attachment_audios?[0]
                                    .url !=
                                null &&
                            widget.proposal.project!.attachment_audios?[0]
                                    .url !=
                                "") ...[
                          const SizedBox(
                            height: 10,
                          ),
                          GreyButtonTile(
                            color: const Color(0xFFf5f5f5),
                            title: "  الملاحظة الصوتية من العميل ",
                            context: context,
                            icon: isPlaying
                                ? Icons.stop_circle
                                : Icons.play_circle,
                            iconLeft: true,
                            pressed:
                                isPlaying ? _pauseRecording : _playRecording,
                          ),
                        ],
                        if (widget.proposal.project!.attachment_images!
                            .isNotEmpty) ...[
                          const SizedBox(
                            height: 10,
                          ),
                          GreyButtonTile(
                            color: Color(0xFFf5f5f5),
                            title: "صور قطع الغيار",
                            context: context,
                            icon: Icons.chevron_right_outlined,
                            iconLeft: true,
                            pressed: () {
                              open(context, 0, galaryImages);
                              //Navigator.pushNamed(context, Routes.map,arguments: latlng(latitude: double.parse(widget.proposal.project!.location_lat!) , longitude: double.parse(widget.proposal.project!.location_lang!)));
                            },
                          ),
                        ],
                      ],
                      whiteButtonTile(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        title:
                            " عرض السعر : ${(widget.proposal.price!.toDouble() + widget.proposal.project!.equipment_cost.toDouble()).toStringAsFixed(2)} ريال",
                        context: context,
                        pressed: () {
                          // Navigator.pushNamed(context, Routes.trackingScreen,arguments: widget.proposal);
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (widget.proposal.project!.status != "completed") ...[
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              whiteButtonTile(
                                  small: true,
                                  color: AppColors.blackGrey,
                                  title: "رقم العميل",
                                  context: context,
                                  pressed: () {
                                    print(
                                        "customer is ${widget.proposal.customer}");
                                    launch(
                                        'tel:${widget.proposal.customer?.phone}');
                                  }),
                              whiteButtonTile(
                                small: true,
                                //  iconLeft: true,
                                color: AppColors.blackGrey,
                                title: "دردشه",
                                context: context,
                                // icon: Icons.receipt,
                                pressed: () {
                                  Navigator.pushNamed(context, Routes.chat,
                                      arguments: widget.proposal);
                                },
                                // pressed: () {
                                //
                                //
                                //   print(widget.proposal.project);
                                //   Navigator.pushNamed(context, Routes.invoice,
                                //       arguments: widget.proposal.project);
                                // },
                              )
                            ],
                          ),
                        ),
                      ] else ...[
                        SizedBox()
                      ],
                      const SizedBox(
                        height: 10,
                      ),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 30.0),
                          child: Text("حالة الطلب",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: AppColors.primaryColor)),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      whiteButtonTile(
                        fontWeight: FontWeight.bold,
                        color: projectStatus == "completed"
                            ? AppColors.green6E
                            : projectStatus == "under_review"
                                ? AppColors.red
                                : AppColors.primaryColor,
                        icon: projectStatus == "completed"
                            ? Icons.done_all
                            : projectStatus == "under_review"
                                ? Icons.monetization_on_outlined
                                : El.autorenew,
                        textColor: projectStatus == "under_review" ||
                                projectStatus == "completed"
                            ? AppColors.white
                            : null,
                        iconLeft: true,
                        title: getPropjectStatusAr(projectStatus),
                        context: context,
                        pressed: null,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (widget.proposal.project!.status != "completed") ...[
                        Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.only(right: 30.0),
                                child: Text("الفاتورة",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: AppColors.primaryColor)),
                              ),
                            ),
                            if (invoice != null)
                              Text(
                                invoice?.equipmentCost ==0?
                                  "تم اتمام الطلب بدون فاتورة"
        :
                                  "تم اضافة فاتورة بقيمة ${invoice?.equipmentCost} ريال"),
                            const SizedBox(
                              height: 10,
                            ),
                            ImagesPicker(
                              attachments: invoice?.attachments! ?? [],
                              onImagePicked: (images) {
                                pickedImages = images;
                                setState(() {});
                              },
                            ),
                            const Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.only(right: 30.0),
                                child: Text("اضف مبلغ فاتوره المشتريات",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: AppColors.primaryColor)),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: AppColors.grayWhite,
                                ),
                              ),
                              height: 50.0,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: costController,
                                  decoration: const InputDecoration(
                                    hintText: "التكلفات الإضافية",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            whiteButtonTile(
                              small: true,
                              color: AppColors.blackGrey,
                              title: invoice != null ? "تعديل" : "تاكيد",
                              context: context,
                              pressed: () async {
                                if (invoice == null) {
                                  result = await ref
                                      .read(invoiceNotifierProvider.notifier)
                                      .createInvoice(
                                        project_id:
                                            widget.proposal.project!.id!,
                                        equipment_cost:
                                            costController.value.text != ""
                                                ? int.parse(
                                                    costController.value.text)
                                                : 0,
                                        note: notesController.value.text,
                                        attachments: pickedImages,
                                      );

                                  if (result != null) {
                                    ref
                                        .read(chatNotifierProvider.notifier)
                                        .sendMessage(
                                          "قام فني ديزل بإصدار فاتورة , تكلفة المشتريات ${result.equipmentCost} و تكلفة مصنعية الفني ${result.projectCost}",
                                          "invoice",
                                          ref
                                                  .read(authNotifierProvider)
                                                  .user!
                                                  .id ??
                                              0,
                                          widget.proposal.customer?.id ?? 0,
                                          widget.proposal.id ?? 0,
                                        )
                                        .then((value) => ref
                                            .read(chatNotifierProvider.notifier)
                                            .sendNotification(
                                              widget.proposal.customer
                                                      ?.firebase_token ??
                                                  "",
                                              ref
                                                      .read(
                                                          authNotifierProvider)
                                                      .user!
                                                      .name ??
                                                  "",
                                              "فاتورة جديدة",
                                            ));
                                    // Navigator.pop(context, result);

                                    AppSnackbar.show(
                                        buildSnackBar(
                                            text: 'تم انشاء الفاتورة بنجاح',
                                            backgroundColor: Colors.green));
                                  }
                                } else {
                                  result = await ref
                                      .read(invoiceNotifierProvider.notifier)
                                      .updateInvoice(
                                          invoice_id: invoice!.id!,
                                          equipment_cost:
                                              costController.value.text != ""
                                                  ? int.parse(
                                                      costController.value.text)
                                                  : 0,
                                          note: notesController.value.text,
                                          attachments: pickedImages,
                                          methods: "PUT");

                                  if (result != null) {
                                    ref
                                        .read(chatNotifierProvider.notifier)
                                        .sendMessage(
                                          "قام فني ديزل بتعديل الفاتورة , تكلفة المشتريات " +
                                              result.equipmentCost.toString() +
                                              " و تكلفة مصنعية الفني " +
                                              result.projectCost.toString(),
                                          "invoice",
                                          ref
                                                  .read(authNotifierProvider)
                                                  .user!
                                                  .id ??
                                              0,
                                          widget.proposal.customer?.id ?? 0,
                                          widget.proposal.id ?? 0,
                                        )
                                        .then((value) => ref
                                            .read(chatNotifierProvider.notifier)
                                            .sendNotification(
                                              widget.proposal.customer
                                                      ?.firebase_token ??
                                                  "",
                                              ref
                                                      .read(
                                                          authNotifierProvider)
                                                      .user!
                                                      .name ??
                                                  "",
                                              "تعديل الفاتورة",
                                            ));

                                    ScaffoldMessenger.of(context).showSnackBar(
                                        buildSnackBar(
                                            text: 'تم تعديل الفاتورة بنجاح',
                                            backgroundColor: Colors.green));
                                  }
                                }
                                ref
                                    .read(invoiceNotifierProvider.notifier)
                                    .getInvoice(
                                        projectId:
                                            widget.proposal.project!.id!);
                              },
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            if (invoice == null)
                            SizedBox(
                              child: whiteButtonTile(
                                color: AppColors.green6E,
                                title:"اتمام الطلب بدون فاتورة" ,
                                textColor: Colors.white,
                                context: context,
                                pressed: () async {
                                    result = await ref
                                        .read(invoiceNotifierProvider.notifier)
                                        .createInvoice(
                                      project_id:
                                      widget.proposal.project!.id!,
                                      equipment_cost:0,
                                      note: notesController.value.text,
                                      attachments: pickedImages,
                                    );

                                    if (result != null) {
                                      ref
                                          .read(chatNotifierProvider.notifier)
                                          .sendMessage(
                                        "قام فني ديزل باتمام الطلب " ,
                                        "invoice",
                                        ref
                                            .read(authNotifierProvider)
                                            .user!
                                            .id ??
                                            0,
                                        widget.proposal.customer?.id ?? 0,
                                        widget.proposal.id ?? 0,
                                      )
                                          .then((value) => ref
                                          .read(chatNotifierProvider.notifier)
                                          .sendNotification(
                                        widget.proposal.customer
                                            ?.firebase_token ??
                                            "",
                                        ref
                                            .read(
                                            authNotifierProvider)
                                            .user!
                                            .name ??
                                            "",
                                        "اتمام الطلب",
                                      ));
                                      Navigator.pop(context, result);

                                      ScaffoldMessenger.of(context).showSnackBar(
                                          buildSnackBar(
                                              text: 'تم اتمام الطلب بنجاح',
                                              backgroundColor: Colors.green));
                                    }

                                  ref
                                      .read(invoiceNotifierProvider.notifier)
                                      .getInvoice(
                                      projectId:
                                      widget.proposal.project!.id!);
                                },
                              ),
                            ),
                          ],
                        )
                      ] else ...[
                        GestureDetector(
                          onTap: () async {
                            var res = await ref
                                .read(invoiceNotifierProvider.notifier)
                                .getInvoicePdf(invoice!.id!);
                            if (res != null) {
                              final Uri url = Uri.parse(res ?? "");
                              if (!await launchUrl(url)) {
                                throw Exception('Could not launch pdf');
                              }
                            }
                          },
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text("تحميل الفاتوره",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: AppColors.primaryColor)),
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              ));
  }
}

String getPropjectStatusAr(String? state) {
  String text = 'مفتوح';
  switch (state) {
    case 'opened':
      text = 'مفتوح';
      break;
    case 'progress':
      text = "جاري التنفيذ";
      break;
    case 'closed':
      text = "مغلق";
      break;
    case 'cancelled':
      text = "ملغي";
      break;
    case 'completed':
      text = "تم استلام المبلغ";
    case 'under_review':
      text = " انتظار الدفع من العميل";
    default:
      text = 'مفتوح';
  }
  return text;
}
