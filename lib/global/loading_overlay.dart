import 'package:findrobe_app/theme/app_colors.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        ModalBarrier(
          color: AppColors.overlayBlack,
          dismissible: false
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SpinKitFadingCube(
                color: AppColors.beige,
                size: 50.0,
              )
            ],
          )
        ),
      ] 
    );
  }
}