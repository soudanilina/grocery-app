import 'package:flutter/material.dart';
import 'package:grocery/config/colors.dart';
import 'package:grocery/config/constants.dart';
import 'package:grocery/providers/google_signin.dart';
import 'package:grocery/screens/home/drawer_side.dart';
import 'package:grocery/screens/home/single_product.dart';
import 'package:grocery/screens/product_overview/product_overview.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:grocery/screens/review_cart/reviewCart.dart';
import 'package:grocery/widgets/Carrousel.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _buildHerbsProduct(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Herbs Seasonings'),
              Text(
                'view all',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
        Container(
          height: 240,
          //    width: 300,
          child: ListView.builder(
            //   physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: Herbs.length,
            itemBuilder: (BuildContext context, int index) => SingleProduct(
                productImage: Herbs[index].image!,
                productName: Herbs[index].name!,
                productPrice: Herbs[index].price!,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProductOverView(
                        productImage: Herbs[index].image!,
                        productName: Herbs[index].name!,
                        productPrice: Herbs[index].price!,
                      ),
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }

  Widget _buildFreshProduct(context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Fresh Fruits'),
              Text(
                'view all',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
        Container(
          height: 240,
          //    width: 300,
          child: ListView.builder(
            //   physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: Fruits.length,
            itemBuilder: (BuildContext context, int index) => SingleProduct(
                productImage: Fruits[index].image!,
                productName: Fruits[index].name!,
                productPrice: Fruits[index].price!,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProductOverView(
                        productImage: Fruits[index].image!,
                        productName: Fruits[index].name!,
                        productPrice: Herbs[index].price!,
                      ),
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    GoggleSignIn userProvider = Provider.of(context);
    userProvider.getUserData();
    return Scaffold(
      drawer: DrawerSide(
        userProvider: userProvider,
      ),
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Home',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              /** Do something */
            },
          ),
          IconButton(
            icon: Icon(Icons.shop),
            onPressed: () {
              /** Do something */
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ReviewCart(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // carousel
              Caroussel(),

              // herbs Products

              _buildHerbsProduct(context),
              _buildFreshProduct(context),
            ],
          ),
        ),
      ),
    );
  }
}
