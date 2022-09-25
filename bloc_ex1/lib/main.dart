import 'package:bloc_ex1/app_router.dart';
import 'package:bloc_ex1/constants/mycolors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BreakingBadApp());
}

class BreakingBadApp extends StatelessWidget {
  BreakingBadApp({Key? key}) : super(key: key);
  final AppRouter _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: _appRouter.generatorRouter,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(secondary: MyColors.myYellow)

        ));
  }
}
