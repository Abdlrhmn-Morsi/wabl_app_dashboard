import 'package:get_it/get_it.dart';
import 'package:wabl_app_dashboard/features/group/logic/update_group_cubit.dart';
import 'package:wabl_app_dashboard/features/statistics/logic/statistics_cubit.dart';
import 'package:wabl_app_dashboard/features/users/logic/employee_cubit.dart';
import 'package:wabl_app_dashboard/features/users/logic/role_cubit.dart';
import 'package:wabl_app_dashboard/features/users/logic/user_cubit.dart';
import '../../features/auth/data/repos/auth_repo.dart';
import '../../features/auth/data/services/auth_web_service.dart';
import '../../features/auth/logic/forget_password_cubit.dart';
import '../../features/auth/logic/login_cubit.dart';
import '../../features/auth/logic/signup_cubit.dart';
import '../../features/bottom_nav_bar/logic/bottom_nav_bar_cubit.dart';
import '../../features/category/logic/category_cubit.dart';
import '../../features/chat/logic/chat_cubit.dart';
import '../../features/group/logic/create_group_cubit.dart';
import '../../features/group/logic/group_cubit.dart';
import '../../features/post/logic/current_user_posts_cubit.dart';
import '../../features/post/logic/post_cubit.dart';
import '../../features/post/logic/post_viewer_cubit.dart';
import '../../features/post/logic/update_post_cubit.dart';
import '../../features/profile/data/repos/profile_web_services.dart';
import '../../features/profile/data/services/profile_web_services.dart';
import '../../features/profile/logic/profile_cubit.dart';
import '../../features/profile/logic/update_password_cubit.dart';
import '../networking/dio_client.dart';
import '../theming/change_theme_cubit.dart';

var getIt = GetIt.instance;

Future initGetIt() async {
  getIt.registerLazySingleton(() => DioClient());

  //*Auth
  getIt.registerLazySingleton<AuthWebService>(
    () => AuthWebServiceImp(dioClient: getIt()),
  );
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepo(getIt()));
  getIt.registerLazySingleton<LoginCubit>(() => LoginCubit(getIt()));
  getIt.registerLazySingleton<SignupCubit>(() => SignupCubit(getIt()));
  getIt.registerLazySingleton<ForgetPasswordCubit>(
    () => ForgetPasswordCubit(getIt()),
  );
  //*Profile
  getIt.registerLazySingleton<ProfileRepo>(() => ProfileRepo(getIt()));
  getIt.registerLazySingleton<ProfileCubit>(() => ProfileCubit(getIt()));
  getIt.registerLazySingleton<ProfileWebServices>(
    () => ProfileWebServicesImpl(dioClient: getIt()),
  );
  getIt.registerLazySingleton<UpdatePasswordCubit>(
    () => UpdatePasswordCubit(getIt()),
  );
  //*Category
  getIt.registerLazySingleton<CategoryCubit>(() => CategoryCubit(
        getIt(),
      ));
  //*Post
  getIt.registerLazySingleton<PostCubit>(() => PostCubit(
        getIt(),
      ));

  getIt.registerLazySingleton<UpdatePostCubit>(() => UpdatePostCubit(
        getIt(),
        getIt(),
      ));
  getIt.registerLazySingleton<CurrentUserPostsCubit>(
    () => CurrentUserPostsCubit(),
  );
  getIt.registerLazySingleton<PostViewerCubit>(
    () => PostViewerCubit(),
  );

  //* chat
  getIt.registerLazySingleton<ChatCubit>(() => ChatCubit());
  //* User
  getIt.registerLazySingleton<UserCubit>(() => UserCubit());
  getIt.registerLazySingleton<EmployeeCubit>(() => EmployeeCubit());
  getIt.registerLazySingleton<RoleCubit>(() => RoleCubit());
  //* Statistics
  getIt.registerLazySingleton<StatisticsCubit>(() => StatisticsCubit());

  //* Group
  getIt.registerLazySingleton<GroupCubit>(() => GroupCubit());
  getIt.registerLazySingleton<CreateGroupCubit>(() => CreateGroupCubit(
        getIt(),
      ));
  getIt.registerLazySingleton<UpdateGroupCubit>(() => UpdateGroupCubit());

  //cubits
  getIt.registerLazySingleton<ChangeThemeCubit>(() => ChangeThemeCubit());
  getIt.registerLazySingleton<BottomNavBarCubit>(() => BottomNavBarCubit());
}
