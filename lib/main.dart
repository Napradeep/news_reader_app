import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:newapp/src/model/new_model.dart';
import 'package:newapp/src/utils/router/router.dart';
import 'package:newapp/src/utils/snackbar/messager.dart';
import 'package:newapp/src/view/news_screeen.dart';
import 'package:path_provider/path_provider.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final documnetDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(documnetDir.path);
   Hive.registerAdapter(NewmodelAdapter()); 

  await Hive.openBox<Newmodel>('newsBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: MyRouter.navigatorKey,
      scaffoldMessengerKey: Messenger.rootScaffoldMessengerKey,

      home: NewScreen(),
    );
  }
}
