enum TopWear {
  tShirts,
  shirts,
  blouses,
  tankTops,
  hoodies,
  sweaters,
  jackets,
  coats
}

enum BottomWear {
  jeans,
  trousers,
  leggings,
  shorts,
  skirts,
  cargoPants,
  joggers
}

enum Footwear {
  sports,
  sneakers,
  boots,
  sandals,
  loafers,
  flipFlops,
  heels,
  flats
}

extension TopWearExtension on TopWear {
  String get name {
    switch (this) {
      case TopWear.tShirts:
        return "Tshirts";
      case TopWear.shirts:
        return "Shirts";
      case TopWear.blouses:
        return "Blouses";
      case TopWear.tankTops:
        return "Tanktops";
      case TopWear.hoodies:
        return "Hoodies";
      case TopWear.sweaters:
        return "Sweaters";
      case TopWear.jackets:
        return "Jackets";
      case TopWear.coats:
        return "Coats";
    }
  }
}

extension BottomWearExtension on BottomWear {
  String get name {
    switch (this) {
      case BottomWear.jeans:
        return "Jeans";
      case BottomWear.trousers:
        return "Trousers";
      case BottomWear.leggings:
        return "Leggings";
      case BottomWear.shorts:
        return "Shorts";
      case BottomWear.skirts:
        return "Skirts";
      case BottomWear.cargoPants:
        return "Cargopants";
      case BottomWear.joggers:
        return "Joggers";
    }
  }
}

extension FootwearExtension on Footwear {
  String get name {
    switch (this) {
      case Footwear.sports:
        return "Sports";
      case Footwear.sneakers:
        return "Sneakers";
      case Footwear.boots:
        return "Boots";
      case Footwear.sandals:
        return "Sandals";
      case Footwear.loafers:
        return "Loafers";
      case Footwear.flipFlops:
        return "Flipflops";
      case Footwear.heels:
        return "Heels";
      case Footwear.flats:
        return "Flats";
    }
  }
}