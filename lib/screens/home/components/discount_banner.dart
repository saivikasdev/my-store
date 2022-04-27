import 'package:flutter/material.dart';
import '../../../size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DiscountBanner extends StatefulWidget {
  const DiscountBanner({
    Key? key,
  }) : super(key: key);

  @override
  State<DiscountBanner> createState() => _DiscountBannerState();
}

class _DiscountBannerState extends State<DiscountBanner> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _search = TextEditingController();
  Map<String, dynamic>? userMap;
  Map<String, dynamic>? products;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          child: Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Container(
                height: 60,
                width: 300,
                child: Container(
                  height: 30,
                  width: 300,
                  child: TextField(
                    controller: _search,
                    decoration: InputDecoration(
                      hintText: "Search",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.deepOrangeAccent),
                alignment: Alignment.center,
                child: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white, //TODO
                    ),
                    onPressed: () => onSearch(_search.text)),
              ),
            ],
          ),
        ),
        userMap != null
            ? Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: ListTile(
                  onTap: null,
                  // onTap: () {
                  //     String roomId = chatRoomId(
                  //         _auth.currentUser!.displayName!,
                  //         userMap!['name']);

                  //     Navigator.of(context).push(
                  //       MaterialPageRoute(
                  //         builder: (_) => ChatRoom(
                  //           chatRoomId: roomId,
                  //           userMap: userMap!,
                  //         ),
                  //       ),
                  //     );
                  // },
                  leading: Icon(
                    Icons.account_circle,
                    color: Colors.blue,
                    size: 45,
                  ),
                  title: Text(
                    userMap!['name'],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(userMap!['desc']),
                  trailing: Image.network(userMap!['images'[0]]),
                ),
              )
            : Container(),
      ],
    );
  }

  void onSearch(text) async {
    print('.............................$text');
    print('.............................$userMap');

    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    setState(() {
      isLoading = true;
    });

    await _firestore
        .collection('products')
        .where("name", isEqualTo: text)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
        isLoading = false;
      });
    });

    // await _firestore.collection('products').get().then((value) {
    //   setState(() {
    //     products = value.docs[0].data();
    //     isLoading = false;
    //     print(products);
    //   });
    // });
  }
}
