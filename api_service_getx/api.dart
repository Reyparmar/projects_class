import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:digitalerp/response/add_customer_to_visit_response.dart';
import 'package:digitalerp/response/add_to_cart_response.dart';
import 'package:digitalerp/response/all_visit_data_response.dart';
import 'package:digitalerp/response/approved_or_rejected_leave_response.dart';
import 'package:digitalerp/response/area_data_response.dart';
import 'package:digitalerp/response/attendance_list_response.dart';
import 'package:digitalerp/response/attendance_summary_response.dart';
import 'package:digitalerp/response/brand_list_data_response.dart';
import 'package:digitalerp/response/cart_count_response.dart';
import 'package:digitalerp/response/cash_bank_ledger_response.dart';
import 'package:digitalerp/response/city_data_response.dart';
import 'package:digitalerp/response/collection_customer_list_response.dart';
import 'package:digitalerp/response/collection_list_response.dart';
import 'package:digitalerp/response/customer_data_response.dart';
import 'package:digitalerp/response/customer_detail_response.dart';
import 'package:digitalerp/response/customer_location_update_response.dart';
import 'package:digitalerp/response/customer_remarks_update_response.dart';
import 'package:digitalerp/response/dashboard_details_response.dart';
import 'package:digitalerp/response/delete_visit_data_response.dart';
import 'package:digitalerp/response/dsr_pdf_response.dart';
import 'package:digitalerp/response/executive_list_response.dart';
import 'package:digitalerp/response/executive_list_with_lat_long_response.dart';
import 'package:digitalerp/response/executive_order_list_response.dart';
import 'package:digitalerp/response/exicutive_whole_day_location_response.dart';
import 'package:digitalerp/response/forgot_otp_verfiy_response.dart';
import 'package:digitalerp/response/forgot_pass_response.dart';
import 'package:digitalerp/response/get_cart_list_response.dart';
import 'package:digitalerp/response/get_executive_dropdown_response.dart';
import 'package:digitalerp/response/login_response.dart';
import 'package:digitalerp/response/logout_response.dart';
import 'package:digitalerp/response/menu_details_response.dart';
import 'package:digitalerp/response/nearby_data_response.dart';
import 'package:digitalerp/response/order_detail_pdf_url_response.dart';
import 'package:digitalerp/response/order_detail_response.dart';
import 'package:digitalerp/response/otp_verify_response.dart';
import 'package:digitalerp/response/outstanding_data_response.dart';
import 'package:digitalerp/response/party_balance_detail_response.dart';
import 'package:digitalerp/response/party_dropdown_list_response.dart';
import 'package:digitalerp/response/party_latlng_check_response.dart';
import 'package:digitalerp/response/party_ledger_response.dart';
import 'package:digitalerp/response/payment_entry_submit_response.dart';
import 'package:digitalerp/response/pending_leave_list_response.dart';
import 'package:digitalerp/response/preview_visit_data_response.dart';
import 'package:digitalerp/response/product_detail_response.dart';
import 'package:digitalerp/response/related_product_response.dart';
import 'package:digitalerp/response/state_data_response.dart';
import 'package:digitalerp/response/stcok_category_data_response.dart';
import 'package:digitalerp/response/stock_submit_data_response.dart';
import 'package:digitalerp/response/submit_visit_data_response.dart';
import 'package:digitalerp/response/token_update_response.dart';
import 'package:digitalerp/response/transaction_list_response.dart';
import 'package:digitalerp/response/unit_list_response.dart';
import 'package:digitalerp/response/update_cart_quantity_response.dart';
import 'package:digitalerp/response/update_profile_response.dart';
import 'package:digitalerp/response/validate_user_order_response.dart';
import 'package:digitalerp/response/visit_check_in_response.dart';
import 'package:digitalerp/response/visit_check_out_response.dart';
import 'package:digitalerp/response/visit_plan_detail_data_response.dart';
import 'package:digitalerp/response/voucher_list_response.dart';
import 'package:digitalerp/services/api_service/api_client.dart';
import 'package:digitalerp/services/api_service/api_methods.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:flutter/foundation.dart';

import '../../response/select_category_list_response.dart';
import '../../response/subcategory_brand_response.dart';

class Api {
  final ApiMethods _apiMethods = ApiMethods();
  final ApiClient _apiClient = ApiClient();

  static final Api _api = Api._internal();
  final Connectivity connectivity = Connectivity();

  factory Api() {
    return _api;
  }

  Api._internal();

  Map<String, String> getHeader() {
    return {'Content-Type': 'application/json'};
  }

  Future<LoginResponse> loginApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.login, body: body);
      if (res.isNotEmpty) {
        try {
          return loginResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return LoginResponse(status: 500, message: e.toString());
        }
      } else {
        return LoginResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return LoginResponse(status: 500, message: 'No Internet');
    }
  }

  Future<ExecutiveDropdownResponse> getExecutiveDropdown(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.executiveDropDown, body: body);
      if (res.isNotEmpty) {
        try {
          return executiveDropdownResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return ExecutiveDropdownResponse(status: 500, message: e.toString());
        }
      } else {
        return ExecutiveDropdownResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return ExecutiveDropdownResponse(status: 500, message: 'No Internet');
    }
  }

  Future<UpdateProfileResponse> updateProfileJson(var body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      try {
        String res = await _apiClient.postMethodJson(
            method: _apiMethods.updateProfile, body: body, header: {'Content-Type': 'application/json'});
        if (res.isNotEmpty) {
          return updateProfileResponseFromJson(res);
        } else {
          return UpdateProfileResponse(
            status: 500,
            message: 'Something went wrong',
          );
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        return UpdateProfileResponse(
          status: 500,
          message: e.toString(),
        );
      }
    } else {
      return UpdateProfileResponse(
        status: 500,
        message: 'No Internet',
      );
    }
  }

  Future<OtpVerifyResponse> otpVerify(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.mobileOtpVerify, body: body);
      if (res.isNotEmpty) {
        try {
          return otpVerifyResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return OtpVerifyResponse(status: 500, message: e.toString());
        }
      } else {
        return OtpVerifyResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return OtpVerifyResponse(status: 500, message: 'No internet');
    }
  }

  Future<TokenUpdateResponse> tokenUpdate(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.updateToken, body: body);
      if (res.isNotEmpty) {
        try {
          return tokenUpdateResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return TokenUpdateResponse(status: 500, message: e.toString());
        }
      } else {
        return TokenUpdateResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return TokenUpdateResponse(status: 500, message: 'No internet');
    }
  }

  Future<MenuDetailsResponse> getMenuList(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.menuDetails, body: body);
      if (res.isNotEmpty) {
        try {
          return menuDetailsResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return MenuDetailsResponse(status: 500, message: e.toString());
        }
      } else {
        return MenuDetailsResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return MenuDetailsResponse(status: 500, message: 'No internet');
    }
  }

  Future<DashboardDetailsResponse> getDashboardDetails(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.dashboardDetails, body: body);
      if (res.isNotEmpty) {
        try {
          return dashboardDetailsResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return DashboardDetailsResponse(status: 500, message: e.toString());
        }
      } else {
        return DashboardDetailsResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return DashboardDetailsResponse(status: 500, message: 'No internet');
    }
  }

  Future<AttendanceSummaryResponse> getAttendanceSummary(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.attendanceSummary, body: body);
      if (res.isNotEmpty) {
        try {
          return attendanceSummaryResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return AttendanceSummaryResponse(status: 500, message: e.toString());
        }
      } else {
        return AttendanceSummaryResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return AttendanceSummaryResponse(status: 500, message: 'No internet');
    }
  }

  Future<AttendanceListResponse> getAttendanceList(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.attendanceList, body: body);
      if (res.isNotEmpty) {
        try {
          return attendanceListResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return AttendanceListResponse(status: 500, message: e.toString());
        }
      } else {
        return AttendanceListResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return AttendanceListResponse(status: 500, message: 'No internet');
    }
  }

  Future<CommonResponse> markAttendance(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.markAttendance, body: body);
      if (res.isNotEmpty) {
        try {
          return commonResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return CommonResponse(status: 500, message: e.toString());
        }
      } else {
        return CommonResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return CommonResponse(status: 500, message: 'No internet');
    }
  }

  Future<CommonResponse> logout(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.logout, body: body);
      if (res.isNotEmpty) {
        try {
          return commonResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return CommonResponse(status: 500, message: e.toString());
        }
      } else {
        return CommonResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return CommonResponse(status: 500, message: 'No internet');
    }
  }

  Future<CommonResponse> applyLeave(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.applyLeave, body: body);
      if (res.isNotEmpty) {
        try {
          return commonResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return CommonResponse(status: 500, message: e.toString());
        }
      } else {
        return CommonResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return CommonResponse(status: 500, message: 'No internet');
    }
  }

  Future<ApprovedOrRejectLeaveResponse> getLeaveDetail(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.getLeaveData, body: body);
      if (res.isNotEmpty) {
        try {
          return approvedOrRejectLeaveResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return ApprovedOrRejectLeaveResponse(status: 500, message: e.toString());
        }
      } else {
        return ApprovedOrRejectLeaveResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return ApprovedOrRejectLeaveResponse(status: 500, message: 'No internet');
    }
  }

  Future<ApprovedOrRejectLeaveResponse> getLeaveHistoryDetail(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.leaveHistory, body: body);
      if (res.isNotEmpty) {
        try {
          return approvedOrRejectLeaveResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return ApprovedOrRejectLeaveResponse(status: 500, message: e.toString());
        }
      } else {
        return ApprovedOrRejectLeaveResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return ApprovedOrRejectLeaveResponse(status: 500, message: 'No internet');
    }
  }

  Future<PendingLeaveListResponse> getPendingLeaveList(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.pendingLeaveList, body: body);
      if (res.isNotEmpty) {
        try {
          return pendingLeaveListResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return PendingLeaveListResponse(status: 500, message: e.toString());
        }
      } else {
        return PendingLeaveListResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return PendingLeaveListResponse(status: 500, message: 'No internet');
    }
  }

  Future<CommonResponse> updateLeaveStatus(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.updateLeaveStatus, body: body);
      if (res.isNotEmpty) {
        try {
          return commonResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return CommonResponse(status: 500, message: e.toString());
        }
      } else {
        return CommonResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return CommonResponse(status: 500, message: 'No internet');
    }
  }

  Future<ExecutiveListResponse> getExecutiveListWithLatLong(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.executiveListWithLatAndLong, body: body);
      if (res.isNotEmpty) {
        try {
          return executiveListResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return ExecutiveListResponse(status: 500, message: e.toString());
        }
      } else {
        return ExecutiveListResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return ExecutiveListResponse(status: 500, message: 'No internet');
    }
  }

  Future<ExecutiveOrderListResponse> getExecutiveOrderList(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.executiveOrderList, body: body);
      if (res.isNotEmpty) {
        try {
          return executiveOrderListResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return ExecutiveOrderListResponse(status: 500, message: e.toString());
        }
      } else {
        return ExecutiveOrderListResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return ExecutiveOrderListResponse(status: 500, message: 'No internet');
    }
  }

  Future<PartyDropdownListResponse> getPartyDropdownList(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.partyDropdownNew, body: body);
      if (res.isNotEmpty) {
        try {
          return partyDropdownListResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return PartyDropdownListResponse(status: 500, message: e.toString());
        }
      } else {
        return PartyDropdownListResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return PartyDropdownListResponse(status: 500, message: 'No Internet');
    }
  }

  Future<UserValidateForOrderResponse> checkPartyValidation(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.validateUserForOrder, body: body);
      if (res.isNotEmpty) {
        try {
          return userValidateForOrderResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return UserValidateForOrderResponse(status: 500, message: e.toString());
        }
      } else {
        return UserValidateForOrderResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return UserValidateForOrderResponse(status: 500, message: 'No Internet');
    }
  }

  Future<PartylatLngCheck> matchPartyLatLng(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.matchUserLocation, body: body);
      if (res.isNotEmpty) {
        try {
          return partylatLngCheckFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return PartylatLngCheck(status: 500, message: e.toString());
        }
      } else {
        return PartylatLngCheck(status: 500, message: 'Something went wrong');
      }
    } else {
      return PartylatLngCheck(status: 500, message: 'No Internet');
    }
  }

  Future<OrderDetailResponse> getOrderDetail(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.singleOrderDetail, body: body);
      if (res.isNotEmpty) {
        try {
          return orderDetailResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return OrderDetailResponse(status: 500, message: e.toString());
        }
      } else {
        return OrderDetailResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return OrderDetailResponse(status: 500, message: 'No Internet');
    }
  }

  Future<OrderDetailPdfDownloadResponse> getOrderDetailPdfUrl(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.getOrderPdf, body: body);
      if (res.isNotEmpty) {
        try {
          return orderDetailPdfDownloadResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return OrderDetailPdfDownloadResponse(status: 500, message: e.toString());
        }
      } else {
        return OrderDetailPdfDownloadResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return OrderDetailPdfDownloadResponse(status: 500, message: 'No Internet');
    }
  }

  Future<CommonResponse> updateOrderStatusApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.updateOrderStatus, body: body);
      if (res.isNotEmpty) {
        try {
          return commonResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return CommonResponse(status: 500, message: e.toString());
        }
      } else {
        return CommonResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return CommonResponse(status: 500, message: 'No internet');
    }
  }

  Future<PartyBalanceDetailResponse> getPartyBalanceDetail(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.partyBalanceDetail, body: body);
      if (res.isNotEmpty) {
        try {
          return partyBalanceDetailResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return PartyBalanceDetailResponse(status: 500, message: e.toString());
        }
      } else {
        return PartyBalanceDetailResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return PartyBalanceDetailResponse(status: 500, message: 'No internet');
    }
  }

  Future<CommonResponse> saveLocationRoute(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.locationRouteSave, body: body);
      if (res.isNotEmpty) {
        try {
          return commonResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return CommonResponse(status: 500, message: e.toString());
        }
      } else {
        return CommonResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return CommonResponse(status: 500, message: 'No internet');
    }
  }

  Future<ExecutiveDayLocationDataResponse> getExecutiveDayLocationData(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.executiveDayLocation, body: body);
      if (res.isNotEmpty) {
        try {
          return executiveDayLocationDataResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return ExecutiveDayLocationDataResponse(status: 500, message: e.toString());
        }
      } else {
        return ExecutiveDayLocationDataResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return ExecutiveDayLocationDataResponse(status: 500, message: 'No internet');
    }
  }

  Future<ForgotPasswordResponse> forgotPasswordAPI(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.forgotPassword, body: body);
      if (res.isNotEmpty) {
        try {
          return forgotPasswordResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return ForgotPasswordResponse(status: 500, message: e.toString());
        }
      } else {
        return ForgotPasswordResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return ForgotPasswordResponse(status: 500, message: 'No internet');
    }
  }

  Future<ForgotOtpVerifyResponse> forgotOtpVerifyAPI(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.forgotOtpVerify, body: body);
      if (res.isNotEmpty) {
        try {
          return forgotOtpVerifyResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return ForgotOtpVerifyResponse(status: 500, message: e.toString());
        }
      } else {
        return ForgotOtpVerifyResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return ForgotOtpVerifyResponse(status: 500, message: 'No internet');
    }
  }

  Future<CommonResponse> resetPassword(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.resetPassword, body: body);
      if (res.isNotEmpty) {
        try {
          return commonResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return CommonResponse(status: 500, message: e.toString());
        }
      } else {
        return CommonResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return CommonResponse(status: 500, message: 'No internet');
    }
  }

  Future<SelectCategoryListPageBanner> getBannerData(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.categoryBannerImage, body: body);
      if (res.isNotEmpty) {
        try {
          return selectCategoryListPageBannerFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return SelectCategoryListPageBanner(status: 500, message: e.toString());
        }
      } else {
        return SelectCategoryListPageBanner(status: 500, message: 'Something went wrong');
      }
    } else {
      return SelectCategoryListPageBanner(status: 500, message: 'No Internet');
    }
  }

  Future<BrandDataResponse> getBrandData(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.brandDataList, body: body);
      if (res.isNotEmpty) {
        try {
          return brandDataResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return BrandDataResponse(status: 500, message: e.toString());
        }
      } else {
        return BrandDataResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return BrandDataResponse(status: 500, message: 'No Internet');
    }
  }

  Future<CategoryData> getCategoryData(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.categoryBrandDataList, body: body);
      if (res.isNotEmpty) {
        try {
          return categoryDataFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return CategoryData(status: 500, message: e.toString());
        }
      } else {
        return CategoryData(status: 500, message: 'Something went wrong');
      }
    } else {
      return CategoryData(status: 500, message: 'No Internet');
    }
  }

  Future<SubCategoryBrandData> getSubCategoryBrandData(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.subcategoryList, body: body);
      if (res.isNotEmpty) {
        try {
          return subCategoryBrandDataFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return SubCategoryBrandData(status: 500, message: e.toString());
        }
      } else {
        return SubCategoryBrandData(status: 500, message: 'Something went wrong');
      }
    } else {
      return SubCategoryBrandData(status: 500, message: 'No Internet');
    }
  }

  Future<ProductData> getProductData(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.productListItem, body: body);
      if (res.isNotEmpty) {
        try {
          return productDataFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return ProductData(status: 500, message: e.toString());
        }
      } else {
        return ProductData(status: 500, message: 'Something went wrong');
      }
    } else {
      return ProductData(status: 500, message: 'No Internet');
    }
  }

  Future<ProductDetailResponse> productDetail(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.productDetails, body: body);
      if (res.isNotEmpty) {
        try {
          return productDetailResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return ProductDetailResponse(status: 500, message: e.toString());
        }
      } else {
        return ProductDetailResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return ProductDetailResponse(status: 500, message: 'No internet');
    }
  }

  Future<UnitListResponse> unitDetail(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.unitDetails, body: body);
      if (res.isNotEmpty) {
        try {
          return unitListResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return UnitListResponse(status: 500, message: e.toString());
        }
      } else {
        return UnitListResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return UnitListResponse(status: 500, message: 'No internet');
    }
  }

  Future<RelatedProductsResponse> relatedProducts(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.itemListVariant, body: body);
      if (res.isNotEmpty) {
        try {
          return relatedProductsResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return RelatedProductsResponse(status: 500, message: e.toString());
        }
      } else {
        return RelatedProductsResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return RelatedProductsResponse(status: 500, message: 'No internet');
    }
  }

  Future<CommonResponse> addCompanyJson(var body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      try {
        String res = await _apiClient.postMethodJson(
            method: _apiMethods.addPartyOrCompanyNew, body: body, header: {'Content-Type': 'application/json'});
        if (res.isNotEmpty) {
          return commonResponseFromJson(res);
        } else {
          return CommonResponse(
            status: 500,
            message: 'Something went wrong',
          );
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        return CommonResponse(
          status: 500,
          message: e.toString(),
        );
      }
    } else {
      return CommonResponse(
        status: 500,
        message: 'No Internet',
      );
    }
  }

  Future<GetCartListResponse> getCartList(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.getCartDetail, body: body);
      if (res.isNotEmpty) {
        try {
          return getCartListResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return GetCartListResponse(status: 500, message: e.toString());
        }
      } else {
        return GetCartListResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return GetCartListResponse(status: 500, message: 'No internet');
    }
  }

  Future<AddToCartResponse> addToCart(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.addToCart, body: body);
      if (res.isNotEmpty) {
        try {
          return addToCartResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return AddToCartResponse(status: 500, message: e.toString());
        }
      } else {
        return AddToCartResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return AddToCartResponse(status: 500, message: 'No internet');
    }
  }

  Future<AddToCartResponse> removeFromCart(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.removeFromCart, body: body);
      if (res.isNotEmpty) {
        try {
          return addToCartResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return AddToCartResponse(status: 500, message: e.toString());
        }
      } else {
        return AddToCartResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return AddToCartResponse(status: 500, message: 'No internet');
    }
  }

  Future<UpdateCart> updateCart(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.updateCartDecimalQty, body: body);
      if (res.isNotEmpty) {
        try {
          return updateCartFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return UpdateCart(status: 500, message: e.toString());
        }
      } else {
        return UpdateCart(status: 500, message: 'Something went wrong');
      }
    } else {
      return UpdateCart(status: 500, message: 'No internet');
    }
  }

  Future<CommonResponse> orderPlace(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.placeOrder, body: body);
      if (res.isNotEmpty) {
        try {
          return commonResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return CommonResponse(status: 500, message: e.toString());
        }
      } else {
        return CommonResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return CommonResponse(status: 500, message: 'No internet');
    }
  }

  Future<CartCountResponse> getCartCount(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.cartCount, body: body);
      if (res.isNotEmpty) {
        try {
          return cartCountResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return CartCountResponse(status: 500, message: e.toString());
        }
      } else {
        return CartCountResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return CartCountResponse(status: 500, message: 'No internet');
    }
  }

  Future<CustomerDetailResponse> getCustomersDetail(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.customersList, body: body);
      if (res.isNotEmpty) {
        try {
          return customerDetailResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return CustomerDetailResponse(status: 500, message: e.toString());
        }
      } else {
        return CustomerDetailResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return CustomerDetailResponse(status: 500, message: 'No internet');
    }
  }

  Future<CustomerLocationUpdateResponse> updateCustomersLocation(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.updateCustomerLocation, body: body);
      if (res.isNotEmpty) {
        try {
          return customerLocationUpdateResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return CustomerLocationUpdateResponse(status: 500, message: e.toString());
        }
      } else {
        return CustomerLocationUpdateResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return CustomerLocationUpdateResponse(status: 500, message: 'No internet');
    }
  }

  Future<CustomerRemarkUpdateResponse> updateCustomersRemarks(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.updateCustomerRemark, body: body);
      if (res.isNotEmpty) {
        try {
          return customerRemarkUpdateResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return CustomerRemarkUpdateResponse(status: 500, message: e.toString());
        }
      } else {
        return CustomerRemarkUpdateResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return CustomerRemarkUpdateResponse(status: 500, message: 'No internet');
    }
  }

  Future<DsrPdfResponse> getDSRPdf(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.getDsrPdf, body: body);
      if (res.isNotEmpty) {
        try {
          return dsrPdfResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return DsrPdfResponse(status: 500, message: e.toString());
        }
      } else {
        return DsrPdfResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return DsrPdfResponse(status: 500, message: 'No internet');
    }
  }

  Future<ExecutiveListDataResponse> getExecutiveListData(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.executiveListData, body: body);
      if (res.isNotEmpty) {
        try {
          return executiveListDataResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return ExecutiveListDataResponse(status: 500, message: e.toString());
        }
      } else {
        return ExecutiveListDataResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return ExecutiveListDataResponse(status: 500, message: 'No internet');
    }
  }

  Future<StateDataResponse> getStateData(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.stateNameList, body: body);
      if (res.isNotEmpty) {
        try {
          return stateDataResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return StateDataResponse(status: 500, message: e.toString());
        }
      } else {
        return StateDataResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return StateDataResponse(status: 500, message: 'No internet');
    }
  }

  Future<CityDataResponse> getCityData(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.cityNameList, body: body);
      if (res.isNotEmpty) {
        try {
          return cityDataResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return CityDataResponse(status: 500, message: e.toString());
        }
      } else {
        return CityDataResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return CityDataResponse(status: 500, message: 'No internet');
    }
  }

  Future<AreaDataResponse> getAreaData(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.areaNameList, body: body);
      if (res.isNotEmpty) {
        try {
          return areaDataResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return AreaDataResponse(status: 500, message: e.toString());
        }
      } else {
        return AreaDataResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return AreaDataResponse(status: 500, message: 'No internet');
    }
  }

  Future<StockCategoryDataResponse> getStockCategoryData(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.stockCategory, body: body);
      if (res.isNotEmpty) {
        try {
          return stockCategoryDataResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return StockCategoryDataResponse(status: 500, message: e.toString());
        }
      } else {
        return StockCategoryDataResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return StockCategoryDataResponse(status: 500, message: 'No internet');
    }
  }

  Future<StockSubmitDataResponse> stockSubmitData(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.stockTaking, body: body);
      if (res.isNotEmpty) {
        try {
          return stockSubmitDataResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return StockSubmitDataResponse(status: 500, message: e.toString());
        }
      } else {
        return StockSubmitDataResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return StockSubmitDataResponse(status: 500, message: 'No internet');
    }
  }

  Future<CustomerDataResponse> customerListData(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.searchAreaWiseClientForVisit, body: body);
      if (res.isNotEmpty) {
        try {
          return customerDataResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return CustomerDataResponse(status: 500, message: e.toString());
        }
      } else {
        return CustomerDataResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return CustomerDataResponse(status: 500, message: 'No internet');
    }
  }

  Future<AddCustomerToVisitDataResponse> addVisitDataToVisit(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.addToVisit, body: body);
      if (res.isNotEmpty) {
        try {
          return addCustomerToVisitDataResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return AddCustomerToVisitDataResponse(status: 500, message: e.toString());
        }
      } else {
        return AddCustomerToVisitDataResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return AddCustomerToVisitDataResponse(status: 500, message: 'No internet');
    }
  }

  Future<NearByDataResponse> nearByData(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.nearByList, body: body);
      if (res.isNotEmpty) {
        try {
          return nearByDataResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return NearByDataResponse(status: 500, message: e.toString());
        }
      } else {
        return NearByDataResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return NearByDataResponse(status: 500, message: 'No internet');
    }
  }

  Future<PreviewVisitDataResponse> previewVisitData(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.previewVisitList, body: body);
      if (res.isNotEmpty) {
        try {
          return previewVisitDataResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return PreviewVisitDataResponse(status: 500, message: e.toString());
        }
      } else {
        return PreviewVisitDataResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return PreviewVisitDataResponse(status: 500, message: 'No internet');
    }
  }

  Future<DeleteVisitDataResponse> deleteVisitData(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.deleteVisitList, body: body);
      if (res.isNotEmpty) {
        try {
          return deleteVisitDataResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return DeleteVisitDataResponse(status: 500, message: e.toString());
        }
      } else {
        return DeleteVisitDataResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return DeleteVisitDataResponse(status: 500, message: 'No internet');
    }
  }

  Future<SubmitVisitDataResponse> saveVisitData(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.saveVisitEntry, body: body);
      if (res.isNotEmpty) {
        try {
          return submitVisitDataResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return SubmitVisitDataResponse(status: 500, message: e.toString());
        }
      } else {
        return SubmitVisitDataResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return SubmitVisitDataResponse(status: 500, message: 'No internet');
    }
  }

  Future<AllVisitDataResponse> allVisitListData(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.allVisitList, body: body);
      if (res.isNotEmpty) {
        try {
          return allVisitDataResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return AllVisitDataResponse(status: 500, message: e.toString());
        }
      } else {
        return AllVisitDataResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return AllVisitDataResponse(status: 500, message: 'No internet');
    }
  }

  Future<VisitPlanDetailDataResponse> visitPlanDetailListData(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.visitPlanDetail, body: body);
      if (res.isNotEmpty) {
        try {
          return visitPlanDetailDataResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return VisitPlanDetailDataResponse(status: 500, message: e.toString());
        }
      } else {
        return VisitPlanDetailDataResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return VisitPlanDetailDataResponse(status: 500, message: 'No internet');
    }
  }

  Future<VisitCheckInResponse> visitCheckInData(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.visitCheckIn, body: body);
      if (res.isNotEmpty) {
        try {
          return visitCheckInResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return VisitCheckInResponse(status: 500, message: e.toString());
        }
      } else {
        return VisitCheckInResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return VisitCheckInResponse(status: 500, message: 'No internet');
    }
  }

  Future<VisitCheckOutResponse> visitCheckOutData(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.visitPlanCheckout, body: body);
      if (res.isNotEmpty) {
        try {
          return visitCheckOutResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return VisitCheckOutResponse(status: 500, message: e.toString());
        }
      } else {
        return VisitCheckOutResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return VisitCheckOutResponse(status: 500, message: 'No internet');
    }
  }

  Future<CashAndbankLedgerResponse> cashAndBankLedgerData(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.showCashAndBankAccount, body: body);
      if (res.isNotEmpty) {
        try {
          return cashAndbankLedgerResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return CashAndbankLedgerResponse(status: 500, message: e.toString());
        }
      } else {
        return CashAndbankLedgerResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return CashAndbankLedgerResponse(status: 500, message: 'No internet');
    }
  }

  Future<PaymentEntrySubmitResponse> collectionEntrySubmitData(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethodJson(
        method: _apiMethods.paymentEntrySubmit,
        body: json.encode(body),
        header: {'Content-Type': 'application/json'},
      );
      if (res.isNotEmpty) {
        try {
          return paymentEntrySubmitResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return PaymentEntrySubmitResponse(status: 500, message: e.toString());
        }
      } else {
        return PaymentEntrySubmitResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return PaymentEntrySubmitResponse(status: 500, message: 'No internet');
    }
  }

  Future<CollectionCustomerListResponse> collectionCustomerList(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.customerList, body: body);
      if (res.isNotEmpty) {
        try {
          return collectionCustomerListResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return CollectionCustomerListResponse(status: 500, message: e.toString());
        }
      } else {
        return CollectionCustomerListResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return CollectionCustomerListResponse(status: 500, message: 'No internet');
    }
  }

  Future<CommonResponse> collectionEntrySubmit(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(
          method: _apiMethods.collectionEntry, body: jsonEncode(body), header: {'Content-Type': 'application/json'});
      if (res.isNotEmpty) {
        try {
          return commonResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return CommonResponse(status: 500, message: e.toString());
        }
      } else {
        return CommonResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return CommonResponse(status: 500, message: 'No internet');
    }
  }

  Future<CollectionListResponse> collectionList({
    required String compId,
    required String branchId,
    required String userId,
    required String partyId,
    required String fromDate,
    required String toDate,
  }) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      Map<String, String> body = {
        RequestKeys.voucherType: VoucherType.collection,
        RequestKeys.compId: compId,
        RequestKeys.branchId: branchId,
        RequestKeys.userId: userId,
        RequestKeys.partyId: partyId,
        RequestKeys.fromDate: fromDate,
        RequestKeys.toDate: toDate
      };

      String res = await _apiClient.postMethod(method: _apiMethods.listWithFilter, body: body);
      if (res.isNotEmpty) {
        try {
          return collectionListResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return CollectionListResponse(status: 500, message: e.toString());
        }
      } else {
        return CollectionListResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return CollectionListResponse(status: 500, message: 'No internet');
    }
  }

  Future<CollectionListResponse> listWithFilter({
    required String voucherType,
    required String compId,
    required String branchId,
    required String userId,
    required String partyId,
    required String fromDate,
    required String toDate,
  }) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      Map<String, String> body = {
        RequestKeys.voucherType: voucherType.toString(),
        RequestKeys.compId: compId,
        RequestKeys.branchId: branchId,
        RequestKeys.userId: userId,
        RequestKeys.partyId: partyId,
        RequestKeys.fromDate: fromDate,
        RequestKeys.toDate: toDate
      };

      String res = await _apiClient.postMethod(method: _apiMethods.listWithFilter, body: body);
      if (res.isNotEmpty) {
        try {
          return collectionListResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return CollectionListResponse(status: 500, message: e.toString());
        }
      } else {
        return CollectionListResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return CollectionListResponse(status: 500, message: 'No internet');
    }
  }

  Future<CollectionListResponse> receiptList({
    required String compId,
    required String branchId,
    required String userId,
    required String partyId,
    required String fromDate,
    required String toDate,
  }) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      Map<String, String> body = {
        RequestKeys.voucherType: VoucherType.receipt,
        RequestKeys.compId: compId,
        RequestKeys.branchId: branchId,
        RequestKeys.userId: userId,
        RequestKeys.partyId: partyId,
        RequestKeys.fromDate: fromDate,
        RequestKeys.toDate: toDate
      };

      String res = await _apiClient.postMethod(method: _apiMethods.listWithFilter, body: body);
      if (res.isNotEmpty) {
        try {
          return collectionListResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return CollectionListResponse(status: 500, message: e.toString());
        }
      } else {
        return CollectionListResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return CollectionListResponse(status: 500, message: 'No internet');
    }
  }

  Future<CollectionListResponse> paymentList({
    required String compId,
    required String branchId,
    required String userId,
    required String partyId,
    required String fromDate,
    required String toDate,
  }) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      Map<String, String> body = {
        RequestKeys.voucherType: VoucherType.payment,
        RequestKeys.compId: compId,
        RequestKeys.branchId: branchId,
        RequestKeys.userId: userId,
        RequestKeys.partyId: partyId,
        RequestKeys.fromDate: fromDate,
        RequestKeys.toDate: toDate
      };

      String res = await _apiClient.postMethod(method: _apiMethods.listWithFilter, body: body);
      if (res.isNotEmpty) {
        try {
          return collectionListResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return CollectionListResponse(status: 500, message: e.toString());
        }
      } else {
        return CollectionListResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return CollectionListResponse(status: 500, message: 'No internet');
    }
  }

  Future<CollectionListResponse> expenseList({
    required String compId,
    required String branchId,
    required String userId,
    required String partyId,
    required String fromDate,
    required String toDate,
  }) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      Map<String, String> body = {
        RequestKeys.voucherType: VoucherType.expense,
        RequestKeys.compId: compId,
        RequestKeys.branchId: branchId,
        RequestKeys.userId: userId,
        RequestKeys.partyId: partyId,
        RequestKeys.fromDate: fromDate,
        RequestKeys.toDate: toDate
      };

      String res = await _apiClient.postMethod(method: _apiMethods.listWithFilter, body: body);
      if (res.isNotEmpty) {
        try {
          return collectionListResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return CollectionListResponse(status: 500, message: e.toString());
        }
      } else {
        return CollectionListResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return CollectionListResponse(status: 500, message: 'No internet');
    }
  }

  Future<CollectionListResponse> contraList({
    required String compId,
    required String branchId,
    required String userId,
    required String partyId,
    required String fromDate,
    required String toDate,
  }) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      Map<String, String> body = {
        RequestKeys.voucherType: VoucherType.contra,
        RequestKeys.compId: compId,
        RequestKeys.branchId: branchId,
        RequestKeys.userId: userId,
        RequestKeys.partyId: partyId,
        RequestKeys.fromDate: fromDate,
        RequestKeys.toDate: toDate
      };

      String res = await _apiClient.postMethod(method: _apiMethods.listWithFilter, body: body);
      if (res.isNotEmpty) {
        try {
          return collectionListResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return CollectionListResponse(status: 500, message: e.toString());
        }
      } else {
        return CollectionListResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return CollectionListResponse(status: 500, message: 'No internet');
    }
  }

  Future<CollectionListResponse> journalList({
    required String compId,
    required String branchId,
    required String userId,
    required String partyId,
    required String fromDate,
    required String toDate,
  }) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      Map<String, String> body = {
        RequestKeys.voucherType: VoucherType.journal,
        RequestKeys.compId: compId,
        RequestKeys.branchId: branchId,
        RequestKeys.userId: userId,
        RequestKeys.partyId: partyId,
        RequestKeys.fromDate: fromDate,
        RequestKeys.toDate: toDate
      };

      String res = await _apiClient.postMethod(method: _apiMethods.listWithFilter, body: body);
      if (res.isNotEmpty) {
        try {
          return collectionListResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return CollectionListResponse(status: 500, message: e.toString());
        }
      } else {
        return CollectionListResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return CollectionListResponse(status: 500, message: 'No internet');
    }
  }

  Future<VoucherListResponse> vouchersList({
    required String voucherType,
    required String compId,
    required String branchId,
    required String userId,
    required String partyId,
    required String fromDate,
    required String toDate,
  }) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      Map<String, String> body = {
        RequestKeys.voucherType: voucherType,
        RequestKeys.compId: compId,
        RequestKeys.branchId: branchId,
        RequestKeys.userId: userId,
        RequestKeys.partyId: partyId,
        RequestKeys.fromDate: fromDate,
        RequestKeys.toDate: toDate
      };

      String res = await _apiClient.postMethod(method: _apiMethods.listWithFilter, body: body);
      if (res.isNotEmpty) {
        try {
          return voucherListResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return VoucherListResponse(status: 500, message: e.toString());
        }
      } else {
        return VoucherListResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return VoucherListResponse(status: 500, message: 'No internet');
    }
  }

  Future<CollectionCustomerListResponse> expensesHeadList(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.expensesHead, body: body);
      if (res.isNotEmpty) {
        try {
          return collectionCustomerListResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return CollectionCustomerListResponse(status: 500, message: e.toString());
        }
      } else {
        return CollectionCustomerListResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return CollectionCustomerListResponse(status: 500, message: 'No internet');
    }
  }

  Future<CommonResponse> contraEntrySubmit(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.contraEntry, body: body);
      if (res.isNotEmpty) {
        try {
          return commonResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return CommonResponse(status: 500, message: e.toString());
        }
      } else {
        return CommonResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return CommonResponse(status: 500, message: 'No internet');
    }
  }

  Future<CollectionCustomerListResponse> fromAccount(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.fromAccount, body: body);
      if (res.isNotEmpty) {
        try {
          return collectionCustomerListResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return CollectionCustomerListResponse(status: 500, message: e.toString());
        }
      } else {
        return CollectionCustomerListResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return CollectionCustomerListResponse(status: 500, message: 'No internet');
    }
  }

  Future<CommonResponse> journalEntry(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.journalEntry, body: body);
      if (res.isNotEmpty) {
        try {
          return commonResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return CommonResponse(status: 500, message: e.toString());
        }
      } else {
        return CommonResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return CommonResponse(status: 500, message: 'No internet');
    }
  }

  Future<CollectionCustomerListResponse> debitCreditAccountList(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.debitCreditAccount, body: body);
      if (res.isNotEmpty) {
        try {
          return collectionCustomerListResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return CollectionCustomerListResponse(status: 500, message: e.toString());
        }
      } else {
        return CollectionCustomerListResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return CollectionCustomerListResponse(status: 500, message: 'No internet');
    }
  }

  Future<TransactionListResponse> transactionList(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.transactionList, body: body);
      if (res.isNotEmpty) {
        try {
          return transactionListResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return TransactionListResponse(status: 500, message: e.toString());
        }
      } else {
        return TransactionListResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return TransactionListResponse(status: 500, message: 'No internet');
    }
  }

  Future<OutstandingDataResponse> getPartyOutstanding(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.partyOutstanding, body: body);
      if (res.isNotEmpty) {
        try {
          return outstandingDataResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return OutstandingDataResponse(status: 500, message: e.toString());
        }
      } else {
        return OutstandingDataResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return OutstandingDataResponse(status: 500, message: 'No internet');
    }
  }

  Future<PartyLedgerPdfResponse> partyLedgerPDF(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.printPartyLedger, body: body);
      if (res.isNotEmpty) {
        try {
          return partyLedgerPdfResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return PartyLedgerPdfResponse(status: 500, message: e.toString());
        }
      } else {
        return PartyLedgerPdfResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return PartyLedgerPdfResponse(status: 500, message: 'No internet');
    }
  }

  Future<CollectionCustomerListResponse> contraDropdownList(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(method: _apiMethods.showCashAndBankAccount, body: body);
      if (res.isNotEmpty) {
        try {
          return collectionCustomerListResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return CollectionCustomerListResponse(status: 500, message: e.toString());
        }
      } else {
        return CollectionCustomerListResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return CollectionCustomerListResponse(status: 500, message: 'No internet');
    }
  }

  Future<CommonResponse> expenseEntrySubmit(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethodJson(
        method: _apiMethods.voucherEntrySubmit,
        body: json.encode(body),
        header: {'Content-Type': 'application/json'},
      );
      if (res.isNotEmpty) {
        try {
          return commonResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return CommonResponse(status: 500, message: e.toString());
        }
      } else {
        return CommonResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return CommonResponse(status: 500, message: 'No internet');
    }
  }

  Future<CommonResponse> voucherEntrySubmit(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient
          .postMethod(method: _apiMethods.voucherEntrySubmit, body: body, header: {'Content-Type': 'application/json'});
      if (res.isNotEmpty) {
        try {
          return commonResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return CommonResponse(status: 500, message: e.toString());
        }
      } else {
        return CommonResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return CommonResponse(status: 500, message: 'No internet');
    }
  }
}
