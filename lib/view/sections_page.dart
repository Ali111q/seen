import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:seen/controller/home_controller.dart';
import 'package:seen/model/tag.dart';
import 'package:seen/view/home.dart';

class SectionsPage extends StatefulWidget {
  const SectionsPage({super.key});

  @override
  State<SectionsPage> createState() => _SectionsPageState();
}

class _SectionsPageState extends State<SectionsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<HomeController>(context, listen: false).getCats();
  }

  @override
  Widget build(BuildContext context) {
    List<Tag> tags = Provider.of<HomeController>(context).catTags;

    return SingleChildScrollView(
      child: Column(
        children: [
          ...tags.map((e) => SectionWidget(
                tag: e,
                section: '',
              ))
        ],
      ),
    );
  }
}
