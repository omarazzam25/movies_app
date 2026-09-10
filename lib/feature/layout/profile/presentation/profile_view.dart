import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/core/config/routes/app_routes_name.dart';
import 'package:movies_app/core/config/them/app_color.dart';
import 'package:movies_app/core/widgets/custom_button.dart';
import 'package:movies_app/main.dart';

import '../../../../core/config/them/text_them.dart';
import '../../../../core/service/snack_bar.dart';
import '../../../../core/utils/firebase_auth_service.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: size.height * .43,
            color: Color(0xff212121),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 20,
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 55,
                              backgroundImage: AssetImage(
                                'assets/images/gamer_profile .png',
                              ),
                            ),
                            SizedBox(height: 15),
                            Text(
                              'John Safwat',
                              style: TextThem.robotoBold20White,
                            ),
                          ],
                        ),
                        SizedBox(width: 40),
                        Column(
                          children: [
                            Text('12', style: TextThem.robotoBold36White),
                            SizedBox(height: 12),
                            Text(
                              'Wish List',
                              style: TextThem.robotoBold24White,
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        Column(
                          children: [
                            Text('12', style: TextThem.robotoBold36White),
                            SizedBox(height: 12),
                            Text('History', style: TextThem.robotoBold24White),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,

                          child: CustomButton(
                            text: 'Edit Profile',
                            onTap: () {
                              navigatorKey.currentState?.pushNamed(
                                AppRoutesName.editProfile,
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 10),

                        Expanded(
                          child: CustomButton(
                            onTap: () async {
                              final success =
                                  await FirebaseAuthService.signOut();

                              if (success) {
                                SnackBarHelper.showSuccessSnackBar(
                                  'Logout Success',
                                );
                                navigatorKey.currentState
                                    ?.pushNamedAndRemoveUntil(
                                      AppRoutesName.login,
                                      (route) => false,
                                    );
                              }
                            },
                            text: 'Exit',
                            rightIcon: Icon(
                              Icons.login_outlined,
                              color: AppColor.whiteColor,
                            ),
                            background: AppColor.redColor,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset('assets/icons/list.svg'),
                            ),
                            Text(
                              'Watch List',
                              style: TextThem.robotoRegular20White,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SvgPicture.asset('assets/icons/folder.svg'),
                            Text(
                              'Watch List',
                              style: TextThem.robotoRegular20White,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          Expanded(
            child: Container(
              decoration: BoxDecoration(),

              child: Image.asset(
                'assets/images/empty.png',
                width: 124,
                height: 124,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
