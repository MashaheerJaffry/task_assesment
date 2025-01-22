import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_assesment/provider/user_provider.dart';
import 'package:task_assesment/utlis/app_color.dart';
import 'screens/user_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()..fetchUsers()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: AppColor.scaffoldBg,
            primaryColor: AppColor.blueColor),
        title: 'Paginated User List',
        home: const UserListScreen(),
      ),
    );
  }
}
