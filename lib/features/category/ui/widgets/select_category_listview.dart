import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacing.dart';
import '../../logic/category_cubit.dart';
import '../../logic/category_state.dart';
import 'categories_listview_item.dart';

class SelectCategoryListview extends StatefulWidget {
  final double? start;
  final double? end;
  const SelectCategoryListview({
    super.key,
    this.start,
    this.end,
  });

  @override
  State<SelectCategoryListview> createState() => _SelectCategoryListviewState();
}

class _SelectCategoryListviewState extends State<SelectCategoryListview> {
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
          return ListView.separated(
            padding: EdgeInsetsDirectional.only(
              start: widget.start ?? 16.w,
              end: widget.end ?? 16.w,
            ),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            separatorBuilder: (_, i) => horizontalSpace(10),
            itemCount: cubit.categoriesList.length,
            itemBuilder: (_, i) {
              var cat = cubit.categoriesList[i];
              return CategoriesListviewItem(
                cat: cat,
                isSelected:
                    cat.id == cubit.selectedCategoryAddPostAndSearch?.id,
                onTap: () {
                  cubit.getSeletedCategory(cat);
                },
              );
            },
          );
        },
      ),
    );
  }
}
