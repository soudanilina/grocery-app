import 'package:flutter/material.dart';
import 'package:grocery/auth/sign_in.dart';
import 'package:grocery/config/colors.dart';
import 'package:grocery/providers/google_signin.dart';
import 'package:grocery/screens/home/home_page.dart';
import 'package:grocery/screens/profile/profile.dart';
import 'package:grocery/screens/review_cart/reviewCart.dart';
import 'package:grocery/utils/auth_service.dart';
import 'package:provider/provider.dart';

class DrawerSide extends StatefulWidget {
  GoggleSignIn userProvider;
  DrawerSide({required this.userProvider});

  @override
  State<DrawerSide> createState() => _DrawerSideState();
}

class _DrawerSideState extends State<DrawerSide> {
  Widget listTile(
      {required String title,
      required IconData iconData,
      required VoidCallback onTap}) {
    return Container(
      height: 50,
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          iconData,
          size: 28,
          color: primaryColor,
        ),
        title: Text(
          title,
          style: TextStyle(color: Colors.black45),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // GoggleSignIn userProvider = Provider.of(context);
    // userProvider.getUserData();
    var userData = widget.userProvider.currentUserData;
    return Drawer(
      child: Container(
        child: ListView(
          children: [
            SizedBox(
              height: 130,
              child: DrawerHeader(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 43,
                      backgroundColor: Colors.white54,
                      child: CircleAvatar(
                        backgroundColor: primaryColor,
                        //backgroundImage: AssetImage("assets/carrousel1.jpeg"),
                        backgroundImage:
                            NetworkImage(userData.image.toString()),
                        radius: 40,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          userData.name.toString(),
                          style: TextStyle(fontSize: 20, color: primaryColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 3,
              color: primaryColor,
            ),
            listTile(
              iconData: Icons.home,
              title: "Home",
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
            ),
            listTile(
              iconData: Icons.person,
              title: "My Profile",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Profile(userProvider: widget.userProvider)),
                );
                //  Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => Profile(userProvider:widget.userProvider),
                //   ),
                // );
              },
            ),
            listTile(
                iconData: Icons.favorite,
                title: "Wishlist",
                onTap: () {
                  //   Navigator.of(context).push(
                  //     MaterialPageRoute(
                  //      builder: (context) => WishLsit(),
                  //    ),
                  //  );
                }),
            listTile(
              iconData: Icons.shopping_cart,
              title: "Review Cart",
              onTap: () {
                //   Navigator.of(context).push(
                //    MaterialPageRoute(
                //     builder: (context) => ReviewCart(),
                //   ),
                //   );
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ReviewCart(),
                  ),
                );
              },
            ),
            listTile(
              iconData: Icons.assignment_turned_in,
              title: "Orders",
              onTap: () {
                //   Navigator.of(context).push(
                //    MaterialPageRoute(
                //     builder: (context) => ReviewCart(),
                //   ),
                //   );
              },
            ),
            listTile(
                iconData: Icons.notifications,
                title: "Notification",
                onTap: () {}),
            listTile(
                iconData: Icons.star, title: "Rating & Review", onTap: () {}),
            listTile(
                iconData: Icons.copy, title: "Raise a Complaint", onTap: () {}),
            listTile(iconData: Icons.format_quote, title: "FAQs", onTap: () {}),
            listTile(
                iconData: Icons.logout,
                title: "Log Out",
                onTap: () async {
                  await AuthService().signOutUser().then((value) {
                    print(value);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => SignIn()),
                        (Route<dynamic> route) => false);
                  });
                  // final provider =
                  //     Provider.of<GoggleSignIn>(context, listen: false);
                  // provider.googleSignOut();
                }),
          ],
        ),
      ),
    );
  }
}
