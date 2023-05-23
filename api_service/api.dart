import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mate/repository/api_service/api_client.dart';
import 'package:mate/repository/api_service/api_methods.dart';
import 'package:mate/repository/api_service/request_keys.dart';
import 'package:mate/repository/model/common_response.dart';
import 'package:mate/repository/model/get_checkins_response.dart';
import 'package:mate/repository/model/get_match_request_response.dart';
import 'package:mate/repository/model/get_match_response.dart';
import 'package:mate/repository/model/get_near_by_checkins_response.dart';
import 'package:mate/repository/model/get_near_by_response.dart';
import 'package:mate/repository/model/get_user_details_response.dart';
import 'package:mate/repository/model/get_user_profile_response.dart';
import 'package:mate/repository/model/interests_list_response.dart';
import 'package:mate/repository/model/like_to_meet_response.dart';
import 'package:mate/repository/model/looking_for_response.dart';
import 'package:mate/repository/model/otp_send_response.dart';
import 'package:mate/repository/model/otp_verify_response.dart';
import 'package:mate/repository/model/profession_list_response.dart';
import 'package:mate/src/utils/constants.dart';
import 'package:mate/src/utils/shared_pre.dart';

class Api {
  final ApiMethods _apiMethods = ApiMethods();
  final ApiClient _apiClient = ApiClient();

  static final Api _api = Api._internal();
  final Connectivity connectivity = Connectivity();

  factory Api() {
    return _api;
  }

  Api._internal();

  Future<Map<String, String>> getHeader() async {
    Map<String, String> header = {};
    try {
      var data = await SharedPre.getObj(SharedPre.userData);
      OtpVerifyResponse userData = OtpVerifyResponse.fromJson(data);
      header[RequestKeys.idHeader] = userData.data?.user?.id.toString() ?? '';
      header[RequestKeys.tokenHeader] = userData.data?.token?.data.toString() ?? '';
    } catch (e) {
      print(e);
    }
    return header;
  }

  Future<SendOtpResponse> sendOtpApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(
        method: _apiMethods.SEND_OTP,
        body: body,
      );
      if (res.isNotEmpty) {
        try {
          return sendOtpResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return SendOtpResponse(
            success: false,
            error: ResError(
              message: AppString.somethingWent,
            ),
          );
        }
      } else {
        return SendOtpResponse(
          success: false,
        );
      }
    } else {
      return SendOtpResponse(
        success: false,
        error: ResError(
          message: AppString.noInternet,
        ),
      );
    }
  }

  Future<OtpVerifyResponse> verifyOtpApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(
        method: _apiMethods.VERIFY_OTP,
        body: body,
      );
      if (res.isNotEmpty) {
        try {
          return otpVerifyResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return OtpVerifyResponse(
            success: false,
            error: ResError(
              message: AppString.somethingWent,
            ),
          );
        }
      } else {
        return OtpVerifyResponse(
          success: false,
        );
      }
    } else {
      return OtpVerifyResponse(
        success: false,
        error: ResError(
          message: AppString.noInternet,
        ),
      );
    }
  }

  Future<GetUserDetailResponse> getUserDetailApi() async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      var header = await getHeader();

      String res = await _apiClient.getMethod(
        method: _apiMethods.USER,
        header: header,
      );
      if (res.isNotEmpty) {
        try {
          return getUserDetailResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return GetUserDetailResponse(
            success: false,
            error: AppString.somethingWent,
          );
        }
      } else {
        return GetUserDetailResponse(
          success: false,
        );
      }
    } else {
      return GetUserDetailResponse(
        success: false,
        error: AppString.noInternet,
      );
    }
  }

  Future<CommonResponse> setupProfileApi(Map<String, dynamic> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      var header = await getHeader();
      final res = await _apiClient.patchMethod(
        method: _apiMethods.PROFILE,
        header: header,
        body: body,
      );
      if (res.isNotEmpty) {
        try {
          return CommonResponse.fromJson(jsonDecode(res));
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return CommonResponse.fromJson(jsonDecode(res));
        }
      } else {
        return CommonResponse(
          success: false,
          error: ResError(
            message: AppString.somethingWent,
          ),
        );
      }
    } else {
      return CommonResponse(
        success: false,
        error: ResError(
          message: AppString.noInternet,
        ),
      );
    }
  }

  Future<GetUserProfileResponse> getUserProfileApi({String? otherUserId}) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      var header = await getHeader();
      String method;
      if (otherUserId != null) {
        method = _apiMethods.PROFILE + '/' + otherUserId;
      } else {
        method = _apiMethods.PROFILE;
      }
      final res = await _apiClient.getMethod(
        method: method,
        header: header,
      );
      if (res.isNotEmpty) {
        try {
          return getUserProfileResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return getUserProfileResponseFromJson(res);
        }
      } else {
        return getUserProfileResponseFromJson(res);
      }
    } else {
      return GetUserProfileResponse(
        success: false,
        error: AppString.noInternet,
      );
    }
  }

  Future<LikeToMeetResponse> getLikeToMeetListApi() async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      final res = await _apiClient.getMethod(
        method: _apiMethods.LIKE_TO_MEET,
      );
      if (res.isNotEmpty) {
        try {
          return likeToMeetResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return likeToMeetResponseFromJson(res);
        }
      } else {
        return LikeToMeetResponse(
          success: false,
          error: AppString.somethingWent,
        );
      }
    } else {
      return LikeToMeetResponse(
        success: false,
        error: AppString.noInternet,
      );
    }
  }

  Future<LookingForListResponse> getLookingForListApi() async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      final res = await _apiClient.getMethod(
        method: _apiMethods.LOOKING_FOR,
      );
      if (res.isNotEmpty) {
        try {
          return lookingForListResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return lookingForListResponseFromJson(res);
        }
      } else {
        return LookingForListResponse(
          success: false,
          error: AppString.somethingWent,
        );
      }
    } else {
      return LookingForListResponse(
        success: false,
        error: AppString.noInternet,
      );
    }
  }

  Future<ProfessionListResponse> getProfessionListApi() async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      final res = await _apiClient.getMethod(
        method: _apiMethods.PROFESSIONS,
      );
      if (res.isNotEmpty) {
        try {
          return professionListResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return professionListResponseFromJson(res);
        }
      } else {
        return ProfessionListResponse(
          success: false,
          error: AppString.somethingWent,
        );
      }
    } else {
      return ProfessionListResponse(
        success: false,
        error: AppString.noInternet,
      );
    }
  }

  Future<InterestsListResponse> getInterestsListApi() async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      final res = await _apiClient.getMethod(
        method: _apiMethods.INTERESTS,
      );
      if (res.isNotEmpty) {
        try {
          return interestsListResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return interestsListResponseFromJson(res);
        }
      } else {
        return InterestsListResponse(
          success: false,
          error: AppString.somethingWent,
        );
      }
    } else {
      return InterestsListResponse(
        success: false,
        error: AppString.noInternet,
      );
    }
  }

  Future<CommonResponse> uploadImageApi({required List<File> files}) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      var header = await getHeader();
      Map<String, String> body = {};
      files.forEach((element) {
        body[RequestKeys.image] = element.path;
      });
      final res = await _apiClient.postMultipartMethod(
        method: _apiMethods.UPLOAD_PIC,
        header: header,
        body: body,
        files: files,
      );
      if (res.isNotEmpty) {
        try {
          return CommonResponse.fromJson(jsonDecode(res));
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return CommonResponse.fromJson(jsonDecode(res));
        }
      } else {
        return CommonResponse(
          success: false,
          error: ResError(
            message: AppString.somethingWent,
          ),
        );
      }
    } else {
      return CommonResponse(
        success: false,
        error: ResError(
          message: AppString.noInternet,
        ),
      );
    }
  }

  Future<CommonResponse> deleteImageApi({required String mediaId}) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      var header = await getHeader();
      String res = await _apiClient.deleteMethod(
        method: _apiMethods.DELETE_MEDIA + mediaId,
        header: header,
      );
      if (res.isNotEmpty) {
        try {
          return CommonResponse.fromJson(jsonDecode(res));
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return CommonResponse.fromJson(jsonDecode(res));
        }
      } else {
        return CommonResponse(
          success: false,
          error: ResError(
            message: AppString.somethingWent,
          ),
        );
      }
    } else {
      return CommonResponse(
        success: false,
        error: ResError(
          message: AppString.noInternet,
        ),
      );
    }
  }

  Future<GetNearByListResponse> getNearByListApi(Position position) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      var header = await getHeader();
      Map<String, String> queryParam = {
        RequestKeys.lat: position.latitude.toString(),
        RequestKeys.lng: position.longitude.toString(),
      };
      String res = await _apiClient.getQueryMethod(
        method: _apiMethods.NEAR_BY,
        query: queryParam,
        header: header,
      );
      if (res.isNotEmpty) {
        try {
          return getNearByListResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return getNearByListResponseFromJson(res);
        }
      } else {
        return GetNearByListResponse(
          success: false,
          error: AppString.somethingWent,
        );
      }
    } else {
      return GetNearByListResponse(
        success: false,
        error: AppString.noInternet,
      );
    }
  }

  Future<CommonResponse> sendMatchRequest(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      var header = await getHeader();
      String res = await _apiClient.postMethod(
        method: _apiMethods.MATCH_REQUEST,
        body: body,
        header: header,
      );
      if (res.isNotEmpty) {
        try {
          return commonResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return CommonResponse(
            success: false,
            error: ResError(
              message: AppString.somethingWent,
            ),
          );
        }
      } else {
        return CommonResponse(
          success: false,
          error: ResError(
            message: AppString.somethingWent,
          ),
        );
      }
    } else {
      return CommonResponse(
        success: false,
        error: ResError(
          message: AppString.noInternet,
        ),
      );
    }
  }

  Future<GetMatchRequestResponse> getMatchRequest() async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      var header = await getHeader();
      String res = await _apiClient.getMethod(
        method: _apiMethods.MATCH_REQUEST,
        header: header,
      );
      if (res.isNotEmpty) {
        try {
          return getMatchRequestResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return getMatchRequestResponseFromJson(res);
        }
      } else {
        return GetMatchRequestResponse(
          success: false,
          error: AppString.somethingWent,
        );
      }
    } else {
      return GetMatchRequestResponse(
        success: false,
        error: AppString.noInternet,
      );
    }
  }

  Future<CommonResponse> checkInZone(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      var header = await getHeader();
      String res = await _apiClient.postMethod(
        method: _apiMethods.CHECKINS,
        body: body,
        header: header,
      );
      if (res.isNotEmpty) {
        try {
          return commonResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return CommonResponse(success: false);
        }
      } else {
        return CommonResponse(success: false);
      }
    } else {
      return CommonResponse(
        success: false,
        error: ResError(
          message: AppString.noInternet,
        ),
      );
    }
  }

  Future<GetCheckinsResponse> getCheckIns() async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      var header = await getHeader();
      String res = await _apiClient.getMethod(
        method: _apiMethods.CHECKINS,
        header: header,
      );
      if (res.isNotEmpty) {
        try {
          return getCheckinsResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return GetCheckinsResponse(
            success: false,
          );
        }
      } else {
        return GetCheckinsResponse(
          success: false,
        );
      }
    } else {
      return GetCheckinsResponse(
        success: false,
        error: AppString.noInternet,
      );
    }
  }

  Future<GetCheckinsResponse> updateChekIns({
    required String checkInId,
    required Map<String, dynamic> body,
  }) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      var header = await getHeader();
      String res = await _apiClient.putMethod(
        method: _apiMethods.CHECKINS + '/$checkInId',
        body: body,
        header: header,
      );
      if (res.isNotEmpty) {
        try {
          return getCheckinsResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return GetCheckinsResponse(
            success: false,
          );
        }
      } else {
        return GetCheckinsResponse(
          success: false,
        );
      }
    } else {
      return GetCheckinsResponse(
        success: false,
        error: AppString.noInternet,
      );
    }
  }

  Future<CommonResponse> checkout({
    required String checkInId,
  }) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      var header = await getHeader();
      String res = await _apiClient.putMethod(
        method: _apiMethods.CHECKINS + '/$checkInId/checkout',
        header: header,
      );
      if (res.isNotEmpty) {
        try {
          return commonResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return CommonResponse(
            success: false,
          );
        }
      } else {
        return CommonResponse(
          success: false,
        );
      }
    } else {
      return CommonResponse(
        success: false,
        error: ResError(
          message: AppString.noInternet,
        ),
      );
    }
  }

  Future<GetNearByCheckinsResponse> getNearbyCheckins({
    required String checkInId,
  }) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      var header = await getHeader();
      String res = await _apiClient.getMethod(
        method: _apiMethods.CHECKINS + '/$checkInId/nearby',
        header: header,
      );
      if (res.isNotEmpty) {
        try {
          return getNearByCheckinsResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return GetNearByCheckinsResponse(
            success: false,
          );
        }
      } else {
        return GetNearByCheckinsResponse(
          success: false,
        );
      }
    } else {
      return GetNearByCheckinsResponse(
        success: false,
        error: ResError(
          message: 'No Internet,',
        ),
      );
    }
  }

  Future<GetMatchResponse> getMatchApi({required bool isChatList}) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      var header = await getHeader();
      Map<String, String> queryParam = {
        RequestKeys.message: isChatList ? '1' : '0',
      };
      String res = await _apiClient.getQueryMethod(
        method: _apiMethods.MATCH,
        header: header,
        query: queryParam,
      );
      if (res.isNotEmpty) {
        try {
          return getMatchResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return GetMatchResponse(
            success: false,
          );
        }
      } else {
        return GetMatchResponse(
          success: false,
        );
      }
    } else {
      return GetMatchResponse(
        success: false,
        error: AppString.noInternet,
      );
    }
  }

  Future<CommonResponse> setMessageStatusApi(String matchId) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      var header = await getHeader();
      Map<String, String> queryParam = {
        RequestKeys.id: matchId,
      };
      String res = await _apiClient.getQueryMethod(
        method: _apiMethods.MESSAGE_STATUS,
        query: queryParam,
        header: header,
      );
      if (res.isNotEmpty) {
        try {
          return commonResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return CommonResponse(
            success: false,
          );
        }
      } else {
        return CommonResponse(
          success: false,
        );
      }
    } else {
      return CommonResponse(
        success: false,
        error: ResError(
          message: AppString.noInternet,
        ),
      );
    }
  }

  Future<CommonResponse> sendFcmTokenToServerApi({required String fcmToken}) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      var header = await getHeader();
      await _apiClient.postMethod(
        method: _apiMethods.SEND_FCM_TOKEN_TO_SERVER,
        body: {
          RequestKeys.registrationToken: fcmToken,
        },
        header: header,
      );
      return CommonResponse(
        success: true,
      );
    } else {
      return CommonResponse(
        success: false,
        error: ResError(
          message: AppString.noInternet,
        ),
      );
    }
  }
}
