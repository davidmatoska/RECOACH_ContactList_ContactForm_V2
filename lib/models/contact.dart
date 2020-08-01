class Contact {
  int id;
  String total;
  String category;
  String contactDate;


  contactMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['total'] = total;
    mapping['category'] = category;
    mapping['contactDate'] = contactDate;


    return mapping;
  }
}
