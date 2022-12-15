// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newsapp/layout/cubit/cubit.dart';
import 'package:newsapp/layout/cubit/states.dart';
//import 'package:newsapp/layout/cubit/states.dart';
import 'package:newsapp/layout/news_app/news_layout.dart';
import 'package:newsapp/shared/Bloc_obServer.dart';
import 'package:newsapp/shared/network/local/cache_helper.dart';
import 'package:newsapp/shared/network/remote/dio_helper.dart';

void main() async {
  //في حاله تحول الداله الماين الى  اسنك لابد من كتابه هذه الداله
  //لكي يتم تنفيذ هذه الاكواد اولا قبل ما يشتغل التطبيق
  //بيتاكد ان كل حاجه هنا في الميثود خلصت وبعدين يفتح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();
  //
  Bloc.observer = MyBlocObserver();
  DioHeplper.init(); //الاتصال برابط  الموقع
  await CacheHelper.init();
  //ارجع قيمة الثيم المخزنه
  // في حاله فتح التطبيق اول مره
  var isDark = CacheHelper.getData(key: 'isDark');
  // في حاله فتح التطبيق اول مره من احل حفظ الثيم
  // نرسل قيمه الثيم الخزنه الى التطبيق
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  //ارجع قيمة الثيم المخزنه
  // في حاله فتح التطبيق اول مره من احل حفظ الثيم
  final bool? isDark;
  // في حاله فتح التطبيق اول مره من احل حفظ الثيم
  //ارجع قيمة الثيم المخزنه
  MyApp(this.isDark, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      //استرجاع
      // في حاله فتح التطبيق اول مره من احل حفظ الثيم
      create: (context) => NewsCubit()
        //نبعث القيمة في حاله فتح التطبيق اول مره
        ..changeAppMode(fromShared: isDark)
        ..getBusiness(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            //رح يطبق على كل الطبيق
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              //primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                titleSpacing: 20,
                backwardsCompatibility: false,
                //اعطاء لون لقسم الذي عند البطارية
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                backgroundColor: Colors.white,
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                //لون الى الايقونة
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
              ),
              //لون لافلوت اكشن بتون
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ),
              //الالوان القائمة السفلية
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                //unselectedItemColor: Colors.grey,
                elevation: 20.0,
                backgroundColor: Colors.white,
              ),
              textTheme: TextTheme(
                  bodyText1: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              )),
            ),

            //الثيم المظلم
            darkTheme: ThemeData(
              primarySwatch: Colors.deepOrange,
              //primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: HexColor('333739'),
              appBarTheme: AppBarTheme(
                titleSpacing: 20,
                backwardsCompatibility: false,
                //اعطاء لون لقسم الذي عند البطارية
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('333739'),
                  statusBarIconBrightness: Brightness.light,
                ),
                //الشريط العلوي الاب بار
                backgroundColor: HexColor('333739'),
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                //لون في الابار الايقونة
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
              ),
              //لون لافلوت اكشن بتون
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ),
              //الالوان القائمة السفلية
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                elevation: 20.0,
                backgroundColor: HexColor('333739'),
              ),
              //التعامل مع النصوص
              textTheme: TextTheme(
                  //التعامل مع االنص محدد المساحه
                  bodyText1: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              )),
            ),
            //تغير حاله الثيم
            themeMode: NewsCubit.get(context).isDark
                ? ThemeMode.dark //ترو ارجع لنا الثيم المظلم
                : ThemeMode.light, // اذا كانت فولس ارجع لنا الثيم الابيض
            //اللغة
            home: Directionality(
              textDirection: TextDirection.rtl,
              child: NewsLayout(),
            ),
          );
        },
      ),
    );
  }
}
