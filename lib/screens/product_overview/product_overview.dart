import 'package:flutter/material.dart';
import 'package:grocery/config/colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductOverView extends StatefulWidget {
  final String productName;
  final String productImage;
  final double productPrice;
  const ProductOverView(
      {Key? key,
      required this.productImage,
      required this.productName,
      required this.productPrice})
      : super(key: key);

  @override
  State<ProductOverView> createState() => _ProductOverViewState();
}

class _ProductOverViewState extends State<ProductOverView> {
  Widget bonntonNavigatorBar(
      {required Color iconColor,
      required Color backgroundColor,
      required Color color,
      required String title,
      required IconData iconData,
      required VoidCallback onTap,
      required double width}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.all(5),
          height: width,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 20,
                color: iconColor,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                title,
                style: TextStyle(color: color, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          bonntonNavigatorBar(
              backgroundColor: textColor,
              color: Colors.white,
              iconColor: Colors.white,
              title: "Add To cart",
              iconData: Icons.favorite_outline,
              onTap: () {
                print("cart");
              },
              width: 50),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              print("wishlist");
            },
            child: Container(
                width: 50,
                height: 50,
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Icon(
                  Icons.favorite_outline,
                  size: 25,
                  color: primaryColor,
                )),
          ),
        ],
      ),
      appBar: AppBar(
        //  backgroundColor: Colors.green[100],
        actions: [
          IconButton(
            icon: Icon(Icons.shop),
            onPressed: () {
              /** Do something */
            },
          ),
        ],
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
        title: Text(
          "Product Overview",
          style: TextStyle(color: textColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 50),
              height: 250.0,
              width: double.infinity,
              decoration: BoxDecoration(
                //   borderRadius: BorderRadius.only(
                //           bottomLeft: Radius.circular(40),
                //     bottomRight: Radius.circular(40)),
                //   color: Colors.green[100],
                image: DecorationImage(
                  image: NetworkImage(widget.productImage),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.productName,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
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
                              style:
                                  TextStyle(fontSize: 17, color: primaryColor),
                            ),
                            Icon(
                              Icons.add,
                              color: primaryColor,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: '',
                        groupValue: '',
                        onChanged: (value) {},
                        activeColor: primaryColor,
                      ),
                      Text("1 KG "),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RatingBar(
                        itemSize: 23,
                        initialRating: 3,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        ratingWidget: RatingWidget(
                          full: Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          half: Icon(
                            Icons.star,
                            color: Colors.red,
                          ),
                          empty: Icon(
                            Icons.star_border,
                            color: Colors.amber,
                          ),
                        ),
                        // itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      Text(
                        '${widget.productPrice.toString()} \$',
                        style: TextStyle(
                            fontSize: 25,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 30,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.all(
                        Radius.circular(40),
                      ),
                    ),
                    child: Center(
                        child: Text(
                      "Free Ship",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Details",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      "Product pages are a vital element for any e-commerce store. An e-commerce product page design often make or break a sale. Do you remember watching a product video while shopping online ? Did you look at the product reviews? Did you end up leaving the site due to some reason? Every stage in the user purchase journey, from research to placing the order,",
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
