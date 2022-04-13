import 'package:fotogo/auth/user/user_provider.dart';
import 'package:fotogo/fotogo_protocol/client_service.dart';

class AuthService {
  final UserProvider _userProvider = UserProvider();
  final ClientService _clientService = ClientService();

  static final _authService = AuthService._();

  AuthService._();

  factory AuthService() => _authService;

  void createAccount() {}

  void deleteAccount() {}
}
