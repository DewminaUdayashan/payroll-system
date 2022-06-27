import 'package:flutter/material.dart';

import '../departments_page/widgets/departmet_title.dart';

class DesignationPage extends StatefulWidget {
  const DesignationPage({Key? key}) : super(key: key);

  @override
  State<DesignationPage> createState() => _DesignationPageState();
}

class _DesignationPageState extends State<DesignationPage> {
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: scrollController,
      thumbVisibility: true,
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverPersistentHeader(
            delegate: DepartmentTitleBar(isDesignationView: true),
            floating: true,
          ),
          const SliverToBoxAdapter(),
        ],
      ),
    );
  }
}
