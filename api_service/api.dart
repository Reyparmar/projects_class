
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:indoshyam/repository/api_service/api_client.dart';
import 'package:indoshyam/repository/api_service/api_methods.dart';
import 'package:indoshyam/repository/model/add_item_response.dart';
import 'package:indoshyam/repository/model/customer_job_entry_response.dart';
import 'package:indoshyam/repository/model/customer_reg_response.dart';
import 'package:indoshyam/repository/model/forgot_password_response.dart';
import 'package:indoshyam/repository/model/order_list_response.dart';
import 'package:indoshyam/repository/model/party_list_response.dart';
import 'package:indoshyam/repository/model/product_list_response.dart';
import 'package:indoshyam/repository/model/product_serial_num_response.dart';
import 'package:indoshyam/repository/model/user_login_response.dart';
import 'package:indoshyam/repository/model/variety_list_response.dart';
import 'package:indoshyam/repository/model/warranty_reg_response.dart';

import '../model/order_detail_response.dart';
import '../model/order_now_response.dart';

class Api {
  final ApiMethods _apiMethods = ApiMethods();
  final ApiClient _apiClient = ApiClient();

  static final Api api = Api._internal();
  final Connectivity connectivity = Connectivity();

  factory Api() {
    return api;
  }

  Api._internal();

  Future<Map<String, String>> getHeader() async {
    Map<String, String> header = {};
    try {
      // var data = await SharedPre.getObj(SharedPre.userData);
      // OtpVerifyResponse userData = OtpVerifyResponse.fromJson(data);
      // header[RequestKeys.tokenHeader] = userData.data?.token?.data.toString() ?? '';
      // header[RequestKeys.idHeader] = userData.data?.user?.id.toString() ?? '';
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return header;
  }

  Future<UserLoginResponse> loginAPI(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(
          method: _apiMethods.userLogin, body: body);
      if (res.isNotEmpty) {
        try {
          return userLoginResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return UserLoginResponse(status: 500, message: e.toString());
        }
      } else {
        return UserLoginResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return UserLoginResponse(status: 500, message: 'No internet');

    }
  }

  Future<ForgotPasswordApiResponse> forgotPasswordAPI(
      Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(
          method: _apiMethods.forgotPassword, body: body);
      if (res.isNotEmpty) {
        try {
          return forgotPasswordApiResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return ForgotPasswordApiResponse(status: 500, message: e.toString());
        }
      } else {
        return ForgotPasswordApiResponse(
            status: 500, message: 'Something went wrong');
      }
    } else {
      return ForgotPasswordApiResponse(status: 500, message: 'No internet');
        }
  }

  Future<ProductListApiResponse> productListAPI(
      Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
          await _apiClient.postMethod(method: _apiMethods.itemList, body: body);
      if (res.isNotEmpty) {
        try {
          return productListApiResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return ProductListApiResponse(status: 500, message: e.toString());
        }
      } else {
        return ProductListApiResponse(
            status: 500, message: 'Something went wrong');
      }
    } else {
      return ProductListApiResponse(status: 500, message: 'No internet');

    }
  }

  Future<VarietyListApiResponse> varietyListAPI(
      Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(
          method: _apiMethods.varietyList, body: body);
      if (res.isNotEmpty) {
        try {
          return varietyListApiResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return VarietyListApiResponse(status: 500, message: e.toString());
        }
      } else {
        return VarietyListApiResponse(
            status: 500, message: 'Something went wrong');
      }
    } else {
      return VarietyListApiResponse(status: 500, message: 'No internet');

    }
  }

  Future<PartyListApiResponse> partyListAPI(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(
          method: _apiMethods.partyList, body: body);
      if (res.isNotEmpty) {
        try {
          return partyListApiResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return PartyListApiResponse(status: 500, message: e.toString());
        }
      } else {
        return PartyListApiResponse(
            status: 500, message: 'Something went wrong');
      }
    } else {
      return PartyListApiResponse(status: 500, message: 'No internet');

    }
  }

  Future<CustomerRegResponse> customerRegistrationAPI(
      Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(
          method: _apiMethods.customerReg, body: body);
      if (res.isNotEmpty) {
        try {
          return customerRegResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return CustomerRegResponse(status: 500, message: e.toString());
        }
      } else {
        return CustomerRegResponse(
            status: 500, message: 'Something went wrong');
      }
    } else {
      return CustomerRegResponse(status: 500, message: 'No internet');

    }
  }

  Future<AddItemResponse> addProductAPI(
      Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(
          method: _apiMethods.addItem,
          body: body,);
      if (res.isNotEmpty) {
        try {
          return addItemResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return AddItemResponse(status: 500, message: e.toString());
        }
      } else {
        return AddItemResponse(status: 500, message: 'Something went wrong');
      }
    } else {
      return AddItemResponse(status: 500, message: 'No internet');

    }
  }

  Future<ProductSerialNumResponse> checkSerialNumberAPI(
      Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(
          method: _apiMethods.productSerialNoDetail, body: body);
      if (res.isNotEmpty) {
        try {
          return productSerialNumResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return ProductSerialNumResponse(status: 500, message: e.toString());
        }
      } else {
        return ProductSerialNumResponse(
            status: 500, message: 'Something went wrong');
      }
    } else {
      return ProductSerialNumResponse(status: 500, message: 'No internet');

    }
  }

  Future<WarrantyRegResponse> warrantyRegAPI(
      Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(
          method: _apiMethods.warrantyRegistration, body: body);
      if (res.isNotEmpty) {
        try {
          return warrantyRegResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return WarrantyRegResponse(status: 500, message: e.toString());
        }
      } else {
        return WarrantyRegResponse(
            status: 500, message: 'Something went wrong');
      }
    } else {
      return WarrantyRegResponse(status: 500, message: 'No internet');

    }
  }

  Future<OrderNowResponse> placeOrderApi(
      Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(
          method: _apiMethods.placeOrder, body: body);
      if (res.isNotEmpty) {
        try {
          return orderNowResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return OrderNowResponse(status: 500, message: e.toString());
        }
      } else {
        return OrderNowResponse(
            status: 500, message: 'Something went wrong');
      }
    } else {
      return OrderNowResponse(status: 500, message: 'No internet');

    }
  }

  Future<CustomerJobEntryResponse> customerJobEntryApi(
      Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(
          method: _apiMethods.customerJobEntry, body: body);
      if (res.isNotEmpty) {
        try {
          return customerJobEntryResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return CustomerJobEntryResponse(status: 500, message: e.toString());
        }
      } else {
        return CustomerJobEntryResponse(
            status: 500, message: 'Something went wrong');
      }
    } else {
      return CustomerJobEntryResponse(status: 500, message: 'No internet');

    }
  }

  Future<OrderListResponse> orderListApi(
      Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(
          method: _apiMethods.orderListExecutive, body: body);
      if (res.isNotEmpty) {
        try {
          return orderListResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return OrderListResponse(status: 500, message: e.toString());
        }
      } else {
        return OrderListResponse(
            status: 500, message: 'Something went wrong');
      }
    } else {
      return OrderListResponse(status: 500, message: 'No internet');

    }
  }

  Future<OrderDetailResponse> orderDetailApi(
      Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res = await _apiClient.postMethod(
          method: _apiMethods.orderWithProduct, body: body);
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
        return OrderDetailResponse(
            status: 500, message: 'Something went wrong');
      }
    } else {
      return OrderDetailResponse(status: 500, message: 'No internet');

    }
  }
}
