import 'package:flutter/material.dart';

import '../models/price_entry.dart';


class NodeEntry extends StatelessWidget
{
  final PriceEntryModel _model;
  final ValueChanged<PriceEntryModel>? _onTap;

  const NodeEntry({super.key,
    required final PriceEntryModel model,
    required final ValueChanged<PriceEntryModel>? onTap,
  })
  : _model = model
  , _onTap = onTap;

  @override
  Widget build(BuildContext context)
  {
    return InkWell(
      onTap: _onTap != null ? () => _onTap(_model) : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(_model.getName()),
        ],
      ),
    );
  }

}