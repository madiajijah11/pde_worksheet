import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pde_worksheet/routes/app_router.gr.dart';
import 'package:pde_worksheet/store/store.dart';

@RoutePage(name: 'ProfileRoute')
class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
              ),
              SizedBox(height: 16),
              Text(
                'Aldhy Friyanto S.Kom',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                'USER',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 16),
              FilledButton(
                onPressed: () async {
                  await SecureStorage.delete('token');
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
