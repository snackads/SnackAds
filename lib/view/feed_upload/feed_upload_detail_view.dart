import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snack_ads/app.dart';
import 'package:snack_ads/controller/feed_upload_controller.dart';
import 'dart:developer' as dev;

import 'package:snack_ads/model/restaurant.dart';

double globalPadding = 16;

class FeedUploadDetailView extends StatefulWidget {
  final FeedUploadController feedUploadController;
  const FeedUploadDetailView({super.key, required this.feedUploadController});

  @override
  State<FeedUploadDetailView> createState() => _FeedUploadDetailViewState();
}

class _FeedUploadDetailViewState extends State<FeedUploadDetailView> {
  TextEditingController searchController = TextEditingController();
  String? selectedRestaurantRid;

  @override
  void initState() {
    super.initState();
    feedUploadController.getAllRestaurantList();
  }

  @override
  void dispose() {
    feedUploadController.removeRestaurantData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('가게 입력하기'),
        backgroundColor: Colors.black,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Column(
              children: [
                restaurantContainer(feedUploadController),
                const SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: globalPadding),
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      labelText: '검색하기',
                      hintText: '가게 이름 검색',
                      prefixIcon: Icon(Icons.search, color: Colors.black),
                      hintStyle: TextStyle(color: Colors.grey),
                      floatingLabelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: globalPadding),
                    child: ListView.builder(
                      itemCount: feedUploadController.allRestaurantList.length,
                      itemBuilder: (context, index) {
                        final listViewRestaurant =
                            feedUploadController.allRestaurantList[index];

                        return (listViewRestaurant.name
                                .toLowerCase()
                                .contains(searchController.text.toLowerCase()))
                            ? ListTile(
                                title: Text(listViewRestaurant.name),
                                trailing: Radio(
                                  value: listViewRestaurant.rid,
                                  groupValue: selectedRestaurantRid,
                                  onChanged: (value) {
                                    setState(() {
                                      if (selectedRestaurantRid !=
                                          listViewRestaurant.rid) {
                                        selectedRestaurantRid =
                                            listViewRestaurant.rid;
                                        widget.feedUploadController
                                            .updateRestaurantData(
                                                listViewRestaurant);
                                      }
                                    });
                                  },
                                ),
                                onTap: () {
                                  setState(() {
                                    if (selectedRestaurantRid !=
                                        listViewRestaurant.rid) {
                                      selectedRestaurantRid =
                                          listViewRestaurant.rid;
                                      widget.feedUploadController
                                          .updateRestaurantData(
                                              listViewRestaurant);
                                    }
                                  });
                                },
                              )
                            : const SizedBox.shrink();
                      },
                    ),
                  ),
                ),
              ],
            ),
            Align(alignment: Alignment.bottomCenter, child: bottomButton()),
          ],
        ),
      ),
    );
  }

  Widget bottomButton() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: globalPadding, vertical: globalPadding),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 60,
          child: ElevatedButton(
            onPressed: (widget.feedUploadController.restaurant.rid.isNotEmpty)
                ? () {
                    Restaurant temp = Restaurant(
                      rid: widget.feedUploadController.restaurant.rid,
                      name: widget.feedUploadController.restaurant.name,
                      description:
                          widget.feedUploadController.restaurant.description,
                      tagList: List<String>.from(
                          widget.feedUploadController.restaurant.tagList),
                      phone: widget.feedUploadController.restaurant.phone,
                      address: widget.feedUploadController.restaurant.address,
                      siteURL: widget.feedUploadController.restaurant.siteURL,
                      imageURL: widget.feedUploadController.restaurant.imageURL,
                      latitude: widget.feedUploadController.restaurant.latitude,
                      longitude:
                          widget.feedUploadController.restaurant.longitude,
                    );

                    widget.feedUploadController
                        .uploadNewVideoToDB(temp)
                        .then((value) {
                      if (value) {
                        context.go('/main');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('영상이 성공적으로 업로드되었습니다 :)'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('영상 업로드 중 문제가 발생하였습니다 :('),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      }
                    });
                  }
                : null,
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.black,
              disabledBackgroundColor: Colors.grey,
              disabledForegroundColor: Colors.white,
            ),
            child: designedText('업로드'),
          ),
        ),
      ),
    );
  }

  Widget designedText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.white, fontSize: 20),
    );
  }

  Widget restaurantContainer(FeedUploadController feedUploadController) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: globalPadding, vertical: globalPadding),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(feedUploadController.restaurant.imageURL),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  feedUploadController.restaurant.name,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 150,
                  child: Text(
                    feedUploadController.restaurant.address,
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
