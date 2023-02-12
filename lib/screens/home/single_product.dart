import 'package:flutter/material.dart';
import 'package:grocery/config/colors.dart';

class SingleProduct extends StatefulWidget {
  final String productImage;
  final String productName;
  final VoidCallback onTap;
  final double productPrice;
  const SingleProduct(
      {required this.productImage,
      required this.productName,
      required this.productPrice,
      required this.onTap,
      Key? key})
      : super(key: key);

  @override
  State<SingleProduct> createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: 240,
      width: 160,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: widget.onTap,
              child: Container(
                height: 150,
                padding: EdgeInsets.all(5),
                width: double.infinity,
                child: Image.network(
                  widget.productImage,
                ),
              ),
            ),
          ),
          //    Expanded(
          //    flex: 2,
          //    child: Image.network(
          //       'https://pngimg.com/uploads/spinach/spinach_PNG10.png'),
          //   ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productName,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    '50 grams',
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 5),
                          height: 30,
                          width: 50,
                          child: Row(
                            children: [
                              Text(
                                '${widget.productPrice.toString()} \$',
                                style: TextStyle(fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            print("Tapped on container");
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 5),
                            height: 22,
                            width: 20,
                            decoration: BoxDecoration(
                                color: primaryColor,

                                //      color: Colors.red,
                                borderRadius:
                                    BorderRadiusDirectional.circular(8)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Add ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    )),
                                Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
