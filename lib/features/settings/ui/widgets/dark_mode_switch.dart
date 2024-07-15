import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/change_theme_cubit.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';

class DarkModeSwitch extends StatefulWidget {
  const DarkModeSwitch({super.key});

  @override
  State<DarkModeSwitch> createState() => _DarkModeSwitchState();
}

class _DarkModeSwitchState extends State<DarkModeSwitch> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Dark mode',
          style: TextStyles.font16Medium,
        ),
        BlocBuilder<ChangeThemeCubit, ChangeThemeState>(
          builder: (context, state) {
            var cubit = ChangeThemeCubit.get(context);
            return AppCupertinoSwitch(
              value: cubit.isDarkMode(),
              onChanged: (v) {
                ChangeThemeCubit.get(context).toggleDarkMode(v);
              },
            );
          },
        ),
      ],
    );
  }
}

class AppCupertinoSwitch extends StatelessWidget {
  final bool value;
  final void Function(bool)? onChanged;
  const AppCupertinoSwitch({
    super.key,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: .8,
      child: SizedBox(
        width: 35.w,
        child: CupertinoSwitch(
          activeColor: ColorsManager.mainBoldColor,
          value: value,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
