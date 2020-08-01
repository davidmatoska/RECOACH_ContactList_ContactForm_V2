import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertodolistsqfliteapp/helpers/drawer_navigation.dart';
import 'package:fluttertodolistsqfliteapp/models/contact.dart';
import 'package:fluttertodolistsqfliteapp/screens/contact_screen.dart';
import 'package:fluttertodolistsqfliteapp/services/contact_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ContactService _contactService;

  List<Contact> _contactList = List<Contact>();

  @override
  initState() {
    super.initState();
    getAllContacts();
  }

  getAllContacts() async {
    _contactService = ContactService();
    _contactList = List<Contact>();

    var contacts = await _contactService.readContacts();

    contacts.forEach((contact) {
      setState(() {
        var model = Contact();
        model.id = contact['id'];
        model.total = contact['total'];
        model.category = contact['category'];
        model.contactDate = contact['contactDate'];
        _contactList.add(model);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact List'),
      ),
      drawer: DrawerNavigation(),
      body: ListView.builder(
          itemCount: _contactList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(top:8.0, left: 8.0, right: 8.0),
              child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(_contactList[index].total ?? 'No Total')
                      ],
                    ),
                    subtitle: Text(_contactList[index].category ?? 'No Category'),
                    trailing: Text(_contactList[index].contactDate ?? 'No Date'),
                  )),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ContactScreen())),
        child: Icon(Icons.add),
      ),
    );
  }
}
