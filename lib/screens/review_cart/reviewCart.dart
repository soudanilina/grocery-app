import 'package:flutter/material.dart';
import 'package:grocery/config/constants.dart';
import 'package:grocery/widgets/singleItem.dart';

class ReviewCart extends StatefulWidget {
  const ReviewCart({Key? key}) : super(key: key);

  @override
  State<ReviewCart> createState() => _ReviewCartState();
}

class _ReviewCartState extends State<ReviewCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "Review Cart",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView.builder(
        itemCount: Herbs.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(Herbs[index].name.toString()),
            // Provide a function that tells the app
            // what to do after an item has been swiped away.
            background: Container(
              color: Colors.redAccent,
              child: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {},
              ),
            ),
            confirmDismiss: (direction) {
              return showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                        title: Text("please confirm"),
                        content: Text("are you sure you wan to delete this"),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(ctx).pop(false);
                              },
                              child: Text("cancel")),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(ctx).pop(true);
                              },
                              child: Text("delete")),
                        ],
                      ));
            },
            onDismissed: (direction) {
              // Remove the item from the data source.

              setState(() {
                Herbs.removeAt(index);
              });
            },
            child: SingleItem(),
          );
        },
      ),
    );
  }
}
