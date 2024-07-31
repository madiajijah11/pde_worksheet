import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:pde_worksheet/routes/app_router.gr.dart';
import 'package:pde_worksheet/src/profile/profile_controller.dart';

@RoutePage(name: 'ProfileRoute')
class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late ProfileController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ProfileController();
    _controller.addListener(_updateState);
  }

  @override
  void dispose() {
    _controller.removeListener(_updateState);
    super.dispose();
  }

  void _updateState() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final fullName = _controller.decodedToken['fullName'];
    final accessRight = _controller.decodedToken['accessRight'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                child: Icon(Icons.person),
              ),
              SizedBox(height: 16),
              Text(
                '$fullName',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                '$accessRight',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 16),
              FilledButton(
                onPressed: () async {
                  await _controller.logout(context);
                  if (mounted) {
                    AutoRouter.of(context)
                        .replace(LoginRoute(onResult: (result) async {
                      if (result != null) {
                        AutoRouter.of(context).removeLast();
                      }
                    }));
                  }
                },
                child: Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
