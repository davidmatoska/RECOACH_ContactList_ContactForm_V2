import 'package:flutter/material.dart';
import 'package:fluttertodolistsqfliteapp/models/contact.dart';
import 'package:fluttertodolistsqfliteapp/services/contact_service.dart';

class ContactsByCategory extends StatefulWidget {
  final String category;

  ContactsByCategory({this.category});

  @override
  _ContactsByCategoryState createState() => _ContactsByCategoryState();
}

class _ContactsByCategoryState extends State<ContactsByCategory> {
  List<Contact> _contactList = List<Contact>();
  ContactService _contactService = ContactService();

  @override
  void initState() {
    super.initState();
    getContactsByCategories();
  }

  getContactsByCategories() async {
    var contacts = await _contactService.readContactsByCategory(this.widget.category);
    contacts.forEach((contact) {
      setState(() {
        var model = Contact();
        model.total = contact['total'];
        model.contactDate = contact['contactDate'];

        _contactList.add(model);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(this.widget.category)),
      body: Column(
        children: <Widget>[
          Expanded(
              child: ListView.builder(
                  itemCount: _contactList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                        elevation: 8,
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[Text(_contactList[index].total)],
                          ),
                //          subtitle: Text(_todoList[index].description),
                          trailing: Text(_contactList[index].contactDate),
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
