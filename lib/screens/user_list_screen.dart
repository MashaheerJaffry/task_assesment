import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:task_assesment/services/location_services.dart';
import 'package:task_assesment/utlis/app_color.dart';
import 'package:task_assesment/utlis/text_style.dart';
import '../provider/user_provider.dart';
import '../widgets/user_card.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    LocationServices().checkLocationPermissions();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(size.height * 0.25),
          child: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              margin: EdgeInsets.all(size.width * 0.02),
              decoration: BoxDecoration(
                color: AppColor.blueColor,
                borderRadius: BorderRadius.circular(size.width * 0.04),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'User List',
                    style: AppStyle().style516.copyWith(
                          fontSize: size.width * 0.045,
                          fontWeight: FontWeight.w600,
                          color: AppColor.whiteColor,
                        ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.04),
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Search users...',
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(size.width * 0.04),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.04),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
        ),
        body: NotificationListener<ScrollNotification>(
          onNotification: (scrollInfo) {
            if (scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent &&
                userProvider.hasMore &&
                !userProvider.isLoading) {
              userProvider.fetchUsers(loadMore: true);
            }
            return true;
          },
          child: userProvider.users.isEmpty
              ? Center(
                  child: userProvider.isLoading
                      ? const CircularProgressIndicator()
                      : const Text('No users found.'),
                )
              : ListView.builder(
                  itemCount: userProvider.users.length +
                      (userProvider.hasMore ? 1 : 0),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (index == userProvider.users.length) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final user = userProvider.users[index];
                    return UserCard(user: user);
                  },
                ),
        ),
      ),
    );
  }
}
