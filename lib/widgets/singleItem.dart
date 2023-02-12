import 'package:flutter/material.dart';
import 'package:grocery/config/colors.dart';

class SingleItem extends StatefulWidget {
  const SingleItem({Key? key}) : super(key: key);

  @override
  State<SingleItem> createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    height: 90,
                    child: Center(
                      child: Image.network(
                        "https://www.pngarts.com/files/3/Banana-Transparent.png",
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 90,
                    child: Column(
                      //   mainAxisAlignment: widget.isBool == false
                      //      ? MainAxisAlignment.spaceAround
                      //  :
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "productName",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "50\$",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        //  widget.isBool == false
                        //   ?

                        Container(
                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.green[100],
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.remove,
                                color: primaryColor,
                              ),
                              Text(
                                "01",
                                style: TextStyle(
                                    fontSize: 17, color: primaryColor),
                              ),
                              Icon(
                                Icons.add,
                                color: primaryColor,
                              )
                            ],
                          ),
                        ),

                        //    : Text(widget.productUnit)
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 90,
                  padding:
                      //widget.isBool == false
                      //  ? EdgeInsets.symmetric(horizontal: 15, vertical: 32)
                      //  :
                      EdgeInsets.only(left: 15, right: 15, top: 70),
                  child: Text(
                    "50\$",
                    style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  //widget.isBool == false
                  //   ? Count(
                  //     productId: widget.productId,
                  //     productImage: widget.productImage,
                  //    productName: widget.productName,
                  //    productPrice: widget.productPrice,
                  //    )
                  // :
                ),
              ],
            ),
          ),
          //  widget.isBool == false
          //   ? Container()
          //    :
        ],
      ),
    );
  }
}
