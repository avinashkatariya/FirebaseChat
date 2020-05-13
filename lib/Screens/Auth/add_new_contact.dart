import 'package:FirebaseChat/Models/User.dart';
import 'package:FirebaseChat/Services/database.dart';
import 'package:FirebaseChat/Widgets/Chat/add_contact.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class AddNewContact extends StatefulWidget {
  final User user;

  const AddNewContact({Key key, this.user}) : super(key: key);
  @override
  _AddNewContactState createState() => _AddNewContactState();
}

class _AddNewContactState extends State<AddNewContact> {

  
  List<User> _fcContacts;

  @override
  void initState() {
    getContacts();
    super.initState();
  }

  Future<void> getContacts() async {
    final Iterable<Contact> contacts = await ContactsService.getContacts();
    
    List<String> phoneNumbers = [];
    for (var contact in contacts) {
      Iterable<Item> phones = contact.phones;
      for (var phone in phones) {
        if (phone.value.replaceAll(" ", "").length == 13){
          phoneNumbers.add(phone.value.replaceAll(" ", ""));
        }
      }
    }
    
    List<User> fcContacts = await DatabaseService().getValidContacts(phoneNumbers);
    setState(() {
      _fcContacts = fcContacts;
    });


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: (Text('Contacts')),
      ),
      body: _fcContacts != null
          ? ListView.builder(
              itemCount: _fcContacts.length+1,
              itemBuilder: (BuildContext context, int index) {
                if(index == 0){
                  return AddContactTile0();
                }
                User user0 = _fcContacts[index-1];
                return AddContactTile(user: user0,me:widget.user,itag:index);
              },
            )
          : Center(child: const CircularProgressIndicator()),
    );
  }
}
