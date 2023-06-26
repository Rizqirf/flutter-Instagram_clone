import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/add_post_screen.dart';
import 'package:instagram_clone/screens/home_screen.dart';
import 'package:instagram_clone/screens/profile_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
// import 'package:instagram_clone/utils/colors.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: const [
          Home(),
          Profile(),
          AddPost(),
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _page == 0 ? primaryColor : secondaryColor,
            ),
            // label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle,
              color: _page == 1 ? primaryColor : secondaryColor,
            ),
            // label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _page == 2 ? primaryColor : secondaryColor,
            ),
            // label: '',
          ),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
// class MobileScreenLayout extends StatelessWidget {
//   const MobileScreenLayout({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text('This is sssasMobisles'),
//       ),
//       bottomNavigationBar: CupertinoTabBar(
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             // label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search),
//             // label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             // label: '',
//           ),
//         ],
//       ),
//     );
//   }
// }
