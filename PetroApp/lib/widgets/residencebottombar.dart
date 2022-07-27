import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

class ResidenceBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(0.2),
            offset: Offset.zero)
      ]),
      height: 100,
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ClipOval(
            child: Material(
              child: IconButton(
                icon:
                    Icon(CommunityMaterialIcons.view_list, color: Colors.black),
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed('/FiltrationPage');
                },
              ),
            ),
          ),
          ClipOval(
            child: Material(
              child: IconButton(
                icon: Icon(CommunityMaterialIcons.map, color: Colors.black),
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed('/AllMap');
                },
              ),
            ),
          ),
          ClipOval(
            child: Material(
              child: IconButton(
                icon: Icon(CommunityMaterialIcons.cog, color: Colors.black),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed('/Admin');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
