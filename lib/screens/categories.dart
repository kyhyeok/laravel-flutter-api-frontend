import 'package:flutter/material.dart';
import 'package:flutter_api_frontend/models/Category.dart';
import 'package:flutter_api_frontend/providers/CategoryProvider.dart';
import 'package:flutter_api_frontend/widgets/CategoryAdd.dart';
import 'package:flutter_api_frontend/widgets/CategoryEdit.dart';
import 'package:provider/provider.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoryProvider>(context);
    List<Category> categories = provider.categories;

    return Scaffold(
      appBar: AppBar(
        title: Text('Categories:'),
      ),
      body: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            Category category = categories[index];
            return ListTile(
              title: Text(category.name),
              trailing: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return CategoryEdit(
                              category, provider.updateCategory);
                        });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                            title: Text('Confirmation'),
                            content: Text('Aur you sure you want to delete?'),
                            actions: [
                              TextButton(
                                child: Text('Cancel'),
                                onPressed: () => Navigator.pop(context),
                              ),
                              TextButton(
                                child: Text('Delete'),
                                onPressed: () => deleteCategory(
                                    provider.deleteCategory, category),
                              ),
                            ]);
                      }),
                )
              ]),
            );
          }),
          floatingActionButton: new FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return CategoryAdd(provider.addCategory);
                    });
              },
              child: new Icon(Icons.add)
          )
      );
  }

  Future deleteCategory(Function callback, Category category) async {
    await callback(category);
    Navigator.pop(context);
  }
}
