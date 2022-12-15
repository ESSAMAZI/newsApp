// ignore_for_file: prefer_const_constructors, avoid_print, non_constant_identifier_names, unrelated_type_equality_checks, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/cubit/states.dart';
// import 'package:newsapp/modules/Srttings/Srttings_screen.dart';
import 'package:newsapp/modules/business/business_screen.dart';
import 'package:newsapp/modules/science/science_screen.dart';
import 'package:newsapp/modules/sports/sports_screen.dart';
import 'package:newsapp/shared/network/local/cache_helper.dart';
import 'package:newsapp/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialsState());
  static NewsCubit get(context) => BlocProvider.of(context);

//بناء القوائم السفليه
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomitems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'الاقتصاد',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'الرياضة',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'العلوم',
    ),
    // BottomNavigationBarItem(
    //   icon: Icon(Icons.settings),
    //   label: 'الضبط',
    // ),
  ];
  // الانتهاء من القوائم السفليه
  //الشاشات التي رح تعرض عند التنقل بين الازار
  List<Widget> screen = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    // SettingsScreen()
  ];

//التنقل بين القوائم السفلية
  void changeBottomNavBar(int index) {
    //عند الضغط على اي ازر يظهر الاخبار الخاصه بها
    currentIndex = index;
    if (index == 0) getBusiness();
    if (index == 1) getSports();
    if (index == 2) getScience();

    emit(NewsBottomNavState());
  }

  ///جلب بيانات الاخبار الماليه
  List<dynamic> business = [];
  void getBusiness() {
    //عمل شاشة انتظار لشاشة

    emit(NewsGetBusinessLoadingState());

    //داله جلب البيانات
    DioHeplper.getdata(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': 'f386939f8e3243cba02c112e244ba9f4',
    }).then((value) {
      //print(value.data['totalResults']);

      // Map<String, String> articles = {
      //   "source": {"id": "google-news", "name": "Google News"},
      // };

      // List <dynamic>s=

      business = value.data['articles'];
      // print(business[0]['title']);
      emit(NewsGetBusinessSuccessstate());
    }).catchError((onError) {
      print(onError.toString());
      emit(NewsGetBusinessErrorstate(onError.toString()));
    });
  }

  //الاخبارالرياضية
  List<dynamic> sports = [];
  void getSports() {
    //عمل شاشة انتظار لشاشة
    emit(NewsGetSPortsLoadingState());
    //print('object');
    //داله جلب البيانات
    if (sports.length == 0) {
      DioHeplper.getdata(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': 'f386939f8e3243cba02c112e244ba9f4',
      }).then((value) {
        //print(value.data['totalResults']);
        sports = value.data['articles'];
        // print(sports[0]['title']);
        emit(NewsGetSPortsSuccessstate());
      }).catchError((onError) {
        print(onError.toString());
        emit(NewsGetSPortsErrorstate(onError.toString()));
      });
    } else {
      emit(NewsGetSPortsSuccessstate());
    }
  }

//الاخبار العلمية
  List<dynamic> Science = [];
  void getScience() {
    //عمل شاشة انتظار لشاشة
    if (Science.length == 0) {
      emit(NewsGetScienceLoadingState());
      //print('object');
      //داله جلب البيانات
      DioHeplper.getdata(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': 'f386939f8e3243cba02c112e244ba9f4',
      }).then((value) {
        //print(value.data['totalResults']);
        Science = value.data['articles'];
        // print(Science[0]['title']);
        emit(NewsGetScienceSuccessstate());
      }).catchError((onError) {
        print(onError.toString());
        emit(NewsGetScienceErrorstate(onError.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessstate());
    }
  }

  //التحكم في الثيم
  bool isDark = false;
  //fromShared
  //القيمة التي رح تاتي لنا من الشيرد هي ترو
  void changeAppMode({bool? fromShared}) {
    //ThemeMode appMode = ThemeMode.dark;
    //ارجع قيمة الثيم المخزنه
    // في حاله فتح التطبيق اول مره من احل حفظ الثيم
    if (fromShared != null) {
      isDark = fromShared;
      emit(NewsAppChangeModeState());
    } else {
      // ارسال القيمة الثيم
      //عند الضغط رح تكون قيمتها 1
      isDark = !isDark; //اذا حدث تغير او ضفط رح ترجه ترو
      //حفظ الثيم
      CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(NewsAppChangeModeState());
      });
    }
  }

//البحث
  List<dynamic> Search = [];

  //عمل شاشة انتظار لشاشة
  void getSearch(String Value) {
    emit(NewsGetSearchLoadingState());
    Search = []; //تصفير الشاشه
    DioHeplper.getdata(url: 'v2/everything', query: {
      'q': Value,
      'apiKey': 'f386939f8e3243cba02c112e244ba9f4',
    }).then((value) {
      Search = value.data['articles'];
      emit(NewsGetSearchSuccessstate());
    }).catchError((onError) {
      print(onError.toString());
      emit(NewsGetSearchErrorstate(onError));
    });
  }
}
