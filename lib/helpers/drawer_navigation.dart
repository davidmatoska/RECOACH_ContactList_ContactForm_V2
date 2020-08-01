import 'package:flutter/material.dart';
import 'package:fluttertodolistsqfliteapp/screens/categories_screen.dart';
import 'package:fluttertodolistsqfliteapp/screens/home_screen.dart';
import 'package:fluttertodolistsqfliteapp/screens/contacts_by_category.dart';
import 'package:fluttertodolistsqfliteapp/services/category_service.dart';

import 'package:fluttertodolistsqfliteapp/screens/chart_screen.dart';

class DrawerNavigation extends StatefulWidget {
  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  List<Widget> _categoryList = List<Widget>();

  CategoryService _categoryService = CategoryService();

  @override
  initState() {
    super.initState();
    getAllCategories();
  }

  getAllCategories() async {
    var categories = await _categoryService.readCategories();

    categories.forEach((category) {
      setState(() {
        _categoryList.add(InkWell(
          onTap: () => Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new ContactsByCategory(category: category['name'],))),
          child: ListTile(
            title: Text(category['name']),
          ),
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            /*UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcReESg1I_zS8o7w3pIlek4xSp40-TtFhWcyCh_Xv7HsqhnExuI1&usqp=CAU'),
              ),
              accountName: Text('Abdul Aziz Ahwan'),
              accountEmail: Text('admin@abdulazizahwan'),
              decoration: BoxDecoration(color: Colors.deepPurple),
            ),*/
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeScreen())),
            ),
            ListTile(
              leading: Icon(Icons.view_list),
              title: Text('Categories'),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CategoriesScreen())),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.show_chart),
              title: Text('Charts'),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ChartScreen())),
            ),
            /*Column(
              children: _categoryList,
            ),*/
          ],
        ),
      ),
    );
  }
}
