import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../components/components.dart';

import '../../news_cubit/news_cubit.dart';
import '../../news_cubit/news_state.dart';

class SportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        List businessList=NewsCubit.get(context).sports;
        return listartical(businessList, context, listcount: 10, );
      },
    );
  }
}
