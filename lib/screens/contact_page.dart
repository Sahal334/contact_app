import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/database_model.dart';
import '../widgets/build_container_widget.dart';
import '../widgets/build_text_widget.dart';
import 'contact_add_page.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  late Box<ContactModel> contactBox;
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    contactBox = Hive.box<ContactModel>('contactBox');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldMessengerKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.indigo,
        title: BuildTextWidget(
          text: "Contacts",
          fontsize: 20,
          fontcolor: Colors.white,
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: contactBox.listenable(),
        builder: (context, Box<ContactModel> box, _) {
          if (box.isEmpty) {
            return Center(
              child: BuildTextWidget(
                text: 'No Contacts',
                fontsize: 20,
                fontcolor: Colors.grey,
              ),
            );
          }

          List<ContactModel> contacts =
              box.values.toList().cast<ContactModel>();
          contacts.sort((a, b) => a.name.compareTo(b.name));

          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contact = contacts[index];

              return Dismissible(
                key: Key('${contact.name}_$index'),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) async {
                  await box.deleteAt(index);
                },
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                child: BuildContainerWidget(
                  contactModel: contact,
                  index: index,
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ContactAddPage()),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
