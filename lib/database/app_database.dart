import 'package:bytebank_final/models/contact_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> createDatabase() {
  return getDatabasesPath().then(
    (dbPath) {
      final String path = join(dbPath, 'bytebank.db');
      return openDatabase(path, onCreate: (db, version) {
        db.execute(
            'CREATE TABLE Contacts(id INTEGER PRIMARY KEY, name TEXT, account_number INTEGER)');
      }, version: 1);
    },
  );
}

Future<int> save(Contact contact) {
  return createDatabase().then((db) {
    final Map<String, dynamic> contactMap = Map();
    contactMap['id'] = contact.id;
    contactMap['name'] = contact.id;
    contactMap['account_number'] = contact.id;
    return db.insert('Contacts', contactMap);
  });
}

Future<List<Contact>> findAll() {
  return createDatabase().then(
    (db) {
      return db.query('contacts').then(
        (maps) {
          final List<Contact> contacts = List();
          for (Map<String, dynamic> map in maps) {
            final Contact contact = Contact(
              map['id'],
              map['name'],
              map['account_name'],
            );
            contacts.add(contact);
          }
          return contacts;
        },
      );
    },
  );
}