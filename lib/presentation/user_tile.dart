import 'dart:io';
import 'package:Mobile_Test/presentation/widgets/loader.dart';
import "package:flutter/material.dart";
import 'package:random_color/random_color.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UserTile extends StatefulWidget {
  final Key index;

  final String firstName;
  final String lastName;
  final String email;
  final String avatar;

  UserTile({
    this.index,
    this.firstName,
    this.email,
    this.lastName,
    this.avatar,
  });

  @override
  _UserTileState createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      key: Key("$widget.index"),
      title: Text(widget.firstName + " " + widget.lastName ?? ""),
      subtitle: Text(widget.email ?? ""),
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: RandomColor()
            .randomMaterialColor(colorSaturation: ColorSaturation.random),
        child: CircleAvatar(
          radius: 20,
          backgroundColor: RandomColor()
              .randomMaterialColor(colorSaturation: ColorSaturation.random),
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: "${widget.avatar}",
              placeholder: buildSkeleton,
              // placeholderFadeInDuration: Duration(milliseconds: 200),
              fadeInDuration: Duration(milliseconds: 200),
              fadeOutDuration: Duration(milliseconds: 500),
            ),
          ),
        ),
      ),
      childrenPadding: EdgeInsets.symmetric(horizontal: 20),
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Email: ${widget.email}"),
                  SizedBox(
                    height: 5,
                  ),
                  Text("First Name ${widget.firstName}"),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Surname: ${widget.lastName}"),
                ],
              ),
            )),
      ],
    );
  }
}

Widget buildSkeleton(BuildContext context, index) => SkeletonContainer.circular(
      width: 44,
      height: 44,
    );
