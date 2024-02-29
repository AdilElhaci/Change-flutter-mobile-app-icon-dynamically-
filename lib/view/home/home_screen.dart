import 'package:flutter/material.dart';
import 'package:flutter_dynamic_icon/flutter_dynamic_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int iconIndex = 0;
  List imageFiles = [
    'assets/images/red_icon.png',
    'assets/images/blue_icon.png',
    'assets/images/black_icon.png',
  ];
  List iconName = <String>['red_icon', 'blue_icon', 'black_icon'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('Home')),
      body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildIconTile(0, 'red'),
              buildIconTile(1, 'dark'),
              buildIconTile(2, 'blue'),
              SizedBox(height: 24,),
              InkWell(
                onTap: (){
                  changeAppIcon();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepPurple
                  ),
                  child: const Center(
                    child: Text(
                      'change icon',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )

            ],
          )),
    );
  }
  Widget buildIconTile(int index, String themeTxt) => GestureDetector(
    onTap: () => setState(() => iconIndex = index),
    child: ListTile(
        contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
        leading: Image.asset(
          imageFiles[index],
          width: 45,
          height: 45,
        ),
        title: Text(themeTxt, style: const TextStyle(fontSize: 25)),
        trailing: iconIndex == index
            ? const Icon(
          Icons.check_circle_rounded,
          color: Colors.green,
          size: 30,
        )
            : Icon(
          Icons.circle_outlined,
          color: Colors.grey.withOpacity(0.5),
          size: 30,
        ),
    ),
  );
  changeAppIcon() async {
    try {
      if (await FlutterDynamicIcon.supportsAlternateIcons) {
        await FlutterDynamicIcon.setAlternateIconName(iconName[iconIndex]);
        debugPrint("App icon change successful");
        return;
      }
    } catch (e) {
      debugPrint("Exception: ${e.toString()}");
    }
    debugPrint("Failed to change app icon ");
  }
}
