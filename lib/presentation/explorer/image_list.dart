// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/application/explorer/explorer_state.dart';
import 'package:flutter_base/presentation/core/responsivity/responsive_calculations.dart';
import 'package:flutter_base/presentation/explorer/enhanced_image_draw.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class ImageList extends StatefulWidget {
  const ImageList({Key? key}) : super(key: key);

  @override
  State<ImageList> createState() => _ImageListState();
}

class _ImageListState extends State<ImageList> {
  final _scrollController = ScrollController();
  final _state = GetIt.I.get<ExplorerState>();

  // Used to display loading indicators when _getMoreImages function is running
  bool _isLoadMoreRunning = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_getMoreImages);
  }

  Future<void> _getMoreImages() async {
    final _hasMoreData = _state.totalImages > _state.finalElement;
    if (_hasMoreData &&
        !_isLoadMoreRunning &&
        _scrollController.position.atEdge &&
        _scrollController.position.extentBefore !=
            _scrollController.position.minScrollExtent) {
      setState(() {
        _isLoadMoreRunning = true;
      });
      _state.initialElement = _state.finalElement;
      _state.finalElement += 10;
      await _state.getImages(
        _state.enteredKeywords,
        _state.initialElement,
        _state.finalElement,
      );
      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_getMoreImages);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Consumer<ExplorerState>(
        builder: (context, state, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: state.totalImages != 0,
                child: Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 1.5 * Info.verticalUnit,
                    horizontal: Info.horizontalUnit,
                  ),
                  child: Text('${state.totalImages} results found'),
                ),
              ),
              Flexible(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: state.images.length,
                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    return EnhancedImageDraw(
                      image: state.images[index],
                    );
                  }),
                ),
              ),
              Center(
                child: Visibility(
                  visible: _isLoadMoreRunning,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: Container(
                    margin: EdgeInsets.only(top: Info.verticalUnit),
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ),
              ),
              Center(
                child: Visibility(
                  visible: !_isLoadMoreRunning && state.error != null,
                  child: Container(
                    margin: EdgeInsets.only(top: Info.verticalUnit),
                    child: Text(
                      state.error?.message ?? '',
                      style: TextStyle(
                        color: Colors.red[400],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
