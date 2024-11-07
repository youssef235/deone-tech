import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WorkScreen extends StatefulHookConsumerWidget {
  const WorkScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<WorkScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: Center(child: Text("Work")),
    );
  }

  @override
  bool get wantKeepAlive => true;
}