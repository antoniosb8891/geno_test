
class PriceEntryModel
{
  final List<PriceEntryModel> children;
  final String? id;
  final String? value;
  final PriceEntryModel? parent;

  PriceEntryModel({
    required this.parent,
    required this.children,
    this.id,
    this.value,
  });

  factory PriceEntryModel.fromJson(
    final Map<String, dynamic> jsonValue, {
    required final PriceEntryModel? parent,
    final String? id,
    final String? value,
  })
  {
    final children = <PriceEntryModel>[];
    final newNode = PriceEntryModel(
      children: children,
      id: id,
      value: value,
      parent: parent,
    );
    for (var e in jsonValue.entries) {
      final value = e.value;
      if (value is Map<String, dynamic>) {
        children.add(PriceEntryModel.fromJson(
          value,
          id: e.key,
          parent: newNode,
        ));
      } else if (value is List) {

      } else {
        children.add(PriceEntryModel(
          children: [],
          id: e.key,
          value: value.toString(),
          parent: newNode,
        ));
      }
    }
    return newNode;
  }

  static PriceEntryModel? fromJsonOr(
    final Map<String, dynamic>? jsonValue, {
    required final PriceEntryModel? parent,
    final String? id,
    final String? value,
  })
  {
    if (jsonValue == null) return null;
    return PriceEntryModel.fromJson(
      jsonValue,
      parent: parent,
      id: id,
      value: value,
    );
  }

  String getName()
  {
    final tagName = children.where((e) => e.id == 'name').firstOrNull;
    return tagName?.value ?? id ?? 'noname';
  }
}