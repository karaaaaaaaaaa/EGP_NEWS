import 'package:dio/dio.dart';
// https://gnews.io/api/v4/top-headlines?country=eg&category=sport&apikey=b6c932ce4ff392f5b4bc0df9375766ec
class dioHelper {
  static late Dio dio;
  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://gnews.io/', receiveDataWhenStatusError: true));
  }

  static Future<Response> getdata(
    {required String path, Map<String,dynamic>?query})async {
  return await  dio.get(path,
    queryParameters:query );
  }
}
// https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=c617c5f86f944aa3a7ff6c5f401e6a83

// class DioHelper {
//   static late Dio dio;

//   static init() {
//     // https://newsapi.org/v2/top-headlines?country=us&category=science&apiKey=c617c5f86f944aa3a7ff6c5f401e6a83
//     dio = Dio(BaseOptions(
//       baseUrl: 'https://newsapi.org/',
//       receiveDataWhenStatusError: true,
//     ));
//   }

//   static Future<Response> getDate({
//     required String path,
//     Map<String, dynamic>? query,
//   }) async {
//     return await dio.get(
//       path,
//       queryParameters: query,
//     );
//   }

//   static Future<Response> getData(
//       {required String path,
//       Map<String, dynamic>? query,
//       String lang = 'en',
//       String? token}) async {
//     dio.options.headers = {
//       'Content-Type': 'application/json',
//       'lang': lang,
//       'Authorization': token ?? ''
//     };
//     return await dio.get(
//       path,
//       queryParameters: query ?? null,
//     );
//   }

//   static Future<Response> postData(
//       {required String url,
//       Map<String, dynamic>? query,
//       required Map<String, dynamic> data,
//       String lang = "en",
//       String? token}) async {
//     dio.options.headers = {
//       'Content-Type': 'application/json',
//       'lang': lang,
//       'Authorization': token ?? ''
//     };
//     return dio.post(url, queryParameters: query, data: data);
//   }

//   static Future<Response> putData(
//       {required String url,
//       Map<String, dynamic>? query,
//       required Map<String, dynamic> data,
//       String lang = "en",
//       String? token}) async {
//     dio.options.headers = {
//       'Content-Type': 'application/json',
//       'lang': lang,
//       'Authorization': token ?? ''
//     };
//     return dio.put(url, queryParameters: query, data: data);
//   }
// }
