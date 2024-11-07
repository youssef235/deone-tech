import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:wasq_tech/features/home/data/models/home_response.dart';
import 'package:wasq_tech/theme/app_assets.dart';
import 'package:wasq_tech/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:geolocator/geolocator.dart';

import '../../../app/notifications_handler.dart';
import '../../../app/routes.dart';
import '../../../app/widgets/animation/shimmer/shimmer_loading_anim.dart';
import '../../../utils/utils.dart';
import '../../auth/data/providers/auth_provider.dart';
import '../data/providers/home_provider.dart';

class HomeScreen extends StatefulHookConsumerWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  final RefreshController _controller = RefreshController();
  int pageIndex = 1;
  double lang = 360;
  double lat = 360;
  late Timer _timer;
  StreamSubscription<PushNotificationEvent>? _notificationSubscription;

  late Position currentLocation;
  bool isAvailable = false;

  Future<void> getPos() async {
    currentLocation =
        await Geolocator.getCurrentPosition().then((value) => value);

    setState(() {
      lat = currentLocation.latitude;
      lang = currentLocation.longitude;
    });

    print("lat : $lat");
    print("lang : $lang");
  }

  Future getPer() async {
    LocationPermission per;

    per = await Geolocator.checkPermission();
    if (per == LocationPermission.denied) {
      setState(() {
        lat = 360;
        lang = 360;
      });

      bool userAgreed = await showDialogForRequestPermission(context);

      if (userAgreed) {
        per = await Geolocator.requestPermission();
      } else if (per == LocationPermission.whileInUse ||
          per == LocationPermission.always ||
          per == LocationPermission.unableToDetermine) {
        await getPos();
      }
    } else {
      await getPos();
    }

    ref.read(homeNotifierProvider.notifier).getHomeData(
          perPage: 10,
          page: pageIndex,
          lang: lang == 360 ? 46.738586 : lang,
          lat: lat == 360 ? 24.774265 : lat,
        );
    setState(() {});

    //   return per == LocationPermission.whileInUse;
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0), () async {
      isAvailable = ref.watch(authNotifierProvider).user?.active == 'on';
      ref.read(authNotifierProvider.notifier).getStatics();
      await ref.read(homeNotifierProvider.notifier).setStateLoading(true);
      await getPer();
    });

    _timer = Timer.periodic(const Duration(seconds: 10), (Timer t) {
      _onRefresh();
      getPos();
    });

    super.initState();

    _notificationSubscription =
        eventBus.on<PushNotificationEvent>().listen((event) async {
      if (event.notificationMessage.title == "وصلك طلب جديد") {
        _onRefresh();
        getPos();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final homeProvider = ref.watch(homeNotifierProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            "مرحبا بك! ${ref.read(authNotifierProvider).user?.name}",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            homeProvider.slidersLoading
                ? ShimmerLoadingAnim(
                    isLoading: homeProvider.slidersLoading,
                    child: CarouselSlider(
                      items: [
                        Container(
                          color: Colors.blue,
                          child: const Center(child: Text("Slide 1")),
                        ),
                        Container(
                          color: Colors.red,
                          child: const Center(child: Text("Slide 2")),
                        ),
                        Container(
                          color: Colors.green,
                          child: const Center(child: Text("Slide 3")),
                        ),
                      ],
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        viewportFraction: 1.0,
                        height: 200.0,
                        autoPlay: true,
                      ),
                    ),
                  )
                : CarouselSlider(
                    items: homeProvider.sliders
                        ?.map((slideUrl) {
                      print("inner $slideUrl");
                      return Container(
                          padding: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: slideUrl,
                              placeholder: (context, url) => Image.asset(
                                  AppAssets.recLogo,
                                  fit: BoxFit.fitWidth),
                              errorWidget: (context, url, error) => Image.asset(
                                  AppAssets.recLogo,
                                  fit: BoxFit.cover),
                            ),
                          ));
                    }).toList(),
                    options: CarouselOptions(
                      enlargeCenterPage: true,
                      viewportFraction: 1.0,
                      height: 200.0,
                      autoPlay: true,
                    ),
                  ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.5,
                  ),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(
                        5.0), // Adjust the value to change the curvature
                  ),
                  child: Text(
                    "رصيدك الحالي : ${ref.read(authNotifierProvider).user?.balance} ريال",
                    style: const TextStyle(color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                FlutterSwitch(
                  activeToggleColor: AppColors.primaryColor,
                  inactiveToggleColor: AppColors.white,
                  activeColor: Colors.black,
                  inactiveColor: Colors.black,
                  width: 100.0,
                  activeText: "متاح",
                  activeTextColor: Colors.white,
                  inactiveTextColor: Colors.white,
                  inactiveText: "غير متاح",
                  height: 40.0,
                  valueFontSize: 15.0,
                  toggleSize: 30.0,
                  value: isAvailable,
                  showOnOff: true,
                  borderRadius: 90.0,
                  padding: 8.0,
                  onToggle: (val) {
                    setState(() {
                      isAvailable = val;

                      var on_off = !isAvailable ? "off" : "on";
                      ref.read(authNotifierProvider.notifier).onOff(
                            active: on_off,
                          );
                    });
                  },
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "الطلبات",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            (lang == 360 && lang == 360)
                ? Center(
                    child: Column(
                      children: [
                        const Text("لعرض الطلبات يجب تشغل خدمات الموقع"),
                        TextButton(
                            onPressed: () {
                              showAlertDialog(context);
                            },
                            child: const Text("فعل خدمات الموقع"))
                      ],
                    ),
                  )
                : isAvailable
                    ? Expanded(
                        child: SizedBox(
                          height: 300,
                          child: SmartRefresher(
                            controller: _controller,
                            enablePullDown: true,
                            enablePullUp: true,
                            footer: const ClassicFooter(
                              loadingText: 'قم بتحميل المزيد من الطلبات',
                            ),
                            onLoading: _onLoading,
                            onRefresh: _onRefresh,
                            child: homeProvider.providerProposalsResponse
                                        .have_project ==
                                    true
                                ? const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Center(
                                      child: Text(
                                          "انتهي من مشروعك الحالي حتي تتمكن من تلقي طلبات جديده"),
                                    ),
                                  )
                                : homeProvider.providerProposalsResponse
                                        .projects!.isEmpty
                                    ? const Center(
                                        child: Text("لا يوجد طلبات الان"),
                                      )
                                    : ListView.separated(
                                        itemCount: homeProvider
                                            .providerProposalsResponse
                                            .projects!
                                            .length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            width: double.infinity,
                                            height: 200,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.6,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Text(
                                                              'العميل ',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black54,
                                                                  fontSize: 14),
                                                            ),
                                                            SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.4,
                                                              child: Text(
                                                                // Calculate the time difference from notification.date to now
                                                                homeProvider
                                                                        .providerProposalsResponse
                                                                        .projects?[
                                                                            index]
                                                                        .customer
                                                                        ?.name ??
                                                                    "",
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                .039),
                                                        Row(
                                                          children: [
                                                            const Text(
                                                              'منذ ',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black54,
                                                                  fontSize: 14),
                                                            ),
                                                            SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.4,
                                                              child: Text(
                                                                // Calculate the time difference from notification.date to now
                                                                getTimeDifference(DateTime.parse(homeProvider
                                                                        .providerProposalsResponse
                                                                        .projects?[
                                                                            index]
                                                                        .created_at ??
                                                                    "2023-10-21T09:18:23.000000Z")),
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black54,
                                                                    fontSize:
                                                                        14),
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                .039),
                                                        Row(
                                                          children: [
                                                            const Text(
                                                              'الخدمة ',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black54,
                                                                  fontSize: 14),
                                                            ),
                                                            SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.4,
                                                              child: Text(
                                                                homeProvider
                                                                        .providerProposalsResponse
                                                                        .projects?[
                                                                            index]
                                                                        .name ??
                                                                    "",
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 14,
                                                                ),
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                .039),
                                                        Text(homeProvider
                                                            .providerProposalsResponse
                                                            .projects![index]
                                                            .id
                                                            .toString()),
                                                        Row(
                                                          children: [
                                                            const Text(
                                                              'يبعد عنك ب ',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black54,
                                                                  fontSize: 14),
                                                            ),
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.4,
                                                              child: Text(
                                                                homeProvider
                                                                            .providerProposalsResponse
                                                                            .projects?[index]
                                                                            .distance_from_me
                                                                            ?.toFixedAmount() +
                                                                        "كم" ??
                                                                    "",
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 14,
                                                                ),
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  getStateWidget(
                                                      homeProvider
                                                              .providerProposalsResponse
                                                              .projects?[index]
                                                              .status ??
                                                          "",
                                                      context,
                                                      homeProvider
                                                          .providerProposalsResponse
                                                          .projects![index]),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return const SizedBox(
                                            height: 10,
                                          );
                                        },
                                      ),
                          ),
                        ),
                      )
                    : const Center(
                        child: Text(
                            "قم بتفعيل زر استقبال الطلبات لتلقي طلبات جديده"),
                      )
          ],
        ),
      ),
    );
  }

  void _onRefresh() async {
    pageIndex = 1;
    await loadData();
    _controller.refreshCompleted();
  }

  void _onLoading() async {
    final provider = ref.read(homeNotifierProvider);

    if (provider.providerProposalsResponse.projects?.length ==
        provider.providerProposalsResponse.total) {
      _controller.loadNoData();
    } else {
      if (pageIndex == 1) pageIndex++;
      pageIndex++;
      await loadData();
      _controller.loadComplete();
    }
  }

  loadData() async {
    await ref.read(homeNotifierProvider.notifier).getHomeData(
          perPage: 10,
          page: pageIndex,
          lang: lang,
          lat: lat,
        );
  }

  Widget getStateWidget(String state, BuildContext context, Projects project) {
    String text = "";
    Color color = Colors.white;
    switch (state) {
      case 'opened':
        return project.have_a_proposal == true
            ? Container(
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.height * 0.068,
                decoration: BoxDecoration(
                  color: AppColors.blue,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.requestServiceScreen,
                            arguments: {"project": project, "edit": true})
                        .then((value) => {_onRefresh()});
                  },
                  child: const Text(
                    'عدل طلبك',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            : Container(
                //width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.height * 0.068,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.requestServiceScreen,
                        arguments: {"project": project, "edit": false});
                  },
                  child: const Text(
                    'قدم طلب',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
      case 'progress':
        text = "جاري التنفيذ";
        color = AppColors.blue;
        break;
      case 'closed':
        text = "مغلق";
        color = Colors.black54;
        break;
      case 'cancelled':
        text = "ملغي";
        color = AppColors.red;
        break;
      case 'completed':
        text = "مكتمل";
        color = AppColors.green6E;
        break;
      default:
        // Handle the case when the state is not one of the expected values
        return Container(); // Return an empty container or handle it differently
    }
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.requestServiceScreen,
            arguments: {"project": project, "edit": false});
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.25,
        height: MediaQuery.of(context).size.height * 0.068,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.transparent, // Change color as needed
          border: Border.all(color: color), // Add border
        ),
        child: Center(
          child: Text(
            text, // Change text as needed
            style: TextStyle(
              fontSize: 16,
              color: color, // Change text color as needed
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
