import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wabl_app_dashboard/features/users/logic/employee_cubit.dart';
import 'package:wabl_app_dashboard/features/users/logic/role_cubit.dart';
import 'package:wabl_app_dashboard/features/users/logic/user_cubit.dart';
import '../../features/auth/logic/forget_password_cubit.dart';
import '../../features/auth/logic/login_cubit.dart';
import '../../features/auth/logic/signup_cubit.dart';
import '../../features/bottom_nav_bar/logic/bottom_nav_bar_cubit.dart';
import '../../features/category/logic/category_cubit.dart';
import '../../features/chat/logic/chat_cubit.dart';
import '../../features/post/logic/create_post_cubit.dart';
import '../../features/post/logic/current_user_posts_cubit.dart';
import '../../features/post/logic/post_cubit.dart';
import '../../features/post/logic/post_viewer_cubit.dart';
import '../../features/post/logic/update_post_cubit.dart';
import '../../features/profile/logic/profile_cubit.dart';
import '../../features/profile/logic/update_password_cubit.dart';
import '../../features/statistics/logic/statistics_cubit.dart';
import 'dependency_injection.dart';

List<BlocProvider> appProviders() {
  return [
    //*Auth
    BlocProvider<LoginCubit>(create: (context) => getIt<LoginCubit>()),
    BlocProvider<SignupCubit>(create: (context) => getIt<SignupCubit>()),
    BlocProvider<ForgetPasswordCubit>(
      create: (context) => getIt<ForgetPasswordCubit>(),
    ),
    //*Profile
    BlocProvider<ProfileCubit>(
      create: (context) => getIt<ProfileCubit>(),
    ),
    //*update password
    BlocProvider<UpdatePasswordCubit>(
      create: (context) => getIt<UpdatePasswordCubit>(),
    ),
    //*Category
    BlocProvider<CategoryCubit>(
      create: (context) => getIt<CategoryCubit>(),
    ),
    //*Post
    BlocProvider<PostCubit>(
      create: (context) => getIt<PostCubit>(),
    ),
    BlocProvider<CreatePostCubit>(
      create: (context) => getIt<CreatePostCubit>(),
    ),
    BlocProvider<UpdatePostCubit>(
      create: (context) => getIt<UpdatePostCubit>(),
    ),
    BlocProvider<CurrentUserPostsCubit>(
      create: (context) => getIt<CurrentUserPostsCubit>(),
    ),
    BlocProvider<PostViewerCubit>(
      create: (context) => getIt<PostViewerCubit>(),
    ),

    //* chat
    BlocProvider<ChatCubit>(
      create: (context) => getIt<ChatCubit>(),
    ),
    //*Bottom nav bar
    BlocProvider<BottomNavBarCubit>(
      create: (context) => getIt<BottomNavBarCubit>(),
    ),
    //*User
    BlocProvider<UserCubit>(
      create: (context) => getIt<UserCubit>(),
    ),
    BlocProvider<EmployeeCubit>(
      create: (context) => getIt<EmployeeCubit>(),
    ),
    BlocProvider<RoleCubit>(
      create: (context) => getIt<RoleCubit>(),
    ),

    //* statistics
    BlocProvider<StatisticsCubit>(
      create: (context) => getIt<StatisticsCubit>(),
    ),
  ];
}
