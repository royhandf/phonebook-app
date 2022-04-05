import 'package:flutter/material.dart';
import 'package:phonebook/services/contacts.dart';
import 'package:phonebook/widgets/form_create_contact.dart';
import 'package:phonebook/models/contact.dart';
import 'package:phonebook/services/contacts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final contactServices = ContactService();
  late Future<List<Contact>> contacts;

  @override
  initState() {
    super.initState();
    contacts = contactServices.getAll();
  }

  onAddContact(BuildContext context, Contact contact) async {
    await contactServices.add(contact);
    setState(() {
      contacts = contactServices.getAll();
    });

    Navigator.of(context, rootNavigator: true).pop();
  }

  showAddContactForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Data Contact'),
        content: FormCreateContact(onAddContact: (Contact contact) {
          onAddContact(context, contact);
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phonebook'),
        actions: [
          Builder(
            builder: (context) => IconButton(
              onPressed: () {
                showAddContactForm(context);
              },
              icon: const Icon(Icons.add),
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: contacts,
        builder: (context, AsyncSnapshot<List<Contact>> result) {
          List<Contact> contactsFromFuture = result.data ?? [];
          return ListView.builder(
            itemCount: contactsFromFuture.length,
            itemBuilder: (context, i) {
              Contact contact = contactsFromFuture[i];
              return ListTile(
                title: Text(contact.name),
                subtitle: Text(contact.phone),
              );
            },
          );
        },
      ),
    );
  }
}
