import 'package:bloc/bloc.dart';
import 'package:frontend_task1/models/login_detail.dart';
import 'package:frontend_task1/models/user.dart';
import 'package:frontend_task1/repository/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(super.initialState, this.authRepository);

  Future<void> login(String username, String password) async {
    emit(LoadingAuthState());

    LoginDetail loginDetail = LoginDetail(username, password);

    try {
      final response = await authRepository.login(loginDetail);
      emit(AuthenticatedState(response));

    } catch (e) {
      emit(ErrorAuthState(e.toString()));
    }
  }
  Future<void> register(String email, String password, String confirmPasswrod,
      String firstname, String lastname, String username) async {

    emit(LoadingAuthState());

    User user = User(0, username, firstname, lastname, email, password);
    try {
      final response = await authRepository.register(user);
      emit(InitAuthState());

    } catch (e) {
      emit(ErrorAuthState(e.toString()));
    }
  }
  void logout() {
    emit(UnauthenticatedState());
  }
}
