import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../components/components.dart';
import '../../news_cubit/news_cubit.dart';
import '../../news_cubit/news_state.dart';
import '../search/Search.dart';


class NewsHomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
     listener: (context,state){},
      builder: (context,state){
       var cubit=NewsCubit.get(context);
       return Scaffold(appBar:
       AppBar(
        systemOverlayStyle:SystemUiOverlayStyle(statusBarColor: Colors.black) ,
      
        backgroundColor: Colors.red,
        title: Text(
           'NewsApp'
       ),
         actions: [IconButton(onPressed:()
         {
           navigateTo(context, SearchScreen());
         },
             icon: Icon(Icons.search)),
           IconButton(onPressed:(){
            //  TodoCubit.get(context).changeDarkMode();
           },
               icon: Icon(Icons.brightness_4_outlined)),
         ],
       ),
         body: cubit.screens[cubit.currentIndex],
         bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 15,
          selectedItemColor: Colors.deepOrange,
           currentIndex: cubit.currentIndex,
           onTap: (index){
           cubit.changeNavBar(index);
           },
           items: cubit.bottomVBINewsList,
         ),
       );
      },
    );
  }
}
