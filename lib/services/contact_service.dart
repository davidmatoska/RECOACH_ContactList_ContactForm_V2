import 'package:fluttertodolistsqfliteapp/models/contact.dart';
import 'package:fluttertodolistsqfliteapp/repositories/repository.dart';

class ContactService {
  Repository _repository;

  ContactService() {
    _repository = Repository();
  }

  // create contacts
  saveContact(Contact contact) async {
    return await _repository.insertData('contacts', contact.contactMap());
  }

  // read contacts
  readContacts() async {
    return await _repository.readData('contacts');
  }

  // read contacts by category
  readContactsByCategory(category) async {
    return await _repository.readDataByColumnName(
        'contacts', 'category', category);
  }
}
