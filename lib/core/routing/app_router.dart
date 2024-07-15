import 'package:flutter/material.dart';
import '../../features/auth/ui/screens/check_reset_code_screen.dart';
import '../../features/auth/ui/screens/forget_password_screen.dart';
import '../../features/auth/ui/screens/login_screen.dart';
import '../../features/auth/ui/screens/reset_password_screen.dart';
import '../../features/auth/ui/screens/sign_up_screen.dart';
import '../../features/bottom_nav_bar/ui/bottom_nav_bar.dart';
import '../../features/chat/ui/chat/chat_screen.dart';
import '../../features/chat/ui/conversations/all_conversations_screen.dart';
import '../../features/post/ui/post_screen/post_screen.dart';
import '../../features/profile/ui/profile_screen/profile_screen.dart';
import '../../features/profile/ui/profile_settings_screen.dart';
import 'routes.dart';
import 'screen_argument.dart';
// import 'screen_argument.dart';

class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    final argument = settings.arguments as ScreenArgument?;
    switch (settings.name) {
      //! Auth
      case Routes.logInScreen:
        return MaterialPageRoute(
          builder: (_) => const LogInScreen(),
        );
      case Routes.forgetPasswordScreen:
        return MaterialPageRoute(
          builder: (_) => const ForgetPasswordScreen(),
        );
      case Routes.checkResetCodeScreen:
        return MaterialPageRoute(
          builder: (_) => const CheckResetCodeScreen(),
        );
      case Routes.resetPasswordScreen:
        return MaterialPageRoute(
          builder: (_) => const ResetPasswordScreen(),
        );
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => const SignUpcreen(),
        );

      case Routes.profileSettingsScreen:
        return MaterialPageRoute(
          builder: (_) => const ProfileSettingsScreen(),
        );
      case Routes.profileScreen:
        var postOwner = argument?.arguments['post_owner'];
        return MaterialPageRoute(
          builder: (_) => ProfileScreen(
            postOwner: postOwner,
          ),
        );
      case Routes.allConversationsScreen:
        return MaterialPageRoute(
          builder: (_) => const AllConversationsScreen(),
        );
      case Routes.chatScreen:
        var chatWith = argument?.arguments['chat_with'];
        var chatId = argument?.arguments['chat_id'];
        return MaterialPageRoute(
          builder: (_) => ChatScreen(
            chatWith: chatWith,
            chatId: chatId,
          ),
        );

      case Routes.postScreen:
        var post = argument?.arguments['post'];
        return MaterialPageRoute(
          builder: (_) => PostScreen(
            post: post,
          ),
        );

      case Routes.bottomNavBar:
        return MaterialPageRoute(
          builder: (_) => const BottomNavBar(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
