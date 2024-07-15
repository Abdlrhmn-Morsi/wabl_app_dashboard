import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart.';
import 'package:wabl_app_dashboard/core/di/dependency_injection.dart';
import 'package:wabl_app_dashboard/core/helpers/app_cashed.dart';

import 'statistics_state.dart';

class StatisticsCubit extends Cubit<StatisticsState> {
  StatisticsCubit() : super(const StatisticsState.initial());
  static StatisticsCubit get get => getIt();
  var postsCol = FirebaseFirestore.instance.collection('posts');
  var usersCol = FirebaseFirestore.instance.collection('users');

  int usersCount = 0;
  int employeesCount = 0;

  int totalPosts = 0;
  int pendingPosts = 0;
  int approvedPosts = 0;

  initStatistics({bool isRefresh = false}) async {
    await Future.wait([
      _getPostsStatistics(isRefresh),
      _getUsersStatistics(isRefresh),
    ]);
  }

  Future _getPostsStatistics(bool isRefresh) async {
    if (isRefresh || !AppCashe.isPostsStatisticCashed()) {
      emit(const StatisticsState.loading());
    }
    if (isRefresh || !AppCashe.isPostsStatisticCashed()) {
      totalPosts = 0;
      pendingPosts = 0;
      approvedPosts = 0;
    }
    if (!AppCashe.isPostsStatisticCashed() || isRefresh) {
      try {
        var snapshot = await postsCol.get();
        totalPosts = snapshot.docs.length;
        for (var element in snapshot.docs) {
          if (element.data()['is_enabled'] == false) {
            pendingPosts++;
          } else if (element.data()['is_enabled'] == true) {
            approvedPosts++;
          }
        }
        AppCashe.cashePostsStatistic();
        emit(const StatisticsState.success(''));
      } catch (e) {
        emit(StatisticsState.error(message: e.toString()));
      }
    }
  }

  Future _getUsersStatistics(bool isRefresh) async {
    if (isRefresh || !AppCashe.isUsersStatisticCashed()) {
      emit(const StatisticsState.loading());
    }
    if (isRefresh || !AppCashe.isUsersStatisticCashed()) {
      employeesCount = 0;
      usersCount = 0;
    }
    if (!AppCashe.isUsersStatisticCashed() || isRefresh) {
      try {
        var snapshot = await usersCol.get();
        usersCount = snapshot.docs.length;
        for (var element in snapshot.docs) {
          if (element.data()['role'] == 'admin') {
            employeesCount++;
          }
        }
        AppCashe.casheUsersStatistic();
        emit(const StatisticsState.success(''));
      } catch (e) {
        emit(StatisticsState.error(message: e.toString()));
      }
    }
  }
}
