import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/dependency_injection.dart';
import '../../../core/helpers/app_cashed.dart';
import '../../../core/networking/api_result.dart';
import '../../../core/networking/error_handling/api_error_handler.dart';
import '../../post/logic/post_cubit.dart';
import '../data/models/category_response_body.dart';
import 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final PostCubit postCubit;
  CategoryCubit(this.postCubit) : super(const CategoryState.initial());
  var catCol = FirebaseFirestore.instance.collection('categories');

  static CategoryCubit get get => getIt();

  int currentIndex = -1;
  CategoryResponseBody? selectedCategory;

  void getSeletedItem(
    int index,
    CategoryResponseBody? cat,
  ) {
    emit(const CategoryState.initial());
    currentIndex = index;
    selectedCategory = cat;
    postCubit.emitGetPosts(
      isRefresh: true,
    );
    emit(const CategoryState.selectedItem());
  }

  void resetSeletedItem() {
    emit(const CategoryState.initial());
    currentIndex = -1;
    selectedCategory = null;
    emit(const CategoryState.selectedItem());
  }

  CategoryResponseBody? selectedCategoryAddPostAndSearch;

  void getSeletedCategory(CategoryResponseBody? cat) {
    emit(const CategoryState.initial());
    selectedCategoryAddPostAndSearch = cat;
    emit(const CategoryState.selectedItem());
  }

  void resetSeletedCategory() {
    selectedCategoryAddPostAndSearch = null;
  }

  Future<ApiResult> getCategories() async {
    try {
      var docs = await catCol.orderBy('order', descending: false).get();
      return ApiResult.success(docs.docs);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  List<CategoryResponseBody> categoriesList = [];
  Future emitGetCategories({
    bool isRefresh = false,
  }) async {
    if (!AppCashe.isCategoriesCashed() || isRefresh) {
      emit(const CategoryState.loading());
    }
    if (!AppCashe.isCategoriesCashed() || isRefresh) {
      var response = await getCategories();
      response.when(
        success: (data) {
          AppCashe.casheCategories();
          categoriesList.clear();
          for (var cat in data) {
            categoriesList.add(CategoryResponseBody.fromDocumentSnapshot(cat));
          }
          emit(const CategoryState.success(''));
        },
        failure: (e) {
          emit(CategoryState.error(message: e.apiErrorModel.message ?? ''));
        },
      );
    }
  }
}
