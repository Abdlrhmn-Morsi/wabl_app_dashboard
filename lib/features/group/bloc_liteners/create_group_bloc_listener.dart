import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart.';
import 'package:wabl_app_dashboard/core/helpers/app_helper_functions.dart';
import 'package:wabl_app_dashboard/core/helpers/extensions.dart';
import 'package:wabl_app_dashboard/features/group/logic/create_group_cubit.dart';
import 'package:wabl_app_dashboard/features/group/logic/create_group_state.dart';

import '../../../core/widgets/app_loading.dart';
import '../../../core/widgets/app_message_dialog.dart';
import '../../../core/widgets/app_toast.dart';

class CreateGroupBlocListener extends StatelessWidget {
  final bool isUpdate;
  const CreateGroupBlocListener({super.key, this.isUpdate = false});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateGroupCubit, CreateGroupState>(
      listenWhen: (previous, current) =>
          current is Loading || current is Success || current is Error,
      listener: (context, state) {
        state.whenOrNull(
          loading: () {
            AppHelperFunctions.unFocusKeyboard();
            AppLoading.loading(context);
          },
          success: (data) {
            context.pop();
            context.pop();
            AppToast.show(
              context: context,
              message: isUpdate
                  ? 'group_updated_successfuly'.tr()
                  : 'group_created_successfuly'.tr(),
            );
          },
          error: (message) {
            context.pop();
            AppMessage.show(
              context: context,
              message: message,
              isError: true,
            );
          },
        );
      },
      child: Container(),
    );
  }
}
