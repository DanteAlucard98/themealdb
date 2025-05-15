class PurpleList {
    final List<Map<String, String?>> meals;

    PurpleList({
        required this.meals,
    });

    factory PurpleList.fromJson(Map<String, dynamic> json) => PurpleList(
        meals: List<Map<String, String?>>.from(json["meals"].map((x) => Map.from(x).map((k, v) => MapEntry<String, String?>(k, v)))),
    );

    Map<String, dynamic> toJson() => {
        "meals": List<dynamic>.from(meals.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
    };
}
