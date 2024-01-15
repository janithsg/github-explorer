import 'package:flutter/material.dart';
import 'package:gh_users_viewer/features/user_repository/data/model/repository_list_item.dart';

class RepoListTile extends StatelessWidget {
  final RepositoryListItem listItem;

  const RepoListTile({
    super.key,
    required this.listItem,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text(
            "${listItem.name!} : ⭐️${listItem.stargazersCount}",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            listItem.description ?? "-",
            style: const TextStyle(
              color: Colors.blueGrey,
            ),
          ),
          dense: false,
          contentPadding: const EdgeInsets.all(0),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Wrap(
            children: List<Widget>.generate(
              listItem.languageList?.length ?? 0,
              (index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 3),
                  child: Chip(
                    label: Text(
                      listItem.languageList![index],
                      style: const TextStyle(color: Colors.white),
                    ),
                    elevation: 0,
                    visualDensity: VisualDensity.compact,
                    padding: const EdgeInsets.all(0),
                    color: const MaterialStatePropertyAll(
                      Colors.black,
                    ),
                    side: BorderSide.none,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
