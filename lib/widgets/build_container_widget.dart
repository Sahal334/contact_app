import 'package:contact_apk/models/responsive.dart';
import 'package:contact_apk/screens/contact_view_page.dart';
import 'package:contact_apk/widgets/build_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/database_model.dart';

class BuildContainerWidget extends StatefulWidget {
  final ContactModel contactModel;
  final int index;
  const BuildContainerWidget({
    super.key,
    required this.index,
    required this.contactModel,
  });

  @override
  State<BuildContainerWidget> createState() => _BuildContainerWidgetState();
}

class _BuildContainerWidgetState extends State<BuildContainerWidget> {
  late Box<ContactModel> contactBox;

  @override
  void initState() {
    super.initState();
    contactBox = Hive.box<ContactModel>('contactBox');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ContactViewPage(
                      index: widget.index,
                      viewmodel: widget.contactModel,
                    ))).then((_) {
          setState(() {});
        });
      },
      child: Container(
        width: screenWidth(context, dividedBy: 1),
        height: screenHeight(context, dividedBy: 10),
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundColor: Colors.indigo,
                child: Icon(
                  Icons.person,
                  size: 35,
                  color: Colors.white38,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BuildTextWidget(
                    text: widget.contactModel.name,
                    fontsize: 15,
                    fontcolor: Colors.black,
                  ),
                  BuildTextWidget(
                    text: widget.contactModel.number,
                    fontsize: 15,
                    fontcolor: Colors.black,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
