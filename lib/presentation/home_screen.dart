import 'dart:io';

import 'package:Mobile_Test/data/models/users.dart';
import 'package:Mobile_Test/presentation/widgets/loader.dart';
import 'package:Mobile_Test/presentation/user_tile.dart';
import 'package:Mobile_Test/services/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:random_color/random_color.dart';

class HomeScreen extends StatefulWidget {
 
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Data>> futureUserInfo;
  bool loaded = false;
  @override
  void initState() {
    super.initState();
    futureUserInfo = getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: new AppBar(
            title: new Text('People'),
            centerTitle: true,
            backgroundColor: RandomColor().randomMaterialColor(
                colorSaturation: ColorSaturation.lowSaturation),
          ),
          body: Container(
            child: FutureBuilder(
              future: futureUserInfo,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.waiting &&
                    snapshot.connectionState != ConnectionState.none &&
                    snapshot.hasData) {
                  var userList = snapshot.data;
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: userList == null ? 0 : userList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var userData = userList[index];
                      return UserTile(
                        avatar: userData.avatar,
                        firstName: userData.firstName,
                        lastName: userData.lastName,
                        index: Key("index"),
                        email: userData.email,
                      );
                    },
                    shrinkWrap: true,
                  );
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: 8,
                    itemBuilder: (BuildContext context, int index) {
                      return buildSkeleton(context, index);
                    },
                    shrinkWrap: true,
                  );
                }
              },
            ),
          ),
        ));
  }
}

Widget buildSkeleton(BuildContext context, index) => ListTile(
      key: Key("$index"),
      title: SkeletonContainer.rounded(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        width: MediaQuery.of(context).size.width * 0.6,
        height: 15,
      ),
      subtitle: SkeletonContainer.rounded(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        width: MediaQuery.of(context).size.width * 0.15,
        height: 12,
      ),
      leading: SkeletonContainer.circular(
        width: 44,
        height: 44,
      ),
    );
