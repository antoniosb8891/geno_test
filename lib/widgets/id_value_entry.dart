import 'package:flutter/material.dart';

import '../models/price_entry.dart';

class IdValueEntry extends StatelessWidget
{
  final PriceEntryModel _model;

  const IdValueEntry({super.key,
    required final PriceEntryModel model,
  })
  : _model = model;

  @override
  Widget build(BuildContext context)
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (_model.id != null)
          Text(_model.id!),
        if (_model.value != null)
          Text(_model.value!),
      ],
    );
  }

}