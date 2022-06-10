import 'package:firebase_auth/firebase_auth.dart';
import 'package:fotogo/admin/admin_data_types.dart';
import 'package:fotogo/admin/admin_repository.dart';
import 'package:fotogo/auth/user/user_provider.dart';
import 'package:fotogo/fotogo_protocol/client_service.dart';
import 'package:fotogo/fotogo_protocol/data_types.dart';
import 'package:fotogo/fotogo_protocol/sender.dart';

class AdminService {
  final AdminRepository _adminRepository = AdminRepository();
  final ClientService _clientService = ClientService();
  final UserProvider _userProvider = UserProvider();

  static final AdminService _adminService = AdminService._();

  AdminService._();

  factory AdminService() => _adminService;

  AppStatistics? get appStatistics => _adminRepository.appStatistics;

  List<UserData>? get usersData => _adminRepository.usersData;

  void generateStatistics() async {
    _clientService.sendRequest(AdminSender.generateStatistics(Request(
      requestType: RequestType.generateStatistics,
      idToken: await _userProvider.idToken,
    )));
  }

  void updateStatistics(Map response) {
    _adminRepository.appStatistics = AppStatistics(
        usersCount: response['usr_count'],
        albumsCount: response['albm_count'],
        imagesCount: response['img_count']);
  }

  void getUsersData() async {
    _clientService.sendRequest(AdminSender.getUsers(Request(
      requestType: RequestType.getUsers,
      idToken: await _userProvider.idToken,
    )));
  }

  void updateUsersData(List response) {
    _adminRepository.usersData = List.generate(
        response.length,
        (index) => UserData(
              uid: response[index]['id'],
              displayName: response[index]['name'],
              email: response[index]['email'],
              photoUrl: response[index]['photo_url'],
              privilegeLevel: UserType.values[response[index]['priv']],
            ));
  }

  void deleteUser(String uid) async {
    _clientService.sendRequest(AdminSender.deleteUser(Request(
      requestType: RequestType.adminDeleteUser,
      idToken: await _userProvider.idToken,
      args: {'uid': uid},
    )));
  }

  void updateDeletedUser(String uid) {
    _adminRepository.usersData?.removeWhere((element) => element.uid == uid);
    _adminRepository.appStatistics?.usersCount--;
  }
}
