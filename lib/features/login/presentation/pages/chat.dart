import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/app_strings.dart';
import 'package:chat_app/features/login/presentation/blocs/Chat%20cubit/cubit/chat_cubit.dart';
import 'package:chat_app/features/login/presentation/widgets/chat_component.dart';
import 'package:chat_app/features/login/presentation/widgets/component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Chat extends StatefulWidget {
  const Chat({super.key, required this.receiverId, required this.name});
  final String receiverId;
  final String name;
  @override
  // ignore: no_logic_in_create_state
  State<Chat> createState() => _ChatState(name, receiverId);
}

class _ChatState extends State<Chat> {
  final String name;
  final String receiverId;
  final ScrollController _scrollController = ScrollController();
  bool isKeyboardOpen = false; // Track keyboard state
  var messageController = TextEditingController();
  var messageFocusNode = FocusNode();
  _ChatState(this.name, this.receiverId);
  @override
  void initState() {
    super.initState();

    BlocProvider.of<ChatCubit>(context).getMessages(receiverId: receiverId);
    // Listen for focus changes to update the keyboard state
    messageFocusNode.addListener(() {
      // _scrollController.animateTo(
      //   _scrollController.position.maxScrollExtent,
      //   duration: const Duration(milliseconds: 100),
      //   curve: Curves.easeOut,
      // );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<ChatCubit>(context);
    return Builder(builder: (context) {
      return BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          _scrollController.animateTo(
            _scrollController.position.minScrollExtent,
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeOut,
          );
        },
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async {
              cubit.messages.clear();
              return true;
            },
            child: Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () {
                      cubit.messages.clear();
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  elevation: 3,
                  shadowColor: AppColors.shadow,
                  backgroundColor: Colors.white,
                  toolbarHeight: 66,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.only(top: 15, left: 50),
                    child: Row(children: [
                      const ImageAvatar(size: 23),
                      const SizedBox(
                        width: 12,
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Name(name: name),
                        ],
                      ),
                    ]),
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(children: [
                    Expanded(
                      child: ListView.separated(
                          reverse: true,
                          shrinkWrap: true,
                          controller: _scrollController,
                          itemBuilder: (context, index) {
                            if (cubit.messages[index].senderId ==
                                AppStrings.uId) {
                              return MyMessage(
                                text: cubit.messages[index].text!,
                              );
                            }

                            return RecieverMessage(
                              text: cubit.messages[index].text!,
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          itemCount: cubit.messages.length),
                    ),
                    if (cubit.messages.isEmpty)
                      const Expanded(
                        child: Center(
                          child: CupertinoActivityIndicator(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 5,
                    ),
                    defualtTextFormField(
                        focusNode: messageFocusNode, // Assign the focus node
                        controller: messageController,
                        type: TextInputType.text,
                        validate: (value) {
                          return null;
                        },
                        hint: 'type your message here ...',
                        suffix: IconButton(
                            onPressed: () {
                              cubit.sendMessage(
                                  messageController.text, receiverId);
                              messageController.clear();
                              if (cubit.messages.isNotEmpty) {
                                _scrollController.jumpTo(
                                  _scrollController.position.minScrollExtent,
                                );
                              }
                            },
                            icon: const Icon(Icons.send_sharp))),
                  ]),
                )),
          );
        },
      );
    });
  }
}
