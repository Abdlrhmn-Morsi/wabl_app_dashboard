import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/di/app_providers.dart';
import 'core/helpers/app_local_storage.dart';
import 'core/helpers/app_saved_key.dart';
import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';
import 'core/theming/change_theme_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: appProviders(),
      child: EasyLocalization(
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
        ],
        path: 'assets/translations',
        startLocale: const Locale('ar'),
        fallbackLocale: const Locale(AppSavedKey.defaultLang),
        saveLocale: true,
        child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          child: BlocBuilder<ChangeThemeCubit, ChangeThemeState>(
            builder: (context, state) {
              var cubit = ChangeThemeCubit.get(context);
              return MaterialApp(
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                title: 'Wabl Dashboard',
                theme: cubit.themeData(),
                debugShowCheckedModeBanner: false,
                onGenerateRoute: AppRouter.generateRoute,
                initialRoute: ApplocalStorage.isAuthunticated()
                    ? Routes.bottomNavBar
                    : Routes.logInScreen,
              );
            },
          ),
        ),
      ),
    );
  }
}
