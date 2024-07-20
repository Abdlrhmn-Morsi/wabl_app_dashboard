import 'package:flutter_bloc/flutter_bloc.dart.';
import 'update_group_state.dart';

class UpdateGroupCubit extends Cubit<UpdateGroupState> {
  UpdateGroupCubit() : super(const UpdateGroupState.initial());
}
