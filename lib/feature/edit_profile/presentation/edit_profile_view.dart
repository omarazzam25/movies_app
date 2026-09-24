import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/core/widgets/custom_button.dart';
import '../../../core/api/model/my_user.dart';
import '../../../core/config/routes/app_routes_name.dart';
import '../../../core/config/them/app_color.dart';
import '../../../core/config/them/text_them.dart';
import '../../../core/service/snack_bar.dart';
import '../../../core/utils/firebase_auth_service.dart';
import '../../../core/widgets/custom_text_form_field.dart';
import '../../../main.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({
    super.key,
    required this.user,
  });

  final MyUser user;

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(
      text: widget.user.name,
    );

    _phoneController = TextEditingController(
      text: widget.user.phone,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    final horizontalPadding =
    (size.width * 0.04).clamp(16.0, 28.0);

    final avatarRadius =
    (size.width * 0.14).clamp(50.0, 65.0);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextThem.robotoRegular14Yellow,
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: 25,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Center(
                      child: CircleAvatar(
                        radius: avatarRadius,
                        backgroundImage: const AssetImage(
                          'assets/images/man_profile.png',
                        ),
                      ),
                    ),

                    const SizedBox(height: 35),


                    CustomTextFormField(
                      controller: _nameController,
                      hint: 'Name',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset(
                          'assets/icons/user_icon.svg',
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),


                    CustomTextFormField(
                      controller: _phoneController,
                      hint: 'Phone',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset(
                          'assets/icons/phone.svg',
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),


                    Text(
                      'Reset Password',
                      style: TextThem.robotoRegular20White,
                    ),
                  ],
                ),
              ),
            ),


            Padding(
              padding: EdgeInsets.only(
                left: horizontalPadding,
                right: horizontalPadding,
                top: 10,
                bottom: 20,
              ),
              child: Column(
                children: [

                  CustomButton(
                    onTap: () async {
                      final success =
                      await FirebaseAuthService.deleteAccount();

                      if (!mounted) return;

                      if (success) {
                        SnackBarHelper.showSuccessSnackBar(
                          'Account deleted successfully',
                        );

                        navigatorKey.currentState
                            ?.pushNamedAndRemoveUntil(
                          AppRoutesName.login,
                              (route) => false,
                        );
                      } else {
                        SnackBarHelper.showErrorSnackBar(
                          'Failed to delete account',
                        );
                      }
                    },
                    text: 'Delete Account',
                    background: AppColor.redColor,
                    titleColor: TextThem.robotoRegular20White,
                  ),




                  CustomButton(
                    onTap: () async {
                      final success =
                      await FirebaseAuthService.updateUser(
                        name: _nameController.text,
                        phone: _phoneController.text,
                      );

                      if (!mounted) return;

                      if (success) {
                        SnackBarHelper.showSuccessSnackBar(
                          'Data updated successfully',
                        );

                        navigatorKey.currentState
                            ?.pushReplacementNamed(
                          AppRoutesName.layout,
                        );
                      } else {
                        SnackBarHelper.showErrorSnackBar(
                          'Failed to update data',
                        );
                      }
                    },
                    text: 'Update Data',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}