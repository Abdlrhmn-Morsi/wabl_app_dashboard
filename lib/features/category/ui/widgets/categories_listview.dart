import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacing.dart';
import '../../data/models/category_response_body.dart';
import '../../logic/category_cubit.dart';
import '../../logic/category_state.dart';
import 'categories_listview_item.dart';

class CategoriesListview extends StatefulWidget {
  const CategoriesListview({super.key});

  @override
  State<CategoriesListview> createState() => _CategoriesListviewState();
}

class _CategoriesListviewState extends State<CategoriesListview> {
  @override
  void initState() {
    super.initState();
    CategoryCubit.get.emitGetCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: 30.h,
      child: BlocBuilder<CategoryCubit, CategoryState>(
        buildWhen: (previous, current) =>
            current is Loading ||
            current is Success ||
            current is Error ||
            current is SelectedItem,
        builder: (context, state) {
          var cubit = CategoryCubit.get;
          return state is Loading
              ? const Center(child: CircularProgressIndicator())
              : ListView.separated(
                  padding: EdgeInsetsDirectional.only(
                    start: 16.w,
                    end: 16.w,
                  ),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  separatorBuilder: (_, i) => horizontalSpace(10),
                  itemCount: cubit.categoriesList.length + 1,
                  itemBuilder: (_, i) {
                    if (i == 0) {
                      return CategoriesListviewItem(
                        cat: CategoryResponseBody(
                          id: '',
                          arName: 'All',
                          enName: 'All',
                        ),
                        isSelected: cubit.currentIndex == -1,
                        onTap: () {
                          cubit.getSeletedItem(-1, null);
                        },
                      );
                    }
                    var cat = cubit.categoriesList[i - 1];
                    return CategoriesListviewItem(
                      cat: cat,
                      isSelected: cubit.currentIndex == i,
                      onTap: () {
                        cubit.getSeletedItem(i, cat);
                      },
                    );
                  },
                );
        },
      ),
    );
  }
}
