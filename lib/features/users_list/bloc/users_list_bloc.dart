import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'users_list_event.dart';
part 'users_list_state.dart';

class UsersListBloc extends Bloc<UsersListEvent, UsersListState> {
  UsersListBloc() : super(UsersListInitial()) {
    on<UsersListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
