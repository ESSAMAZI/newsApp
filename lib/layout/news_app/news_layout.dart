// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/cubit/cubit.dart';
import 'package:newsapp/layout/cubit/states.dart';
import 'package:newsapp/modules/search/search_screen.dart';
import 'package:newsapp/shared/components/components.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        //عرض وربط الاخبار
        //استدعاء رابط الاخبار عند فتح البرنامج

        var cubit = NewsCubit.get(context);
        // ignore: unnecessary_null_comparison

        //   var cubit = NewsCubit.get(context)
        // ..getBusiness()
        // ..getScience()
        // ..getSports();
        return Scaffold(
          appBar: AppBar(
            title: Text('الاخبار'),
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context, Search_Screen());
                  },
                  icon: Icon(Icons.search)),
              IconButton(
                  onPressed: () {
                    NewsCubit.get(context).changeAppMode();
                  },
                  icon: Icon(Icons.brightness_4_outlined))
            ],
          ),
          /*  floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    print('object');

                    ///
                    DioHeplper.getData(url: 'v2/top-headlines', query: {
                      'country': 'us',
                      'category': 'business',
                      'apiKey': 'f386939f8e3243cba02c112e244ba9f4',
                    }).then((value) {
                      print(value.data['totalResults']);
                    }).catchError((onError) {
                      print(onError.toString());
                    });
                  },
                  child: Icon(Icons.add)),*/
          //الشاشات التي رح تعرض عند التنقل بين الازار
          body: cubit.screen[cubit.currentIndex],
          //ازرار التنقل
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
            items: cubit.bottomitems,
          ),
        );
      },
    );
  }
}
