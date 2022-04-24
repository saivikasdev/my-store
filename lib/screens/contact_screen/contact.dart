import 'package:flutter/material.dart';
import 'package:gadgets4u/components/coustom_bottom_nav_bar.dart';
import '../../enums.dart';
import '../../size_config.dart';
class contactscreen extends StatelessWidget {
  const contactscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Center(
        child: Container(
          height: 500,
          width: double.infinity,
          margin: EdgeInsets.all(getProportionateScreenWidth(20)),
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenWidth(15),
          ),
          decoration: BoxDecoration(
            color: Color(0XFF8B8B8B),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text.rich(
            TextSpan(
              style: TextStyle(color: Colors.white),
              children: [
                TextSpan(text: "For some issues our chat bot is not available right now   "
                    "but we never stop you to get trusted on us  "
                    "so here is the advantage that we have provided "
                    "contact details of  members "
                    "so you may ask them and clarify your doughts\n",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                TextSpan(
                  text: "Contact us \n",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(50),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: "+91 9573604021\n",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(35),
                      fontWeight: FontWeight.bold,
                      color: Colors.yellowAccent
                  ),
                ),
                TextSpan(
                  text: "+91 9346017316",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(35),
                      fontWeight: FontWeight.bold,
                      color: Colors.yellowAccent
                  ),
                ),

              ],
            ),
          ),

        ),
      ),

      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.contact),
    );
  }
}
