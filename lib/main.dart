import 'package:egp_news/modules/NewsApp/news_layout/News_home_layout.dart';
import 'package:egp_news/modules/news_cubit/news_cubit.dart';
import 'package:egp_news/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'modules/news_cubit/news_state.dart';

void main() {
  runApp(const MyApp());
  dioHelper.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => NewsCubit(NewsInitialState())
              ..getbusiness()
              ..getSports()
              ..getScience(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: NewsHomeLayout(),
        ));
  }
}
