import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wabl_app_dashboard/core/helpers/app_helper_functions.dart';
import 'package:wabl_app_dashboard/core/helpers/extensions.dart';
import 'package:wabl_app_dashboard/features/post_settings/logic/car_type_cubit.dart';
import 'package:wabl_app_dashboard/features/post_settings/logic/car_type_state.dart';
import '../../../core/widgets/app_loading.dart';
import '../../../core/widgets/app_message_dialog.dart';
import '../../../core/widgets/app_toast.dart';

class CarTypeBlocListner extends StatelessWidget {
  const CarTypeBlocListner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CarTypeCubit, CarTypeState>(
      listenWhen: (previous, current) =>
          current is CudLoading || current is CudError || current is CudSuccess,
      listener: (context, state) {
        state.whenOrNull(
          cudLoading: () {
            AppHelperFunctions.unFocusKeyboard();
            AppLoading.loading(context);
          },
          cudSuccess: (message) {
            context.pop();
            context.pop();
            AppToast.show(
              context: context,
              message: message,
            );
          },
          cudError: (message) {
            context.pop();
            AppMessage.show(
              context: context,
              message: message,
              isError: true,
            );
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}
