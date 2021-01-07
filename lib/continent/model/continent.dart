class Continents {
    Continents({
        this.continents,
    });

    final List<Continent> continents;

    factory Continents.fromJson(Map<String, dynamic> json) => Continents(
        continents: List<Continent>.from(json["continents"].map((x) => Continent.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "continents": List<dynamic>.from(continents.map((x) => x.toJson())),
    };
}

class Continent {
    Continent({
        this.name,
    });

    final String name;

    factory Continent.fromJson(Map<String, dynamic> json) => Continent(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}