// ignore_for_file: camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/cubit/cubit.dart';
import 'package:newsapp/layout/cubit/states.dart';
import 'package:newsapp/shared/components/components.dart';

class Search_Screen extends StatelessWidget {
  Search_Screen({Key? key}) : super(key: key);
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).Search;

        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultTextFormFiled(
                  controller: searchController,
                  type: TextInputType.text,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'الرجاء ادخل النص الذي تريد البحث عنه';
                    }
                    return null;
                  },
                  labelText: "البحث",
                  prefixIcon: Icons.search,
                  onChange: (p0) {
                    //كل كلمه تكتب نعمل لها بحث
                    NewsCubit.get(context).getSearch(p0);
                  },
                ),
              ),
              Expanded(child: articleBuilder(list, context, isSearch: true))
            ],
          ),
        );
      },
    );
  }
}
