import 'package:contact_apk/home_page.dart';
import 'package:contact_apk/widgets/build_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

import '../models/database_model.dart';

class ContactAddPage extends StatefulWidget {
  final ContactModel? editcontact;
  final bool is_Edit;
  final int? index;

  const ContactAddPage({
    super.key,
    this.editcontact,
    this.is_Edit = false,
    this.index,
  });

  @override
  State<ContactAddPage> createState() => _ContactAddPageState();
}

class _ContactAddPageState extends State<ContactAddPage> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  bool _isNameEntered = false;
  Box<ContactModel>? contactBox;

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.editcontact?.name ?? '');
    _phoneController =
        TextEditingController(text: widget.editcontact?.number ?? '');
    _emailController =
        TextEditingController(text: widget.editcontact?.email ?? '');

    // Add listener to monitor changes in the name field
    _nameController.addListener(_updateButtonState);

    contactBox = Hive.box<ContactModel>('contactBox');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _updateButtonState() {
    setState(() {
      _isNameEntered = _nameController.text.isNotEmpty;
    });
  }

  void _showSnackbar() {
    final snackBar = SnackBar(
      content: Text("Field is empty. Please enter a name."),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _saveContact() async {
    // Check if the name field is empty
    if (_nameController.text.isEmpty) {
      _showSnackbar();
      return;
    }

    final newContact = ContactModel(
      name: _nameController.text,
      number: _phoneController.text,
      email: _emailController.text,
      isFavorite: widget.editcontact?.isFavorite ?? false,
    );

    if (widget.is_Edit) {
      contactBox?.putAt(widget.index!, newContact);
    } else {
      contactBox?.add(newContact);
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BuildTextWidget(
              text: widget.is_Edit ? 'Edit Contact' : 'Add Contact',
              fontsize: 20,
              fontcolor: Colors.white,
            ),
            IconButton(
              onPressed: _saveContact,
              icon: Icon(
                size: 35,
                Icons.save,
                color: _isNameEntered ? Colors.white : Colors.grey,
              ),
            ),
          ],
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.indigo,
              child: Icon(
                Icons.person,
                size: 70,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.indigo),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.indigo),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  labelText: 'Name',
                  labelStyle: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _phoneController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                ],
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.phone),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.indigo),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.indigo),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  labelText: 'Number',
                  labelStyle: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.indigo),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.indigo),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  labelText: 'Email',
                  labelStyle: TextStyle(fontSize: 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}