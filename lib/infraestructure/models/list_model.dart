//Clase para obtener la informacion de json a dart 
class PurpleList {
    final List<Map<String, String?>> meals;

    PurpleList({
        required this.meals,
    });

    factory PurpleList.fromJson(Map<String, dynamic> json) {
        // Verificar si 'meals' es null y proporcionar una lista vacía en ese caso
        if (json["meals"] == null) {
            return PurpleList(meals: []);
        }
        
        return PurpleList(
            meals: List<Map<String, String?>>.from(
                json["meals"].map((x) => Map.from(x).map((k, v) => MapEntry<String, String?>(k, v?.toString())))
            ),
        );
    }

    Map<String, dynamic> toJson() => {
        "meals": List<dynamic>.from(meals.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
    };
} 