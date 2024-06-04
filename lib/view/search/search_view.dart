import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:snack_ads/controller/map/local_service.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final localService = Provider.of<LocalService>(context);
    final TextEditingController controller = TextEditingController();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Search"),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        hintText: '검색어를 입력하세요',
                      ),
                      onSubmitted: (value) =>
                          localService.kakaoLocalSearchKeyword(value),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        localService.kakaoLocalSearchKeyword(controller.text),
                    child: const Text('검색'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Consumer<LocalService>(
                builder: (context, value, child) {
                  return value.haveKakaoInfo == false
                      ? const Center(child: Text('가게를 검색해보세요.'))
                      : value.isLoading == true
                          ? const Center(child: CircularProgressIndicator())
                          : value.searchResult.isEmpty
                              ? const Center(child: Text('검색 결과가 없습니다.'))
                              : ListView.builder(
                                  itemCount: value.searchResult.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                        title: Text(value.searchResult[index]
                                            ['place_name']),
                                        subtitle: Text(value.searchResult[index]
                                            ['address_name']),
                                        onTap: () async {
                                          log("${value.searchResult[index]}",
                                              name: "Search Result");

                                          await value.checkRestaurantIsValid(
                                              value.searchResult[index]);

                                          await context.push(
                                            "/restaurantProfile",
                                            extra: value.searchResult[index]
                                                ["id"],
                                          );
                                        });
                                  },
                                );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
