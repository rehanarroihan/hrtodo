import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hrtodo/models/user.dart';
import 'package:hrtodo/utils/constant_helper.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final List<User> _mockUserList = [
    User(
      username: 'hr',
      role: ConstantHelper.userRoleHR,
      password: 'hr'
    ),
    User(
      username: 'manager',
      role: ConstantHelper.userRoleManager,
      password: 'manager'
    ),
  ];

  bool isLoginLoading = false;

  void login(String username, String password) async {
    isLoginLoading = true;
    emit(LoginInit());

    try {
      List<User> loginResult = _mockUserList.where(
        (user) => user.username == username && user.password == password
      ).toList();

      // Mocking loading
      await Future.delayed(const Duration(seconds: 1));

      isLoginLoading = false;

      if (loginResult.isEmpty) {
        throw Exception("Invalid username or password");
      } else {
        emit(LoginSuccessful(loginResult.first));
      }
    } catch (e) {
      emit(LoginFailed(e.toString()));
    }
  }
}
