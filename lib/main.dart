import 'package:flutter/material.dart';

void main() {
  runApp(const PhonebookApp());
}

class Contact {
  String name, phone;
  Contact({required this.name, required this.phone});
}

class PhonebookApp extends StatefulWidget {
  const PhonebookApp({Key? key}) : super(key: key);

  @override
  _PhonebookAppState createState() => _PhonebookAppState();
}

class _PhonebookAppState extends State<PhonebookApp> {
  var contacts = <Contact>[];

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  onAddContact() {
    if (formKey.currentState!.validate()) {
      setState(() {
        contacts.add(
            Contact(name: nameController.text, phone: phoneController.text));
      });
      nameController.clear();
      phoneController.clear();
    }
  }

  showAddContactForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Data Contact'),
        content: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  label: Text('Nama'),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (String? value) {
                  if (value == '' || value!.isEmpty) {
                    return 'Nama wajib diisi!';
                  }
                },
              ),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(
                  label: Text('Telepon'),
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
                validator: (String? value) {
                  if (value == '' || value!.isEmpty) {
                    return 'Telepon wajib diisi!';
                  }
                },
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text('Simpan'),
                  onPressed: () {
                    onAddContact();
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
        body: ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (context, i) {
            return ListTile(
              title: Text(contacts[i].name),
              subtitle: Text(contacts[i].phone),
            );
          },
        ),
      ),
    );
  }
}
