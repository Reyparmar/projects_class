class ApiMethods {
  static final ApiMethods _apiMethods = ApiMethods._internal();

  factory ApiMethods() {
    return _apiMethods;
  }

  ApiMethods._internal();

  static const String domain = 'https://api-test.checkmate.zone/';
  static const String version = 'v1/';
  static const String host = domain + version;





  ///[Methods Apis]
  //String login = '${host}auth/sms-otp';
  String userLogin = 'Login/userLogin';
  String forgotPassword = 'forgotpassword/forgototpget';
  String itemList = 'item/itemlist';
  String varietyList = 'varity/varitylist';
  String partyList = 'allpartylist/partydrpdon';
  String customerReg = 'Addpartynew/addpartydetailnew';
  String addItem = 'addorderitem/additem';
  String productSerialNoDetail = 'productserialnodetail/productserialbilldetail';
  String warrantyRegistration = 'warrantyregistration/warrantyentry';
  String placeOrder = 'placeorder/orderentry';
  String customerJobEntry = 'customerjobentry/jobentry';
  String orderListExecutive = 'Executiveorderlist/orderlistexecutive';
  String orderWithProduct = 'orderdetail/orderwithproduct';
}
