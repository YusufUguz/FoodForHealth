import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_for_health/core/models/cache_user.dart';
import 'package:food_for_health/features/profile/view/widgets/profile_base_info_rows.dart';

// ignore: must_be_immutable
class UserBaseInfoCard extends StatelessWidget {
  const UserBaseInfoCard({super.key, required this.cacheUser, required this.gender});

  final ValueNotifier<CacheUser?> cacheUser;
  final String gender;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFE6F4EA),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 15,
          children: [
            CircleAvatar(
              maxRadius: 35,
              minRadius: 35,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.asset(
                  gender == "Erkek" ? "assets/icons/male.png" : "assets/icons/female.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ValueListenableBuilder(
                valueListenable: cacheUser,
                builder: (context, cacheUserValue, child) {
                  return cacheUserValue == null
                      ? SizedBox.shrink()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ProfileBaseInfoRows(
                                infoText: cacheUserValue.fullName, icon: FontAwesomeIcons.solidUser),
                            ProfileBaseInfoRows(
                                infoText: cacheUserValue.email, icon: FontAwesomeIcons.solidEnvelope),
                            ProfileBaseInfoRows(
                                infoText: cacheUserValue.phoneNumber, icon: FontAwesomeIcons.phone)
                          ],
                        );
                })
          ],
        ),
      ),
    );
  }
}
