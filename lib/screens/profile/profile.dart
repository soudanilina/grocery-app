import 'package:flutter/material.dart';
import 'package:grocery/auth/sign_in.dart';
import 'package:grocery/config/colors.dart';
import 'package:grocery/providers/google_signin.dart';
import 'package:grocery/screens/home/drawer_side.dart';
import 'package:grocery/screens/home/home_page.dart';
import 'package:grocery/utils/auth_service.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class Profile extends StatefulWidget {
  GoggleSignIn userProvider;
  Profile({required this.userProvider, Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Widget listTile(
      {required String title,
      required IconData iconData,
      required VoidCallback onTap}) {
    return Column(
      children: [
        Divider(
          color: Color(0xffEDFFF3),
          // height: 2,
          thickness: 2,
        ),
        Container(
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
              style: TextStyle(color: Palette.textColor1),
            ),
            trailing: Icon(
              FeatherIcons.chevronRight,
              color: Palette.textColor2,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var userData = widget.userProvider.currentUserData;
    return Scaffold(
      appBar: AppBar(
        //     leading: BackButton(
        //    color: Colors.black
        //  ),
        iconTheme: IconThemeData(color: Palette.blackColor),
        elevation: 0.0,
        title: Text(
          'Profile',
          style: TextStyle(
            color: textColor,
            fontSize: 18,
          ),
        ),
      ),
      drawer: DrawerSide(
        userProvider: widget.userProvider,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 18),
        // color: Colors.amber,
        child: ListView(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: EdgeInsets.only(top: 8),
                  alignment: Alignment.centerRight,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: primaryColor,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 13,
                      child: IconButton(
                        iconSize: 13,
                        alignment: Alignment.center,
                        onPressed: () {},
                        icon: Icon(
                          FeatherIcons.edit2,
                          color: primaryColor,
                          size: 13,
                        ),
                      ),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 8),
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: primaryColor,
                  child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        userData.image ??
                            'https://images.pexels.com/photos/1382734/pexels-photo-1382734.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                      ),
                      radius: 47,
                      backgroundColor: scaffoldBackgroundColor),
                ),
              ),
              // CircleAvatar(
              //        radius: 45,
              //       backgroundColor: primaryColor,
              //       child: CircleAvatar(
              //           radius: 42,
              //           child: Image(image: NetworkImage('https://images.pexels.com/photos/1382734/pexels-photo-1382734.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1')),
              //       backgroundColor: scaffoldBackgroundColor,
              //          ),
              //                   ),
              Text(
                userData.name.toString(),
                style: TextStyle(color: Palette.textColor1, fontSize: 20),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                userData.email.toString(),
                style: TextStyle(color: Palette.textColor2, fontSize: 14),
              ),
              SizedBox(
                height: 15,
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
                  iconData: Icons.copy,
                  title: "Raise a Complaint",
                  onTap: () {}),
              listTile(
                  iconData: Icons.format_quote, title: "FAQs", onTap: () {}),
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
        ]),
      ),
    );
  }
}
