import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import '../models/price_entry.dart';
import '../repositories/api.dart';


final _log = Logger('DataService');


class DataService with ChangeNotifier
{
  DataService({
    required final ApiRepository api,
  })
  : _api = api;

  bool get isPriceLoading => _isPriceLoading;

  bool get isBackExist => _currentNode?.parent != null;

  List<PriceEntryModel> get entries => UnmodifiableListView(
    _currentNode?.children ?? _priceSourceEntries
  );

  Future<void> getPrice() async
  {
    try
    {
      _isPriceLoading = true;
      notifyListeners();
      final data = await _api.getPrice();
      _priceSourceEntries = data?.children ?? [];
      _currentNode = null;
    } finally {
      _isPriceLoading = false;
      notifyListeners();
    }
  }

  void expandNode(final PriceEntryModel entry)
  {
    if (entry.children.isEmpty) return;

    _currentNode = entry;
    notifyListeners();
  }

  void backToParentNode()
  {
    if (!isBackExist) return;

    _currentNode = _currentNode?.parent;
    notifyListeners();
  }


  var _priceSourceEntries = <PriceEntryModel>[];
  PriceEntryModel? _currentNode;

  var _isPriceLoading = false;

  final ApiRepository _api;
}