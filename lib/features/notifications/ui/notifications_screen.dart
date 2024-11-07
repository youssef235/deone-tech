import 'package:cached_network_image/cached_network_image.dart';
import 'package:wasq_tech/app/routes.dart';
import 'package:wasq_tech/features/invoice/data/provider/invoice_provider.dart';
import 'package:wasq_tech/features/notifications/data/model/notification_response.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../theme/app_assets.dart';
import '../../../theme/app_colors.dart';
import '../../../utils/utils.dart';
import '../data/providers/notification_provider.dart';

class NotificationsScreen extends StatefulHookConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  final RefreshController _controller = RefreshController();
  int pageIndex = 0;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0), () {
      ref.read(invoiceNotifierProvider.notifier).clearInvoice();
      ref.read(notificationsNotifierProvider.notifier).getNotificationsData();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ref.watch(notificationsNotifierProvider).loading
            ? ListView.separated(
                itemCount: 10,
                itemBuilder: (context, index) => Container(
                  width: double.infinity,
                  height: 100,
                  color: Colors.grey[100],
                ),
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              )
            : ref
                    .read(notificationsNotifierProvider)
                    .notificationsResponse
                    .proposals!
                    .isEmpty
                ? const Center(
                    child: Text('لا يوجد إشعارات'),
                  )
                : Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: ListView.separated(
                      itemCount: ref
                              .read(notificationsNotifierProvider)
                              .notificationsResponse
                              .proposals
                              ?.length ??
                          0,
                      itemBuilder: (context, index) => NotificationItem(
                        proposal: ref
                            .read(notificationsNotifierProvider)
                            .notificationsResponse
                            .proposals![index],
                      ),
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                    ),
                  ));
  }
}

class NotificationItem extends ConsumerWidget {
  final Proposals proposal;

  const NotificationItem({Key? key, required this.proposal}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: proposal.status == "accepted"
          ? () {
        Navigator.pushNamed(context, Routes.notificationItem, arguments: proposal).then((refresh) {
          ref.read(notificationsNotifierProvider.notifier).getNotificationsData();
          ref.read(invoiceNotifierProvider.notifier).clearInvoice();
        });
      }
          : null,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.symmetric(horizontal: 3.0),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey, width: 1),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "اسم العميل: ${proposal.customer?.name ?? "غير معروف"}",
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'منذ ',
                      style: TextStyle(color: AppColors.black, fontSize: 11),
                    ),
                    Text(
                      getTimeDifference(DateTime.parse(proposal.created_at ?? "2023-10-21T09:18:23.000000Z")),
                      style: TextStyle(color: AppColors.black, fontSize: 11),
                    ),
                  ],
                ),
                Text(
                  proposal.project?.name ?? "بدون مشروع",
                  style: TextStyle(color: AppColors.black, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: proposal.status == "accepted"
                        ? getStatusForProject(proposal.project?.status ?? "")?.statusColor ?? Colors.grey
                        : getStatusForProposal(proposal.status!)?.statusColor ?? Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Text(
                    proposal.status == "accepted"
                        ? getStatusForProject(proposal.project?.status ?? "")?.statusTitle ?? "غير معروف"
                        : getStatusForProposal(proposal.status!)?.statusTitle ?? "غير معروف",
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${proposal.status ?? "غير معروف"}',
                  style: TextStyle(color: AppColors.black, fontSize: 11),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'السعر ',
                      style: TextStyle(color: AppColors.black, fontSize: 11),
                    ),
                    Text(
                      '${(proposal.price!.toDouble() + proposal.project!.equipment_cost.toDouble()).toStringAsFixed(2)} ريال',
                      style: TextStyle(color: AppColors.black, fontSize: 11),
                    ),
                  ],
                ),
                const Icon(Icons.arrow_forward_ios),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class StatusModel {
  final String statusTitle;
  final Color statusColor;

  StatusModel({required this.statusTitle, required this.statusColor});
}

StatusModel? getStatusForProject(String status) {
  switch (status) {
    case "pending":
      return StatusModel(statusTitle: "الانتظار", statusColor: Colors.grey);
    case "opened":
      return StatusModel(
          statusTitle: "في انتظار تلقي العروض ", statusColor: Colors.blueGrey);
    case "closed":
      return StatusModel(
          statusTitle: "تم اغلاق المشروع من العميل ", statusColor: Colors.red);
    case "cancelled":
      return StatusModel(
          statusTitle: "تم الإلغاء ", statusColor: Colors.redAccent);
    case "progress":
      return StatusModel(
          statusTitle: "المشروع قيد التنفيذ للعميل ",
          statusColor: Colors.orange);
    case "under_review":
      return StatusModel(
          statusTitle: "في انتظار الدفع من العميل ", statusColor: Colors.blue);
    case "completed":
      return StatusModel(
          statusTitle: "تم الانتهاء من مشروع العميل ",
          statusColor: Colors.green);
    default:
      return StatusModel(statusTitle: status, statusColor: Colors.cyan);
  }
}

StatusModel? getStatusForProposal(String status) {
  switch (status) {
    case "wait":
      return StatusModel(
          statusTitle: "في انتظار قبول عرضك من العميل",
          statusColor: Colors.grey);
    case "accepted":
      return StatusModel(
          statusTitle: "تم قبول عرضك من العميل ", statusColor: Colors.green);
    case "refused":
      return StatusModel(
          statusTitle: "تم قبول عرض اخر بسعر أقل ", statusColor: Colors.red);
    default:
      return StatusModel(statusTitle: status, statusColor: Colors.red);
  }
}
