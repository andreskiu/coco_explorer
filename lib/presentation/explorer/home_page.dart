import 'package:flutter/material.dart';
import 'package:flutter_base/domain/explorer/entities/keywords.dart';
import 'package:flutter_base/presentation/core/responsivity/responsive_calculations.dart';
import 'package:flutter_base/presentation/explorer/image_list.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../application/explorer/explorer_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key key = const Key("homePage"),
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ExplorerState _state;
  bool _loadingImages = false;
  // List<Keywords> _enteredKeywords = [];
  @override
  void initState() {
    super.initState();
    _state = GetIt.I.get<ExplorerState>();
    _state.getValidKeywords();
  }

  Future<List<Keywords>> _findSuggestions(
      String word, List<Keywords> dataset) async {
    if (word.length != 0) {
      var lowercaseQuery = word.toLowerCase();
      return dataset.where((keyword) {
        return keyword.word.toLowerCase().contains(word.toLowerCase());
      }).toList(growable: false)
        ..sort((a, b) => a.word
            .toLowerCase()
            .indexOf(lowercaseQuery)
            .compareTo(b.word.toLowerCase().indexOf(lowercaseQuery)));
    } else {
      return [];
    }
  }

  Future<void> _onSearchPressed(
      BuildContext context, ExplorerState state) async {
    setState(() {
      _loadingImages = true;
    });
    state.images = [];
    await state.getImages(
      state.enteredKeywords,
      state.initialElement,
      state.finalElement,
    );
    setState(() {
      _loadingImages = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Coco Explorer!",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: ChangeNotifierProvider<ExplorerState>.value(
          value: _state,
          builder: (context, snapshot) {
            return Consumer<ExplorerState>(
              builder: (context, explorerState, child) {
                return Column(
                  children: [
                    explorerState.isLoadingKeywords
                        ? Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5 * Info.horizontalUnit),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: ChipsInput<Keywords>(
                                    decoration:
                                        InputDecoration(hintText: 'Keywords'),
                                    chipBuilder: (context, state, keyword) {
                                      return InputChip(
                                        key: ObjectKey(keyword),
                                        label: Text(keyword.word),
                                        onDeleted: () =>
                                            state.deleteChip(keyword),
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      );
                                    },
                                    suggestionBuilder:
                                        (context, state, keyword) {
                                      return ListTile(
                                        key: ObjectKey(keyword),
                                        title: Text(keyword.word),
                                        subtitle: Text(keyword.id.toString()),
                                        onTap: () =>
                                            state.selectSuggestion(keyword),
                                      );
                                    },
                                    findSuggestions: (word) => _findSuggestions(
                                        word, explorerState.keywords),
                                    onChanged: (keywords) {
                                      explorerState.enteredKeywords = keywords;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 5 * Info.horizontalUnit,
                                ),
                                ElevatedButton(
                                  onPressed: () => _onSearchPressed(
                                    context,
                                    explorerState,
                                  ),
                                  child: Text('Search'),
                                )
                              ],
                            ),
                          ),
                    Flexible(
                      child: _loadingImages
                          ? Center(
                              child: CircularProgressIndicator.adaptive(),
                            )
                          : ImageList(),
                    )
                  ],
                );
              },
            );
          }),
    );
  }
}
