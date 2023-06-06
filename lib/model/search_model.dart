import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view/Details_Screen.dart';
import '../view/add.dart';
import '../view_model/ZoomDrawer.dart';


class SearchModel extends GetxController {
  String courseSearchValue = "";
  String breakSearchValue = "";
  String lunchSearchValue = "";
  String dinnerSearchValue = "";
  String category = 'null';
  int productsAmount=0;
  bool _isConnected = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
    Future<Widget> IsAdmin() async {
    final userType = await getUserType();

    if ( userType == 'Admin') {
      return IconButton(
          onPressed: () {
            Get.to(AddScreen());
          },
          icon: Icon(Icons.add_circle));
    } else{
      return SizedBox(width: 0);
      }

  }


  Future<String> getUserType() async {
    final User? user = _auth.currentUser;
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: user?.email)
        .get();

    final Map<String, dynamic>? userInfo = (querySnapshot.docs.isNotEmpty
        ? querySnapshot.docs.first.data()
        : null) as Map<String, dynamic>?;

    final String userType = userInfo != null && userInfo['type'] == 1
        ? 'Admin'
        : userInfo != null ? userInfo['type'].toString() : '';
print("++++++++++++++++++++++++");
print(Type);
    return userType;
  }

  /// Search for meals based on the `MealSearchValue`
  Widget tab1Search() {
    update();

    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Meals').where('category',isEqualTo: 'فطور').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          onInit();
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var data = snapshot.data!.docs[index].data() as Map<dynamic, dynamic>;

                if (breakSearchValue.isEmpty) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(DetailsScreen(model: data));
                    },
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4,
                            offset: Offset(10, 4), // Shadow position
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          data['name']?.toString() ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          data['category']?.toString() ?? '',
                          style: TextStyle(color: Colors.grey),
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.white38,
                          radius: 25,
                          backgroundImage: NetworkImage(data['image']?.toString() ?? ''),
                        ),
                      ),
                    ),
                  );
                }

                if (data['name']?.toString().toLowerCase().contains(breakSearchValue.toLowerCase()) ?? false) {
                  return Container(
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4,
                          offset: Offset(10, 4), // Shadow position
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(
                        data['name']?.toString() ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        data['category']?.toString() ?? '',
                        style: TextStyle(color: Colors.grey),
                      ),
                      leading: GestureDetector(
                        onTap: () {
                          Get.to(DetailsScreen(model: data));
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white38,
                          radius: 25,
                          backgroundImage: NetworkImage(data['image']?.toString() ?? ''),
                        ),
                      ),
                    ),
                  );
                }

                return Container();
              },
              separatorBuilder: (context, index) => const SizedBox(height: 25),
              itemCount: snapshot.data!.docs.length,
            ),
          );
        });
  }


  Widget tab2Search() {
    update();

    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Meals'). where('category',isEqualTo:'غداء' ).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          onInit();
          return SizedBox(
            height:  MediaQuery.of(context).size.height,
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var data = snapshot.data!.docs[index].data() as Map<dynamic, dynamic>;

                if (lunchSearchValue.isEmpty) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(DetailsScreen(model: data));
                    },
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4,
                            offset: Offset(10, 4), // Shadow position
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          data['name']?.toString() ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          data['category']?.toString() ?? '',
                          style: TextStyle(color: Colors.grey),
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.white38,
                          radius: 25,
                          backgroundImage: NetworkImage(data['image']?.toString() ?? ''),
                        ),
                      ),
                    ),
                  );
                }

                if (data['name']?.toString().toLowerCase().contains(lunchSearchValue.toLowerCase()) ?? false) {
                  return Container(
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4,
                          offset: Offset(10, 4), // Shadow position
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(
                        data['name']?.toString() ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        data['category']?.toString() ?? '',
                        style: TextStyle(color: Colors.grey),
                      ),
                      leading: GestureDetector(
                        onTap: () {
                          Get.to(DetailsScreen(model: data));
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white38,
                          radius: 25,
                          backgroundImage: NetworkImage(data['image']?.toString() ?? ''),
                        ),
                      ),
                    ),
                  );
                }

                return Container();
              },
              separatorBuilder: (context, index) => const SizedBox(height: 25),
              itemCount: snapshot.data!.docs.length,
            ),
          );
        });
  }


  Widget tab3Search() {
    update();
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Meals').where('category',isEqualTo: 'عشاء').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ) {
          return const Center(child: CircularProgressIndicator());
        }


        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Flexible(
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var data = snapshot.data!.docs[index].data() as Map<dynamic, dynamic>;

                if (dinnerSearchValue.isEmpty) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(DetailsScreen(model: data));
                    },
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4,
                            offset: Offset(10, 4), // Shadow position
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          data['name']?.toString() ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          data['category']?.toString() ?? '',
                          style: TextStyle(color: Colors.grey),
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.white38,
                          radius: 25,
                          backgroundImage: NetworkImage(data['image']?.toString() ?? ''),
                        ),
                      ),
                    ),
                  );
                }

                if (data['name']?.toString().toLowerCase().contains(dinnerSearchValue.toLowerCase()) ?? false) {
                  return Container(
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4,
                          offset: Offset(10, 4), // Shadow position
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(
                        data['name']?.toString() ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        data['category']?.toString() ?? '',
                        style: TextStyle(color: Colors.grey),
                      ),
                      leading: GestureDetector(
                        onTap: () {
                          Get.to(DetailsScreen(model: data));
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white38,
                          radius: 25,
                          backgroundImage: NetworkImage(data['image']?.toString() ?? ''),
                        ),
                      ),
                    ),
                  );
                }

                return Container();
              },
              separatorBuilder: (context, index) => const SizedBox(height: 25),
              itemCount: snapshot.data!.docs.length,
            ),
          ),
        );
      },
    );
  }


}