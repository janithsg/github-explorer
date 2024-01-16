import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gh_users_viewer/features/users_list/bloc/users_list_bloc.dart';

class FindUserAlert extends StatefulWidget {
  const FindUserAlert({super.key});

  @override
  State<FindUserAlert> createState() => _FindUserAlertState();
}

class _FindUserAlertState extends State<FindUserAlert> {
  final TextEditingController _usernameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Find User"),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.2,
        child: BlocBuilder<UsersListBloc, UsersListState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Enter GitHub Username to Find",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      "github.com/",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(hintText: "username"),
                        controller: _usernameCtrl,
                      ),
                    ),
                  ],
                ),
                state.isUserDetailsError
                    ? const Text(
                        "User Not Found",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.red,
                        ),
                      )
                    : const SizedBox(),
                ElevatedButton.icon(
                  onPressed: state.isFetchingUserDetails
                      ? null
                      : () {
                          BlocProvider.of<UsersListBloc>(context).add(
                            GetUserDetailsByUsernameEvent(username: _usernameCtrl.text),
                          );
                        },
                  icon: state.isFetchingUserDetails
                      ? const SizedBox(
                          height: 30,
                          width: 30,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : const SizedBox(),
                  label: const Text("Find User"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
