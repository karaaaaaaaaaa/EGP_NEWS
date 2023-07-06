import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../network/remote/dio_helper.dart';
import '../NewsApp/business/business_screen.dart';
import '../NewsApp/science/science_screen.dart';
import '../NewsApp/sports/sports_screen.dart';

import 'news_state.dart';

// https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=c617c5f86f944aa3a7ff6c5f401e6a83
class NewsCubit extends Cubit<NewsStates> {
  NewsCubit(NewsStates initialState) : super(initialState);
  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomVBINewsList = [
    BottomNavigationBarItem(
        icon: Icon(Icons.business_sharp), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
  ];
  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];
  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  List<dynamic> search = [];
  // https://gnews.io/api/v4/top-headlines?country=eg&category=sport&apikey=b6c932ce4ff392f5b4bc0df9375766ec
  void getbusiness() {
    emit(NewsGetBusinessLoadingState());
    dioHelper.getdata(path: 'api/v4/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apikey': 'b6c932ce4ff392f5b4bc0df9375766ec'
    }).then((value) {
      business = value.data['articles'];
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }



  void getSports() {
    emit(NewsGetSportsLoadingState());
    dioHelper.getdata(path: 'api/v4/top-headlines', query: {
      'country': 'eg',
      'category': 'sport',
      'apikey': 'b6c932ce4ff392f5b4bc0df9375766ec'
    }).then((value) {
      sports = value.data['articles'];
      print(sports[0]['title']);
      emit(NewsGetSportsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSportsErrorState(error.toString()));
    });
  }

  void getScience() {
    emit(NewsGetScienceLoadingState());

    dioHelper.getdata(
        //  https://newsapi.org/v2/top-headlines?country=us&category=science&apiKey=c617c5f86f944aa3a7ff6c5f401e6a83
        path: 'api/v4/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apikey': 'b6c932ce4ff392f5b4bc0df9375766ec'
        }).then((value) {
      science = value.data['articles'];
      print(science[0]['title']);
      emit(NewsGetScienceSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetScienceErrorState(error.toString()));
    });
  }

  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());
    dioHelper.getdata(path: 'v4/everything', query: {
      'q': '$value',
      'apikey': 'b6c932ce4ff392f5b4bc0df9375766ec'
    }).then((value) {
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }

  void changeNavBar(int index) {
    currentIndex = index;

    emit(NewsBottomNav());
  }
}
