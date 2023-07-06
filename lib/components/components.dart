import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../modules/NewsApp/webview/web_view.dart';


Widget defaultButton({
  double width = double.infinity,
  Color backGroundColor = Colors.blue,
  bool isUpperCase = true,
  double radius = 0.0,
  required void Function() onTap,
  required String text,
}) =>
    Container(
        width: width,
        decoration: BoxDecoration(
            color: backGroundColor,
            borderRadius: BorderRadius.circular(radius)),
        child: MaterialButton(
          onPressed: onTap,
          child: Text(
            isUpperCase ? text.toUpperCase() : text,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ));

Widget defaultFormText({
  required TextEditingController control,
  required TextInputType type,
  required dynamic validator,
  Function? onSubmit,
  Function? onChanged,
  Function? onTap,
  bool isPassword = false,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function()? suffixClicked,
}) =>
    TextFormField(
      controller: control,
      keyboardType: type,
      validator: validator,
      onFieldSubmitted: (s) {
        onSubmit!(s);
      },
      onTap: () {
        onTap!();
      },
      obscureText: isPassword,
      onChanged: (value) {
        onChanged!(value);
      },
      decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(prefix),
          suffixIcon: suffix != null
              ? IconButton(
                  onPressed: () {
                    suffixClicked!();
                  },
                  icon: Icon(suffix),
                )
              : null,
          border: OutlineInputBorder()),
    );

// Widget defaultAppBar({
//   required BuildContext context,
//   String ?title,
//   List<Widget>? actions,
// })=>AppBar(
//   leading: IconButton(
//     icon: Icon(IconBroken.Arrow___Left_2),
//     onPressed: (){
//       Navigator.pop(context);
//     },
//   ),
//   title: Text(
//      title!
//   ),
//   titleSpacing: 5.0,
//   actions: actions,
// );

Widget divider() => Container(
      color: Colors.grey,
      height: 1,
      width: double.infinity,
    );


Widget artical(aratical, context) => InkWell(
      onTap: () => navigateTo(context, WebViewScreen(url: aratical['url'])),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                aratical['image'] != null
                        ?
                Image.network(
                  
                  "${aratical['image']}",
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ):
                Image.network(
                   width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png')
                
                ,
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    height: 120,
                    child: Column(
                      children: [
                        Text(
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          "${aratical['title']}",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${aratical['publishedAt']}",
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
Widget listartical(buslist, context, {required int listcount,isseach=false, }) =>
    ConditionalBuilder(
      condition: buslist.length > 0,
      builder: (context) => ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => artical(buslist[index], context),
          separatorBuilder: (context, index) => divider(),
          itemCount: listcount),
      fallback: (context) =>isseach?Container(): Center(child: CircularProgressIndicator()),
    );
Widget buildArticleItems(article, context) => InkWell(
      onTap: () {
        navigateTo(
            context,
            WebViewScreen(
              url: article['url'],
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: article['urlToImage'] != null
                        ? DecorationImage(
                            image: NetworkImage('${article['urlToImage']}'),
                            fit: BoxFit.cover)
                        : DecorationImage(
                            image: NetworkImage(
                                'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png'),
                          ))),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget articleBuilder(businessList, context,
        {required int itemCount, isSearch = false}) =>
    ConditionalBuilder(
      condition: businessList.length > 0,
      builder: (context) => ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              buildArticleItems(businessList[index], context),
          separatorBuilder: (context, index) => dividerWidget(),
          itemCount: itemCount),
      fallback: (context) =>
          isSearch ? Container() : Center(child: CircularProgressIndicator()),
    );

Widget dividerWidget() => Container(
      width: double.infinity,
      height: 1,
      color: Colors.grey,
    );

void navigateTo(context, Widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Widget));
}

void navigateAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => Widget), (route) => false);

Widget defaultTextButton(
        {required void Function() onTap, required String text}) =>
    TextButton(
        onPressed: () {
          onTap();
        },
        child: Text(text.toUpperCase()));


enum ToastState { Success, Error, Warning }

Color chooseToastColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.Success:
      color = Colors.green;
      break;
    case ToastState.Error:
      color = Colors.red;
      break;
    case ToastState.Warning:
      color = Colors.amber;
      break;
  }
  return color;
}
