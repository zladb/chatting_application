import 'package:flutter/material.dart';
import 'package:flutter_block/layout/default_layout.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../component/custom_text_from_field.dart';
import '../component/toast.dart';
import '../const/colors.dart';
import '../provider/auth_provider.dart';
import '../user/auth/auth.dart';
import 'chats_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController nicknameController = TextEditingController();
  String? userName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    // });
    userName = ref.read(firebaseAuthProvider).currentUser?.displayName;

  }

  @override
  void dispose() {
    // TODO: implement dispose
    nicknameController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    var user = ref.watch(firebaseAuthProvider).currentUser;

    // if (user != null) {}
    // ref.read(firebaseAuthProvider).authStateChanges().listen((User? user) {
    //   if (user == null) {
    //     print('User is currently signed out!');
    //   } else {
    //     setState(() {
    //       userName = nicknameController.text;
    //     });
    //   }
    // });




    return DefaultLayout(
      title: 'chatting',
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              // height: MediaQuery.of(context).size.height - kToolbarHeight*2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _Title(),
                  const SizedBox(height: 16.0),
                  Image.asset(
                    'asset/img/hamging_sketchbook.png',
                    // width: MediaQuery.of(context).size.width / 3 *2,
                    width: 300,
                    height: 300,
                  ),
                  const SizedBox(height: 32.0),
                  if (user != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        '현재 설정된 이름: ${userName}',
                        style: TextStyle(
                          fontSize: 12,
                          color: BODY_TEXT_COLOR,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  const SizedBox(height: 8.0),
                  CustomTextFormField(
                    controller: nicknameController,
                    hintText: '닉네임을 입력해주세요',
                    onChanged: (String value) {
                      userName = value;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        userName = nicknameController.text;
                      });
                      if (user != null) {
                        await user!.updateDisplayName(nicknameController.text);
                        showToast(
                            fToast: fToast, text: '내이름은 ${nicknameController.text} !');
                      }
                      if (!context.mounted) return;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChatsScreen()));
                    },
                    child: Text('이걸로 할래요!'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PRIMARY_COLOR,
                      padding: const EdgeInsets.all(20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '나랑 놀자',
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      textAlign: TextAlign.center,
    );
  }
}
