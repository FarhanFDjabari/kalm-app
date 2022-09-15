import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kalm/presentation/cubit/auth/auth_cubit.dart';
import 'package:kalm/presentation/widgets/bottom_sheet_helper.dart';
import 'package:kalm/presentation/widgets/image_picker_bottom_sheet.dart';
import 'package:kalm/styles/kalm_theme.dart';

class HeaderImage extends StatelessWidget {
  const HeaderImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (builderContext, state) {
        if (state is AuthLoading) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: CircleAvatar(
              backgroundColor: accentColor,
              radius: 40,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              child: state is AuthLoadSuccess &&
                      state.user.photoProfileUrl?.isNotEmpty == true
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: Image.network(
                        state.user.photoProfileUrl!,
                        fit: BoxFit.fill,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                        height: 80,
                        width: 80,
                      ))
                  : Image.asset(
                      'assets/picture/profile_picture_placeholder.png',
                      fit: BoxFit.cover,
                      width: 80,
                      height: 80,
                    ),
            ),
            Positioned.fill(
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    if (!(state is AuthLoading)) {
                      showCustomBottomSheet(
                        context,
                        child: ImagePickBottomSheet(
                          pickCallback: (value) async {
                            if (value != null) {
                              // builderContext
                              //     .read<AuthCubit>()
                              //     .updateUserProfile(
                              //         GetStorage().read('user_id'),
                              //         null,
                              //         value);
                            }
                          },
                        ),
                        wrap: true,
                      );
                    }
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Color(0xFF000E3333).withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.edit_rounded,
                      size: 32,
                      color: tertiaryText,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
