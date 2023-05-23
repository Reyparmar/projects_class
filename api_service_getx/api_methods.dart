class ApiMethods {
  static final ApiMethods _apiMethods = ApiMethods._internal();

  factory ApiMethods() {
    return _apiMethods;
  }

  ApiMethods._internal();

  String login = 'Login/userLogin';
  String updateProfile = 'UserProfile/userProfile';
  String executiveDropDown = 'ExecutiveReportPerson/ExecutiveReportPersonList';
  String mobileOtpVerify = 'MobileVerify/mobileOtpVerify';
  String updateToken = 'updatetoken/usercurrenttoken';
  String menuDetails = 'Menu/menuDetails';
  //String dashboardDetails = 'Dashboard/dashboardDetails';
  String dashboardDetails = 'dashboardnew/dashboardDetailsnew';
  String attendanceSummary = 'AttendanceSummery/attendanceDetails';
  String attendanceList = 'AttendanceList/attendanceList';
  String markAttendance = 'MarkAttendance/markAttendance';
  String logout = 'Logout/userLogout';
  String applyLeave = 'Applyleave/leavapply';
  String getLeaveData = 'appandreject/listofleav'; // Approved and Rejected manage by status in param
  String leaveHistory = 'leavehistory/getleavhistory';
  String pendingLeaveList = 'pendingleavelist/leavlistforapprovedandreject';
  String updateLeaveStatus = 'approveleavprocess/listofleav'; // Approved and Rejected manage by status in param
  String executiveListWithLatAndLong = 'Executivelistwithlatlong/executivelistforlatlong';
  String executiveOrderList = 'Executiveorderlist/orderlistexecutive';
  String partyDropdownNew = 'agentparty/getagentpartyname';
  String validateUserForOrder = 'validateuserfororder/validateuser';
  String matchUserLocation = 'checkuserlocation/validateuserlocation';
  String singleOrderDetail = 'orderdetail/orderwithproduct';
  String getOrderPdf = 'orderpdf/getorderpdf';

  String updateOrderStatus = 'changeorderstatus/updateorderstatus';
  String partyBalanceDetail = 'Partybalancedetail/partybalance';
  String locationRouteSave = 'locationroute/locationsave';
  String executiveDayLocation = 'executivedaylocation/daylocation';
  String forgotPassword = 'forgotpassword/forgototpget';
  String forgotOtpVerify = 'forgotpassotpverify/forgototpverify';
  String resetPassword = 'resetpasswod/resetpass';
  String brandDataList = 'brandlistnew/brandwithimage';
  String categoryBannerImage = 'categorybanner/categorybannerlist';
  String subcategoryList = 'subcategory/subcategorylist';

  String categoryBrandDataList = 'categorybrand/categorylistbrand';

  String productDetails = 'productdetail/getproductdetail';
  String unitDetails = 'unitlist/getunit';
  String itemListVariant = 'itemvarient/itemlistvarient';
  String addPartyOrCompany = 'Addparty/addpartydetail';
  String addPartyOrCompanyNew = 'Addpartynew/addpartydetailnew';
  String getCartDetail = 'cartdetail/getcarddetail';
  //String addToCart  = 'addtocart/addcart';
  String addToCart = 'addtocartnew/addcartnew';

  String removeFromCart = 'removeitem/removecartitem';
  String removeItem = 'removeitem/removecartitem';
  String placeOrder = 'placeorder/orderentry';
  String updateCart = 'cardqtyupdate/productqtychange';
  String updateCartDecimalQty = 'cardqtyupdatedecimal/productqtychangedecimal';
  String cartCount = 'cartcount/getcartcount';

  ///Visit Plan
  /// -VisitPlan Screen
  String allVisitList = 'allvisitlist/visitlist';

  /// -Visitplan Detail Screen
  String visitPlanDetail = 'Visitplandetail/visitlist';
  String visitCheckIn = 'Visitcheckin/Visitcheckindetail';
  String visitPlanCheckout = 'visitplancheckout/Visitcheckoutdetail';

  /// -Visitplan Filter Screen
  String executiveListData = 'ExecutiveReportPerson/ExecutiveReportPersonList';
  String stateNameList = 'Statename/statenamelist';
  String areaNameList = 'Arealist/Areaname';
  String cityNameList = 'Cityname/citylist';

  /// -Stack Tacking Screen
  String stockCategory = 'category/categorylist';
  String productListItem = 'item/itemlist';
  String stockTaking = 'Stocktaking/stocktakingin';

  /// -New Visit Planing Screen
  String partyDropdown = 'allpartylist/partydrpdon'; //till not used
  String searchAreaWiseClientForVisit = 'searchareawiseclientforvisit/searchclientforviste';
  String addToVisit = 'Addvisitlist/addtovisit';

  /// -New Visit Planing Filter Screen
  String nearByList = 'Nearbydistance/Nearbylist';

  /// -Preview Screen
  String previewVisitList = 'Addtovistlist/addtovisitlist';
  String deleteVisitList = 'deletevisitfromlist/deletevisitlist';
  String saveVisitEntry = 'Savevisitentry/savevisit';

  /// -Customer List Screen/party list
  String customersList = 'partydetail/Fullpartydetail';
  String updateCustomerLocation = 'updatepartylocation/updatelocation';
  String updateCustomerRemark = 'updatepartyremarks/clientremark';
  String getDsrPdf = 'executivedsr/getdsrpdf';

  String paymentEntrySubmit = 'Voucherentry/uservoucherentry';
  String collectionEntrySubmit = 'Voucherentry/uservoucherentry';
  String showCashAndBankAccount = 'Cashandbankaccount/showCashandbankaccount';

  ///new
  ///Collection
  String listWithFilter = 'Accountentrylist/showaccountentrydetail';
  String collectionEntry = 'Voucherentry/uservoucherentry';
  String customerList = 'AccountCustomer/showAccountCustomer';

  ///Expenses
  String expensesHead = 'Expenseslist/showExpenseshead';
  String contraEntry = 'ContraEntry/userContraentry';
  String fromAccount = 'Cashandbankaccount/showCashandbankaccount';
  String journalEntry = 'journalentry/userjournalentry';
  String debitCreditAccount = 'debitandcreditledger/showdebitandcreditledger';

  String transactionList = 'Partylistoftransaction/showlistoftransactionofparty';
  String partyOutstanding = 'Partyoutstadinglist/showpartyoutstanding';
  String printPartyLedger = 'printledger/printledgerreport';

  String voucherEntrySubmit = 'Voucherentry/uservoucherentry';
}
