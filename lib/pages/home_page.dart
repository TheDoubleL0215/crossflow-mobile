import 'package:crossflow_mobile/auth/auth_services.dart';
import 'package:crossflow_mobile/theme/app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final currenUser = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    final _auth = AuthServices();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    print("Ez a user " + currenUser.email!);
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide.none),
              ),
              child: SvgPicture.asset("lib/img/logo_banner_light.svg"),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      title: Text("Chatroom"),
                    ),
                    ListTile(
                      title: Text("Chatroom"),
                    ),
                    ListTile(
                      title: Text("Chatroom"),
                    ),
                    ListTile(
                      title: Text("Chatroom"),
                    ),
                    ListTile(
                      title: Text("Chatroom"),
                    ),
                    ListTile(
                      title: Text("Chatroom"),
                    ),
                    ListTile(
                      title: Text("Chatroom"),
                    ),
                    ListTile(
                      title: Text("Chatroom"),
                    ),
                    ListTile(
                      title: Text("Chatroom"),
                    ),
                    ListTile(
                      title: Text("Chatroom"),
                    ),
                    ListTile(
                      title: Text("Chatroom"),
                    ),
                    ListTile(
                      title: Text("Chatroom"),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).colorScheme.secondary),
                child: ListTile(
                    dense: false,
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor:
                          Theme.of(context).colorScheme.onSecondary,
                      child: SvgPicture.asset(
                        "lib/img/icons/user_icon.svg",
                        height: 25,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    title: Text(
                      currenUser.email!,
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                    ),
                    trailing: GestureDetector(
                        onTap: signUserOut, child: Icon(Icons.logout))),
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(),
      body: Center(child: Text("Üdv " + currenUser.email!)),
    );
  }
}
