import 'package:flutter/material.dart';
import 'package:wrg2/backend/mixin/mixin.text.dart';

class PersonalProfileItem extends StatelessWidget {
  final String name;
  final String photo;
  final String id;
  final String? mobile;
  const PersonalProfileItem({
    super.key,
    this.name = '',
    this.photo = '',
    this.id = '',
    this.mobile,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Get.to(() => PersonalProfile(id: id));
      },
      child: Row(
        children: [
          Container(
              alignment: Alignment.center,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.transparent, width: 2)),
              child: CircleAvatar(
                minRadius: 20,
                backgroundImage: Image.network(photo).image,
              )),
          const SizedBox(width: 10),
          Column(
            children: [
              Text(
                name,
                style: TS.h4,
              ),
              // Text(
              //   mobile ?? "--No Contact--",
              //   style: TS.h4,
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
