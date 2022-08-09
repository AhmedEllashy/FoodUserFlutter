
class ErrorMessages{
  static const String internetError =  " Please check your Internet connection";

}

//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_core_web/firebase_core_web_interop.dart';
// import 'package:food_user/data/Network/failure.dart';
//
// class ErrorHandler implements Exception {
//   late Failure failure;
//   ErrorHandler.handle(dynamic error){
//     if(error is FirebaseException){
//       failure = handleError(error);
//     }else{
//     failure =  DataSource.Default.getFailure();
//
//     }
//   }
// }
// Failure handleError(FirebaseException error){
//   switch(error){
//
//   case ""
//
//   }
// }
// enum DataSource{
//   SUCCESS,
//   NO_CONTENT,
//   BAD_REQUEST,
//   FORBIDDEN,
//   UNAUTHORISED,
//   NOT_FOUND,
//   INTERNAL_SERVER_ERROR,
//   CONNECT_TIMEOUT,
//   CANCEL,
//   RECIEVE_TIMEOUT,
//   SEND_TIMEOUT,
//   CASHE_ERROR,
//   NO_INTERNET_CONNECTION,
//   Default
//
// }
// extension DataSourceExtension on DataSource{
// Failure getFailure(){
//   switch(this){
//
//     case DataSource.SUCCESS:
//       return Failure(ResponseCode.SUCCESS, ResponseMessage.SUCCESS);
//     case DataSource.NO_CONTENT:
//       return Failure(ResponseCode.NO_CONTENT, ResponseMessage.NO_CONTENT);
//
//     case DataSource.BAD_REQUEST:
//       return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);
//
//     case DataSource.FORBIDDEN:
//       return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);
//
//     case DataSource.UNAUTHORISED:
//       return Failure(ResponseCode.UNAUTHORISED, ResponseMessage.UNAUTHORISED);
//
//     case DataSource.NOT_FOUND:
//       return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);
//
//     case DataSource.INTERNAL_SERVER_ERROR:
//       return Failure(ResponseCode.INTERNAL_SERVER_ERROR, ResponseMessage.INTERNAL_SERVER_ERROR);
//
//     case DataSource.CONNECT_TIMEOUT:
//       return Failure(ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT);
//
//     case DataSource.CANCEL:
//       return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL);
//
//     case DataSource.RECIEVE_TIMEOUT:
//       return Failure(ResponseCode.RECIEVE_TIMEOUT, ResponseMessage.RECIEVE_TIMEOUT);
//
//     case DataSource.SEND_TIMEOUT:
//       return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);
//
//     case DataSource.CASHE_ERROR:
//       return Failure(ResponseCode.CASHE_ERROR, ResponseMessage.CASHE_ERROR);
//
//     case DataSource.NO_INTERNET_CONNECTION:
//       return Failure(ResponseCode.NO_INTERNET_CONNECTION, ResponseMessage.NO_INTERNET_CONNECTION);
//
//     case DataSource.Default:
//       return Failure(ResponseCode.Default, ResponseMessage.Default);
//
//   }
// }
// }
// class ResponseCode{
//   static  const int  SUCCESS = 200;
//   static  const int  NO_CONTENT = 201;
//   static  const int  BAD_REQUEST = 400;
//   static  const int  FORBIDDEN = 403;
//   static  const int  UNAUTHORISED = 401;
//   static  const int  INTERNAL_SERVER_ERROR = 500;
//
//   //LOCAL ERRORS
//   static  const int  CANCEL = -1;
//   static  const int  CONNECT_TIMEOUT = -2;
//   static  const int  RECIEVE_TIMEOUT = -3;
//   static  const int  SEND_TIMEOUT = -4;
//   static  const int  CASHE_ERROR = -5;
//   static  const int  NO_INTERNET_CONNECTION = -6;
//   static  const int  NOT_FOUND = -7;
//   static  const int  Default = -8;
// }
// class ResponseMessage{
//   static  const String  SUCCESS = 'success';
//   static  const String  NO_CONTENT = 'success';
//   static  const String  BAD_REQUEST = 'Bad request ,Try again later';
//   static  const String  FORBIDDEN = 'forbidden request ,Try again later';
//   static  const String UNAUTHORISED = 'User is unauthorized,Try again later';
//   static  const String  INTERNAL_SERVER_ERROR = 'Something went wrong,Try again later';
//
// //LOCAL ERRORS
//   static  const String  CANCEL = 'Request was canceled, Try again later';
//   static  const String  CONNECT_TIMEOUT = 'Timed out error,Try again later';
//   static  const String  RECIEVE_TIMEOUT = 'Timed out error,Try again later';
//   static  const String  SEND_TIMEOUT = 'Timed out error,Try again later';
//   static  const String  CASHE_ERROR = 'Cash error , Try again later';
//   static  const String  NO_INTERNET_CONNECTION = 'Please check your inter';
//   static  const String  NOT_FOUND = "Not Found";
//   static  const String  Default = "Something went wrong. Try again later";
// }
// class ApiInternalStatus{
//   static const int SUCCESS = 0;
//   static const int FAILURE = 1;
//
// }