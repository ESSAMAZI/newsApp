// ignore_for_file: sized_box_for_whitespace, non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';
import 'package:newsapp/modules/web_view/web_view_screen.dart';

Widget DefaulteTextButton(
        {required VoidCallback onPressed, required String text}) =>
    TextButton(
      onPressed: onPressed,
      child: Text(text),
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 0.0,
  double height = 40,
  required VoidCallback onPressed,
  required String text,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
// تصميم الواجهه التي تعرض لنا الاخبار
Widget buildArticleItem(article, context) => InkWell(
      //InkWell
      // عند الضفط  على اي عنوان او خبر
      onTap: () {
        //عند الضغط على على خبر رح يفتح الرابط الموقع
        navigateTo(context, WebViewScreen(url: article['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              //عرض الصور
              width: 120.0,
              height: 120.0,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Container(
                height: 120.0,
                child: Column(
                  // mainAxisSize: MainAxisSize.min,

                  crossAxisAlignment: CrossAxisAlignment.start,

                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',

                        //يستقبل تشكيل النص حسب البيانات الموجوده في الثيم

                        style: Theme.of(context).textTheme.bodyText1,

                        maxLines: 3,

                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: const TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

//عمل خط في فاصل بين الاخبار
Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

//البيانات

Widget articleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
      // عمل ايقونه انتظار التحميل
      condition: list.isNotEmpty,
      //تحميل البيانات وعرض التصميم
      builder: (context) => ListView.separated(
          //اخفاء الظل الذي فوق
          physics: const BouncingScrollPhysics(),

          /// استدعاء التصميم
          itemBuilder: (context, index) =>
              buildArticleItem(list[index], context),
          //تصميم الخط الفاصل في البيانات
          separatorBuilder: (context, index) => myDivider(),
          itemCount: 10),
      // في عدم الحصول على البيانات تنعرض دائره الانتظار
      fallback: (context) => isSearch
          ? Container()
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );

//حقل البحث
Widget defaultTextFormFiled(
        {required TextEditingController controller,
        required TextInputType type,
        //required Function onSubmit, //Add question mark
        void Function(String)? onSubmit,
        void Function(String)? onChange,
        void Function()? onTap,
        // required Function onChange, //Add question mark
        required Function validate,
        required String labelText,
        bool isPassword = false,
        required IconData prefixIcon,
        IconData? suffixIcon,
        void Function()? suffixPressed}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      onTap: onTap,
      validator: (value) {
        return validate(value);
      },
      obscureText: isPassword,
      decoration: InputDecoration(
        //hintText: 'Email Address',
        labelText: labelText,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(suffixIcon),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );

//داله الانتقال من شاشة الى اخرى
//فقط نرسل لها الشاشة
void navigateTo(context, Widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Widget,
    ));
