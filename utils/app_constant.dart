import 'package:flutter/material.dart';

const Color purpleColor = Color(0xFF7B83FF);
const Color whiteBoxColor = Color(0xFFF6F6FF);
const Color unselectedColor = Color(0xFFD0D6DC);
const Color msgTextColor = Color(0xFF5F5F5F);
const Color medGreyColor = Color(0xFFAAADAF);
const Color blackColor = Color(0xFF000000);
const Color lightGreyColor = Color(0xFFEEEEEE);
const Color whiteColor = Color(0xFFFFFFFF);
const Color blueColor = Color(0xFF72B8FE);
const Color grTopColor = Color(0xFF72B8FB);
const Color grBottomColor = Color(0xFF7A8BFA);
const Color red2Color = Color(0xFFF4717F);
const Color greenColor = Color(0xFF006D75);
const Color lightGreenColor = Color(0xFF1CC58D);
const Color darkGreenColor = Color(0xFF0D3A2D);
const Color grey = Colors.grey;
const Color orangeColor = Color(0xFFFDAB59);
const Color lightOrangeColor = Color(0xFFFDB99B);
const Color darkOrangeColor = Color(0xFFDE6627);
const Color dropdownBoxColor = Color(0xFFEBEFFE);
const Color progressAttendanceColor = Color(0xFFECF1FF);
const Color leaveBoxColor = Color(0xFFF2F3FF);
const Color yellowColor = Color(0xFFFFC300);
const Color green2Color = Color(0xFF00DB1C);
const Color redColor = Color(0xFFDB0000);
const Color white2Color = Color(0xFFFAFAFA);
const Color red3Color = Color(0xFFBF0078);
const Color red4Color = Color(0xFFA31CC5);
const Color darkBlueColor = Color(0xFF004A83);
const Color green3Color = Color(0xFF00D10E);
const Color green4Color = Color(0xFF90BB00);
const Color green5Color = Color(0xFF3AB30D);
const Color purple2Color = Color(0xFFA770EF);
const Color chocolateColor = Color(0xFF5D4157);
const Color fadeGreenColor = Color(0xFFA8CABA);
const Color purpleShadowColor = Color(0xFFC2CCFD);
const Color categoryColor = Color(0xFFB40B96);

const LinearGradient gr1 = LinearGradient(
  colors: grad1,
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
const LinearGradient gr1Opp = LinearGradient(colors: grad1, begin: Alignment.bottomCenter, end: Alignment.topCenter);
const List<Color> grad1 = [grTopColor, grBottomColor];
const LinearGradient gr2 = LinearGradient(colors: grad2, begin: Alignment.topCenter, end: Alignment.bottomCenter);
const LinearGradient gr2Opp = LinearGradient(colors: grad2, begin: Alignment.bottomCenter, end: Alignment.topCenter);
const List<Color> grad2 = [orangeColor, red2Color];
const List<Color> onlyGrey = [grey, grey];
const LinearGradient gr10 = LinearGradient(colors: onlyGrey, begin: Alignment.bottomCenter, end: Alignment.topCenter);

LinearGradient blueDropdownGr = LinearGradient(
    // colors: [purpleColor.withOpacity(0.09), blueColor.withOpacity(0.09)],
    colors: [grBottomColor.withOpacity(0.2), grTopColor.withOpacity(0.2)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter);

LinearGradient orangeDropdownGr(double opacity) => LinearGradient(
    colors: [orangeColor.withOpacity(0.19), red2Color.withOpacity(0.19)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter);

LinearGradient customGradient(
        {required Color topColor, required Color bottomColor, double? opacity, bool isHorizontal = false}) =>
    LinearGradient(
        colors: [topColor.withOpacity(opacity ?? 1), bottomColor.withOpacity(opacity ?? 1)],
        begin: isHorizontal ? Alignment.centerLeft : Alignment.topCenter,
        end: isHorizontal ? Alignment.centerRight : Alignment.bottomCenter);

const String dummyTextShort = 'Lorem Ipsum is simply dummy text of the printing';
const String dummyTextMed =
    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry s standard dummy text.';
const String dummyTextLong =
    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled';

const String dummyImageUrlTxt = 'https://statinfer.com/wp-content/uploads/dummy-user.png';
const String dummyImage2UrlTxt = 'https://source.unsplash.com/user/c_v_r/1600×900';
const String dummyImage3UrlTxt = 'https://picsum.photos/300/150';
const String dummyImage4UrlTxt = 'assets/icons/poins_icon.png';

const int orderFilter = 0;
const int visitPlanFilter = 1;
const int newVisitPlanFilter = 2;
const int previewFilter = 3;
const int orderDetailEdit = 4;
const int attendanceListFilter = 5;
const int productListFilter = 6;
const int leaveHistoryFilter = 7;
const int managerLeaveHistoryFilter = 8;
const int executiveAttendanceFilter = 9;

class VoucherType {
  static const String receipt = '1';
  static const String payment = '2';
  static const String contra = '3';
  static const String journal = '5';
  static const String expense = '14';
  static const String collection = '15';
}

class AppConst {
  static DateTime calenderFirstDate = DateTime(2000, 1, 1);
  static DateTime calenderLastDate = DateTime(2050, 12, 31);
  static String appCastUrl = 'https://raw.githubusercontent.com/Reyparmar/appxml/main/digitalerpappcast.xml';
}

class AppString {
  static const String edit = 'Edit';
  static const String filter = 'Filter';
  static const String date = 'Date';
  static const String month = 'Month';
  static const String selectExecutiveName = 'Select Executive Name';
  static const String selectState = 'Select State';
  static const String selectCity = 'Select City';
  static const String selectArea = 'Select Area';
  static const String selectCustomer = 'Select Customer';
  static const String selectCollectionLedger = 'Select Collection Ledger';
  static const String filterByDate = 'Filter by Date';
  static const String filterByMonth = 'Filter by Month';
  static const String selectMonth = 'Select Month';
  static const String enterAmount = 'Enter Amount';
  static const String amount = 'Amount';
  static const String paymentMode = 'Payment Mode';
  static const String type = 'Type...';
  static const String remark = 'Remark';
  static const String chooseOption = 'Choose Option';
  static const String selectImageFromGallery = 'Select Image From Gallery';
  static const String takePicture = 'Take Picture';
  static const String pleaseSelectDate = 'Please Select Date';
  static const String enterCompanyNameTxt = 'Enter Customer Name';
  static const String enterGstNoTxt = 'Enter GST. No.';
  static const String enterMobileTxt = 'Enter Mobile No.';
  static const String enterContactPersonTxt = 'Enter Contact Person';
  static const String enterEmailIdTxt = 'Enter Email ID';
  static const String enterPanNoTxt = 'Enter Pan No.';
  static const String enterAddressTxt = 'Enter Address';
  static const String enterCountryTxt = 'Enter Country';
  static const String enterStateTxt = 'Enter State';
  static const String enterPincodeTxt = 'Enter Pincode';
  static const String enterCityTxt = 'Enter City';
  static const String customerCompanyNameTxt = 'Customer/Company Name';
  static const String mobileTxt = 'Mobile Number';
  static const String gstNoTxt = 'GST. No.';
  static const String contactPersonTxt = 'Contact Person';
  static const String emailIdTxt = 'Email ID';
  static const String panNoTxt = 'Pan No.';
  static const String addressTxt = 'Address';
  static const String countryTxt = 'Country';
  static const String stateTxt = 'State';
  static const String cityTxt = 'City';
  static const String pincodeTxt = 'Pincode';
  static const String mapAddress = 'Map Address';
  static const String latLng = 'LatLng';
  static const String addCustomer = 'Add Customer';
  static const String uploadDocument = 'Upload Document';
  static const String uploadPicture = 'Upload Picture';
  static const String changeImage = 'Change Image';

  static const String pleaseEnterMobileTxt = 'Please Enter Mobile Number';
  static const String pleaseEnterValidMobileTxt = 'Please Enter Valid Mobile Number';
  static const String pleaseEnterCompanyNameTxt = 'Please Enter Company Name';
  static const String pleaseEnterGstNoTxt = 'Please Enter GST. No.';
  static const String pleaseEnterContactPersonTxt = 'Please Enter Contact Person';
  static const String pleaseEnterEmailIdTxt = 'Please Enter Email ID';
  static const String pleaseEnterValidEmailIdTxt = 'Please Enter Valid Email ID';
  static const String pleaseEnterPanNoTxt = 'Please Enter Pan No.';
  static const String pleaseEnterAddressTxt = 'Please Enter Address';
  static const String pleaseEnterCountryTxt = 'Please Enter Country';
  static const String pleaseEnterStateTxt = 'Please Enter State';
  static const String pleaseSelectCompanyTxt = 'Please select company';
  static const String pleaseEnterPincodeTxt = 'Please Enter Pincode';
  static const String pleaseEnterValidPincodeTxt = 'Please Enter Valid Pincode';
  static const String pleaseEnterTitleTxt = 'Please Enter title';
  static const String pleaseEnterDesTxt = 'Please Enter description';
  static const String pleaseUploadDocumentTxt = 'Please upload document';

  static const String sameForShippingAddressTxt = 'Same for Shipping Address';
  static const String shippingAddressTxt = 'Shipping Address';
  static const String pleaseEnterNameTxt = 'Please Enter name';
  static const String pleaseEnterEmailTxt = 'Please Enter email';
  static const String pleaseEnterValidEmailTxt = 'Please Enter Valid email';
  static const String pleaseEnterValidAddressTxt = 'Please Enter Valid Address';
  static const String pleaseEnterAddress = 'Please Enter address';
  static const String pleaseEnterCity = 'Please Enter City';
  static const String pleaseEnterPasswordTxt = 'Please Enter Password';
  static const String passAnConPassNotMatchTxt = 'Password and confirm password does not match';
  static const String pleaseEnterConfirmPasswordTxt = 'Please Enter Confirm Password';
  static const String passwordDoesNotMatchTxt = 'Password does not match';
  static const String enter6DigitOtpTxt = 'Please Enter 6-digit Otp';
  static const String noInternetConnectionTxt = 'No Internet Connection';
  static const String pleaseCheckTxt = 'Please Check';
  static const String requiredFieldTxt = 'Required Field';
  static const String somethingTxt = 'Something went wrong';
  static const String dateGreaterThanFromTxt = 'Please select to-Date must be greater than from-Date';
  static const String dateGreaterThanTodayTxt = 'Please select to-Date must be not greater than today';
  static const String dateGreaterThanYear = 'Please select to-Date must be less than current year';
  static const String selectFromDateTxt = 'Please select from-Date';
  static const String selectToDateTxt = 'Please select to-Date';
  static const String selectMonthTxt = 'Please select month';
  static const String checkPermissionTxt = 'Please check Permission';
  static const String locationPermissionDeniedTxt = 'Location permission denied';
  static const String locationPermissionGrantedTxt = 'Location permission granted';
  static const String selectGroupTxt = 'Please select group';
  static const String selectStatusTxt = 'Please select any status from Dropdown';
  static const String messageTxt = 'Message';
  static const String productAddedTxt = 'Product Added in Cart';
  static const String alreadyInCartTxt = 'Product already in Cart';
  static const String productQtyUpdateTxt = 'Product Qty Updated';
  static const String companyPendingTxt = 'Selected company is pending for approval';

  static const String ddMMyyyy = 'dd-MM-yyyy';
  static const String yyyyMMdd = 'yyyy-MM-dd';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm:sss';
  static const String dateTimeEmpty = '--/--/----';

  static const String printDSR = 'Print DSR';
  static const String goToMap = 'Go to Map';
  static const String documentType = 'Document Type';
  static const String description = 'Description';
  static const String title = 'Title';
  static const String executiveName = 'Executive Name';
  static const String selectExecutive = 'Select Executive';
  static const String absent = 'Absent';
  static const String liveLocation = 'Live Location';
  static const String location = 'Location';
  static const String customerName = 'Customer name';
  static const String updating = 'Updating...';
  static const String executive = 'Executive';
  static const String outstanding = 'Outstanding';
  static const String order = 'Order';
  static const String payment = 'Payment';
  static const String visit = 'Visit';
  static const String voucherNo = 'Voucher No';
  static const String pleaseSelectAnyParty = 'Please Select Any Party';
  static const String submit = 'Submit';
  static const String noCustomerFound = 'No Customer Found';
}
