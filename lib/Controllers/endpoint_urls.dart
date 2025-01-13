import 'package:flutter_dotenv/flutter_dotenv.dart';

class kUrl {
  static String _baseUrl = dotenv.env['BASE_URL'] ?? 'FALL_BACK_TEXT';
  static String monnyKey = dotenv.env['MONY_API'] ?? 'FALL_BACK_TEXT';
  static String secret = dotenv.env['SECRET'] ?? 'FALL_BACK_TEXT';

  static String sendOtp = '$_baseUrl/auth/get-started';
  static String fetchAccNumbers = '$_baseUrl/user/get-account-details';

  static String registerUser = '$_baseUrl/auth/register';
  static String fetchBalances = '$_baseUrl/user/user-info';
  static String fetchBankList = '$_baseUrl/general/banks';
  static String fetchWalletTrxns = '$_baseUrl/transactions/wallet-transaction';

  static String validateAccName = '$_baseUrl/withdrawal/check-bank/details';

  static String verifyOtp = '$_baseUrl/auth/check-otp';
  static String fetchIncomingOrder = '$_baseUrl/orders/incoming-orders';

  static String loginUser = '$_baseUrl/auth/login';
  static String getUser = '$_baseUrl/user';
  static String verifyNin = 'https://api.monnify.com/api/v1/vas/nin-details';
  static String monnifyBase = 'https://api.monnify.com';

  static String resetPwd = '$_baseUrl/auth/reset-password';
  static String acceptOrder = '$_baseUrl/orders/cancel';
  static String fetchTrxns = '$_baseUrl/orders/fetch-all';

  static String rejectOrder = '$_baseUrl/orders/accept';
}
