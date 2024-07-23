import 'package:contact_apk/models/database_model.dart';
import 'package:contact_apk/screens/contact_view_page.dart';
import 'package:contact_apk/widgets/build_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  Box<ContactModel>? contactBox;

  @override
  void initState() {
    super.initState();
    contactBox = Hive.box<ContactModel>('contactBox');
  }

  List<ContactModel> getFavorites() {
    return contactBox!.values.where((contact) => contact.isFavorite).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<ContactModel> favoritesList = getFavorites();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: BuildTextWidget(
          text: "Favorites",
          fontsize: 20,
          fontcolor: Colors.white,
        ),
        backgroundColor: Colors.indigo,
      ),
      body: favoritesList.isEmpty
          ? Center(
              child: BuildTextWidget(
                text: 'No favorite contacts.',
                fontsize: 18,
                fontcolor: Colors.grey,
              ),
            )
          : ListView.builder(
              itemCount: favoritesList.length,
              itemBuilder: (context, index) {
                final contact = favoritesList[index];
                return ListTile(
                  title: BuildTextWidget(
                    text: contact.name,
                    fontsize: 18,
                    fontcolor: Colors.indigo,
                  ),
                  subtitle: BuildTextWidget(
                    text: contact.number,
                    fontsize: 14,
                    fontcolor: Colors.black,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactViewPage(
                          viewmodel: contact,
                          index: contactBox!.values.toList().indexOf(contact),
                        ),
                      ),
                    ).then((_) {
                      setState(() {});
                    });
                  },
                );
              },
            ),
    );
  }
}
