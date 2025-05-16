class JewelleryType {
  final int id;
  final String name;
  final int count;

  JewelleryType({
    required this.id,
    required this.name,
    required this.count,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'count': count.toString(),
    };
  }

  static Map<String, dynamic> generateJewelleryTypesJson(List<JewelleryType> jewelleryTypes) {
    return {
      'jewellery_types': jewelleryTypes.map((type) => type.toJson()).toList()
    };
  }
}