import 'package:fotogo/auth/user/user_provider.dart';
import 'package:fotogo/fotogo_protocol/client_service.dart';
import 'package:fotogo/fotogo_protocol/data_types.dart';
import 'package:fotogo/fotogo_protocol/sender.dart';

/// Sends request related to authentication and accounts.
///
/// used by [AuthBloc].
class AuthService {
  final UserProvider _userProvider = UserProvider();
  final ClientService _clientService = ClientService();

  static final _authService = AuthService._();

  AuthService._();

  factory AuthService() => _authService;

  void checkUserExists(String userId) async {
    _clientService.sendRequest(AuthSender.checkUserExists(Request(
        requestType: RequestType.checkUserExists,
        idToken: await _userProvider.idToken)));
  }

  void createAccount() async {
    _clientService.sendRequest(AuthSender.createAccount(Request(
        requestType: RequestType.createAccount,
        idToken: await _userProvider.idToken)));
  }

  void deleteAccount() async {
    _clientService.sendRequest(AuthSender.deleteAccount(Request(
        requestType: RequestType.deleteAccount,
        idToken: await _userProvider.idToken)));
  }
}
