import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/database_model.dart';
import '../models/responsive.dart';
import '../screens/contact_add_page.dart';
import '../widgets/build_text_widget.dart';

class ContactViewPage extends StatefulWidget {
  ContactModel viewmodel;
  final int index;
  ContactViewPage({
    super.key,
    required this.viewmodel,
    required this.index,
  });

  @override
  State<ContactViewPage> createState() => _ContactViewPageState();
}

class _ContactViewPageState extends State<ContactViewPage> {
  Box<ContactModel>? contactBox;

  @override
  void initState() {
    super.initState();
    contactBox = Hive.box<ContactModel>('contactBox');
  }

  void toggleFavorite() async {
    setState(() {
      widget.viewmodel.isFavorite = !widget.viewmodel.isFavorite;
    });
    await contactBox?.putAt(widget.index, widget.viewmodel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(219, 253, 249, 249),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BuildTextWidget(
                text: "View", fontsize: 20, fontcolor: Colors.white),
            SizedBox(
              width: screenWidth(context, dividedBy: 3),
            ),
            IconButton(
              icon: Icon(
                size: 35,
                widget.viewmodel.isFavorite ? Icons.star : Icons.star_border,
                color: Colors.white,
              ),
              onPressed: toggleFavorite,
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ContactAddPage(
                                is_Edit: true,
                                index: widget.index,
                                editcontact: ContactModel(
                                    name: widget.viewmodel.name,
                                    number: widget.viewmodel.number,
                                    email: widget.viewmodel.email,
                                    isFavorite: widget.viewmodel.isFavorite),
                              )));
                },
                icon: Icon(
                  Icons.edit_note_sharp,
                  color: Colors.white,
                  size: 40,
                ))
          ],
        ),
        backgroundColor: Colors.indigo,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              color: Colors.white,
            )),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.indigo,
            height: screenHeight(context, dividedBy: 3.7),
            width: screenWidth(context, dividedBy: 1),
            child: Column(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 150,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BuildTextWidget(
                        text: widget.viewmodel.name,
                        fontsize: 20,
                        fontcolor: Colors.white),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              height: screenHeight(context, dividedBy: 11),
              width: screenWidth(context, dividedBy: 1),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.phone),
                    ),
                    BuildTextWidget(
                      text: widget.viewmodel.number,
                      fontsize: 15,
                      fontcolor: Colors.indigo,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              height: screenHeight(context, dividedBy: 11),
              width: screenWidth(context, dividedBy: 1),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.mail),
                    ),
                    BuildTextWidget(
                      text: widget.viewmodel.email,
                      fontsize: 15,
                      fontcolor: Colors.indigo,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
