import 'package:mate/repository/model/app_config.dart';

class ApiMethods {
  static final ApiMethods instance = ApiMethods._internal();

  factory ApiMethods() {
    return instance;
  }

  ApiMethods._internal();
  static String DOMAIN = AppConfig.shared.config.baseUrl;
  static const String VERSION = 'v1/';
  static String HOST = DOMAIN + VERSION;

  ///[Methods Apis]
  String SEND_OTP = HOST + 'auth/sms-otp';
  String VERIFY_OTP = HOST + 'auth/otp-verify';
  String PROFILE = HOST + 'profiles'; // also used for updating user profile
  String UPLOAD_PIC = HOST + 'profiles/upload';
  String MATCH_REQUEST = HOST + 'matches/requests';
  String MATCH = VERSION + 'matches';
  String USER = HOST + 'users';
  String LIKE_TO_MEET = DOMAIN + 'like-to-meet';
  String PROFESSIONS = DOMAIN + 'professions';
  String INTERESTS = DOMAIN + 'interests';
  String LOOKING_FOR = DOMAIN + 'looking-for';
  String NEAR_BY = '/' + VERSION + 'profiles/nearby';
  String OTHER_USER_PROFILE = VERSION + 'profiles/';
  String SOCKET_SERVER_URL = '';
  String CHECKINS = HOST + 'checkins';
  String DELETE_MEDIA = HOST + 'profiles/media/';
  String MESSAGE_STATUS = VERSION + 'matches/message-status';
  String SEND_FCM_TOKEN_TO_SERVER = HOST + 'notifications/register';
}
