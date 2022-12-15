// ignore_for_file: unused_element

import 'package:dio/dio.dart';

//key API NEWS
//f386939f8e3243cba02c112e244ba9f4
//https://newsapi.org/ رابط الاتصال
// url v2/top-headlines?  اربط البيانات
// country=eg&category=business البيانات والاقسام
// الدوله= eg  مصر& category قسم = business(الاقتصاد) البيانات والاقسام
// &apiKey=f386939f8e3243cba02c112e244ba9f4 مفتاح الخاص

///
//في البحث نستخدم الرابط التالي

// https://newsapi.org/
// v2/everything
//?q= teslaجملة البحث
// &from=2022-08-01&sortBy=publishedAt&apiKey=f386939f8e3243cba02c112e244ba9f4

class DioHeplper {
  static late Dio dio;
  //الاتصال بالبيانات الرابط
  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://newsapi.org/',
      receiveDataWhenStatusError: true,
    ));
  }

  //داله جلب البيانات
  static Future<Response> getdata({
    required String url, //الرابط
    required Map<String, dynamic> query,
  }) async {
    return await dio.get(url, queryParameters: query);
  }
}
