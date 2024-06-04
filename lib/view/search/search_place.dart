import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:snack_ads/controller/map/kakao_service.dart';
import 'package:snack_ads/controller/map/location_service.dart';
import 'package:snack_ads/model/place_detail.dart';
import 'package:snack_ads/util/color_manager.dart';
import 'package:snack_ads/util/text_style_manager.dart';
import 'package:snack_ads/widget/place_detail_bottom_sheet.dart';

class SearchPlaceView extends StatefulWidget {
  const SearchPlaceView({super.key});

  @override
  State<SearchPlaceView> createState() => _SearchPlaceViewState();
}

class _SearchPlaceViewState extends State<SearchPlaceView> {
  late final TextEditingController _controller;
  bool isFetching = false;
  final List<KakaoSearchResult> searchResult = [];
  bool didCacheFetch = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      try {
        // final query = Provider.of<FormProvider>(context, listen: false)
        //     .getModelById("${widget.formId}-query");
        // _controller.text = query.displayTitle;
        // if (query.value is KakaoSearchResult) {
        //   searchResult.clear();
        //   searchResult.add(query.value);
        // }
      } catch (_) {
      } finally {
        if (mounted) {
          setState(() {
            didCacheFetch = true;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              FilledButton.icon(
                onPressed: () async {
                  try {
                    setState(() {
                      isFetching = true;
                    });
                    if (_controller.text.isEmpty) {
                      throw SearchKeyWordNotValidException(msg: "검색어를 입력해주세요.");
                    }
                    Position? pos;
                    try {
                      pos = await LocationService().getCurrentLocation();
                    } on LocationServiceException catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(e.message)));
                      }
                    }
                    final result = await KakaoSearchService().searchPlaces(
                        querySet: KakaoSearchQuerySet(
                      query: _controller.text,
                      y: pos?.latitude.toString(),
                      x: pos?.longitude.toString(),
                    ));
                    searchResult.clear();
                    searchResult.add(result);
                    if (context.mounted) {
                      // final key = "${widget.formId}-query";
                      // Provider.of<FormProvider>(context, listen: false)
                      //     .setFormData(
                      //         FormDataModel(
                      //             id: key,
                      //             displayTitle: _controller.text,
                      //             value: result),
                      //         shouldNotify: false);
                    }
                  } on SearchKeyWordNotValidException catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.msg)));
                    }
                  } on FetchException catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.msg)));
                    }
                  } finally {
                    if (mounted) {
                      setState(() {
                        isFetching = false;
                      });
                    }
                  }
                },
                label: const Text("검색하기"),
                icon: const Icon(Icons.search),
              ),
            ],
          ),
          _buildList(),
        ],
      ),
    );
  }

  bool isAlreadySaved(String id) {
    // final myPlaces = Provider.of<PlaceProvider>(context).places;
    // return myPlaces != null &&
    //     myPlaces
    //         .where(
    //           (element) => element.kakaoPlaceId == id,
    //         )
    //         .isNotEmpty;
    return true;
  }

  Widget _buildList() {
    if (isFetching || !didCacheFetch) {
      return const LinearProgressIndicator();
    } else {
      if (searchResult.isEmpty) {
        return const Expanded(
          child: Center(
            child: Text("검색어로 검색해주세요"),
          ),
        );
      }
      // FormDataModel? selectedItem;
      try {
        // selectedItem =
        //     Provider.of<FormProvider>(context).getModelById(widget.formId);
      } catch (_) {}

      final list = searchResult.first.placeDetail;
      return Expanded(
        child: Column(
          children: [
            Row(
              children: [
                Text(
                    "검색결과: ${searchResult.first.placeDetail.length}/${searchResult.first.meta.totalCount}"),
                const Spacer(),
                // Text(
                //     "${searchResult.first.meta.pageableCount}중 ${searchResult.first.pageNo}번째 페이지")
              ],
            ),
            Expanded(
              child: ListView.separated(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    // shape: Border.all(
                    // color: isAlreadySaved(list[index].id)
                    //     ? ColorManager.navy
                    //     : list[index].id == selectedItem?.value.id
                    //         ? ColorManager.primary
                    //         : Colors.transparent),
                    onTap: isAlreadySaved(list[index].id)
                        ? null
                        : () {
                            // Provider.of<FormProvider>(context, listen: false)
                            //     .setFormData(
                            //   FormDataModel(
                            //     id: widget.formId,
                            //     displayTitle: widget.formTitle,
                            //     value: list[index],
                            //   ),
                            // );
                          },
                    title: Row(
                      children: [
                        Text(list[index].placeName),
                        if (isAlreadySaved(list[index].id))
                          const AlreadySavedPlaceMark(),
                      ],
                    ),
                    subtitle: Text(list[index].addressName),
                    trailing: IconButton.filledTonal(
                      onPressed: () {
                        showBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return PlaceDetailBottomSheet(
                              placeDetail: list[index],
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.open_in_full),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              ),
            ),
          ],
        ),
      );
    }
  }
}

class AlreadySavedPlaceMark extends StatelessWidget {
  const AlreadySavedPlaceMark({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 8,
        ),
        Text(
          "저장됨",
          style: TextStyleManager.body3grey09,
        ),
        Icon(
          Icons.cloud,
          color: ColorManager.grey09,
          size: 18,
        ),
      ],
    );
  }
}

class SearchKeyWordNotValidException implements Exception {
  final String msg;

  SearchKeyWordNotValidException({required this.msg});

  @override
  String toString() {
    return msg;
  }
}
