import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gadgets4u/screens/contact_screen/contact.dart';
import 'package:gadgets4u/screens/home/home_screen.dart';
import 'package:gadgets4u/screens/profile/profile_screen.dart';
import 'package:gadgets4u/screens/orders/orders_screen.dart';
import '../constants.dart';
import '../enums.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Shop Icon.svg",
                  color: MenuState.home == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, HomeScreen.routeName),
              ),
              InkWell(
                onTap: () =>Navigator.pushNamed(context, orderscreen.routeName),
                child: IconButton(
                  icon: SvgPicture.asset("assets/icons/Check mark rounde.svg",
                    color: MenuState.orders == selectedMenu
                        ? kPrimaryColor
                        : inActiveIconColor,width: 23,),
                  onPressed:() =>
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx)=> orderscreen()), (route) => false)
                ),
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Conversation.svg",
                  color: MenuState.contact == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () =>
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx)=> contactscreen()), (route) => false),

              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/User Icon.svg",
                  color: MenuState.profile == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () =>
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx)=> ProfileScreen()), (route) => false),

              ),
            ],
          )),
    );
  }
}
