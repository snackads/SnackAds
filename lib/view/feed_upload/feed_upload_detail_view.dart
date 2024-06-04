import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:snack_ads/app.dart';
import 'package:snack_ads/controller/feed_upload_controller.dart';
import 'package:snack_ads/controller/map/local_service.dart';
import 'dart:developer';

import 'package:snack_ads/model/restaurant.dart';

// TODO: 여기부분도 형진 너가 좀 수정해야 될 수 있다.

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
    // feedUploadController.getAllRestaurantList();
  }

  @override
  void dispose() {
    feedUploadController.removeRestaurantData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localService = Provider.of<LocalService>(context);

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
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: const InputDecoration(
                            labelText: '검색하기',
                            hintText: '가게 이름 검색',
                            prefixIcon: Icon(Icons.search, color: Colors.black),
                            hintStyle: TextStyle(color: Colors.grey),
                            floatingLabelStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)),
                            ),
                          ),
                          onSubmitted: (value) =>
                              localService.kakaoLocalSearchKeyword(value),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () => localService
                            .kakaoLocalSearchKeyword(searchController.text),
                        child: const Text('검색'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Expanded(
                //   child: Padding(
                //     padding: EdgeInsets.symmetric(horizontal: globalPadding),
                //     child: ListView.builder(
                //       itemCount: feedUploadController.allRestaurantList.length,
                //       itemBuilder: (context, index) {
                //         final listViewRestaurant =
                //             feedUploadController.allRestaurantList[index];

                //         return (listViewRestaurant.place_name
                //                 .toLowerCase()
                //                 .contains(searchController.text.toLowerCase()))
                //             ? ListTile(
                //                 title: Text(listViewRestaurant.place_name),
                //                 trailing: Radio(
                //                   value: listViewRestaurant.id,
                //                   groupValue: selectedRestaurantRid,
                //                   onChanged: (value) {
                //                     setState(() {
                //                       if (selectedRestaurantRid !=
                //                           listViewRestaurant.id) {
                //                         selectedRestaurantRid =
                //                             listViewRestaurant.id;
                //                         widget.feedUploadController
                //                             .updateRestaurantData(
                //                                 listViewRestaurant);
                //                       }
                //                     });
                //                   },
                //                 ),
                //                 onTap: () {
                //                   setState(() {
                //                     if (selectedRestaurantRid !=
                //                         listViewRestaurant.id) {
                //                       selectedRestaurantRid =
                //                           listViewRestaurant.id;
                //                       widget.feedUploadController
                //                           .updateRestaurantData(
                //                               listViewRestaurant);
                //                     }
                //                   });
                //                 },
                //               )
                //             : const SizedBox.shrink();
                //       },
                //     ),
                //   ),
                // ),
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
                                            title: Text(
                                                value.searchResult[index]
                                                    ['place_name']),
                                            subtitle: Text(
                                                value.searchResult[index]
                                                    ['address_name']),
                                            focusColor: Colors.blueGrey,
                                            onTap: () async {
                                              log("${value.searchResult[index]}",
                                                  name: "Search Result");

                                              await value
                                                  .checkRestaurantIsValid(value
                                                      .searchResult[index]);

                                              Restaurant restaurant =
                                                  await value.getRestaurant(
                                                      value.searchResult[index]
                                                          ["id"]);

                                              setState(() {
                                                if (selectedRestaurantRid !=
                                                    restaurant.id) {
                                                  selectedRestaurantRid =
                                                      restaurant.id;
                                                  widget.feedUploadController
                                                      .updateRestaurantData(
                                                          restaurant);
                                                }
                                              });
                                            });
                                      },
                                    );
                    },
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
            onPressed: (widget.feedUploadController.restaurant.id.isNotEmpty)
                ? () {
                    Restaurant temp = Restaurant(
                      id: widget.feedUploadController.restaurant.id,
                      place_name:
                          widget.feedUploadController.restaurant.place_name,
                      tag_list: List<String>.from(
                          widget.feedUploadController.restaurant.tag_list),
                      phone: widget.feedUploadController.restaurant.phone,
                      imageurl: widget.feedUploadController.restaurant.imageurl,
                      address_name:
                          widget.feedUploadController.restaurant.address_name,
                      place_url:
                          widget.feedUploadController.restaurant.place_url,
                      road_address_name: widget
                          .feedUploadController.restaurant.road_address_name,
                      x: widget.feedUploadController.restaurant.x,
                      y: widget.feedUploadController.restaurant.y,
                      timeList: widget.feedUploadController.restaurant.timeList,
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
                  image: NetworkImage(feedUploadController.restaurant.imageurl),
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
                  feedUploadController.restaurant.place_name,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 150,
                  child: Text(
                    feedUploadController.restaurant.address_name,
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
