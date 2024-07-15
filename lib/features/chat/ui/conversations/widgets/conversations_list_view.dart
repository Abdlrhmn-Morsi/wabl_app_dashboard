import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart.';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/app_size.dart';
import '../../../../../core/helpers/extensions.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/routing/screen_argument.dart';
import '../../../../../core/widgets/app_pagination_loading_holder.dart';
import '../../../logic/chat_cubit.dart';
import '../../../logic/chat_state.dart';
import 'conversations_list_view_item.dart';

class ConversationsListView extends StatefulWidget {
  const ConversationsListView({super.key});

  @override
  State<ConversationsListView> createState() => _ConversationsListViewState();
}

class _ConversationsListViewState extends State<ConversationsListView> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    ChatCubit.get.emitGetAllChats();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        ChatCubit.get.emitGetAllChats(
          isPagination: true,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ChatCubit, ChatState>(
        buildWhen: (previous, current) =>
            current is Loading ||
            current is Success ||
            current is Error ||
            current is Pagination,
        builder: (context, state) {
          var cubit = ChatCubit.get;
          return state is Loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    await cubit.emitGetAllChats(
                      isRefresh: true,
                    );
                  },
                  child: SizedBox(
                    height: AppSize.fullHight(context),
                    child: ListView.separated(
                      controller: scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.only(bottom: 20.h),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => verticalSpace(20),
                      itemCount: cubit.chatList.length,
                      itemBuilder: (context, index) {
                        var chat = cubit.chatList[index];
                        return AppPaginationLoadingHolder(
                          index: index,
                          isLoadingMore: cubit.isLoadingMore,
                          isReachedEnd: cubit.isReachedEnd,
                          listLength: cubit.chatList.length,
                          item: ConversationsListViewItem(
                            chat: chat,
                            onTap: () {
                              context.pushNamed(
                                Routes.chatScreen,
                                arguments: ScreenArgument({
                                  'chat_with': chat.chatWith,
                                  'chat_id': chat.id,
                                }),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                );
        },
      ),
    );
  }
}
