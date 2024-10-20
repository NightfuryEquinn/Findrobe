enum TopWear {
  tShirts,
  shirts,
  blouses,
  tankTops,
  hoodies,
  sweaters,
  jackets,
  coats,
  others
}

enum BottomWear {
  jeans,
  trousers,
  leggings,
  shorts,
  skirts,
  cargoPants,
  joggers,
  others
}

enum Footwear {
  sports,
  sneakers,
  boots,
  sandals,
  loafers,
  flipFlops,
  heels,
  flats,
  others
}

extension TopWearExtension on TopWear {
  String get name {
    switch (this) {
      case TopWear.tShirts:
        return "T-Shirts";
      case TopWear.shirts:
        return "Shirts";
      case TopWear.blouses:
        return "Blouses";
      case TopWear.tankTops:
        return "Tank Tops";
      case TopWear.hoodies:
        return "Hoodies";
      case TopWear.sweaters:
        return "Sweaters";
      case TopWear.jackets:
        return "Jackets";
      case TopWear.coats:
        return "Coats";
      case TopWear.others:
        return "Others";
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
        return "Cargo Pants";
      case BottomWear.joggers:
        return "Joggers";
      case BottomWear.others:
        return "Others";
    }
  }
}

extension FootwearExtension on Footwear {
  String get name {
    switch (this) {
      case Footwear.sports:
        return "Sports Shoes";
      case Footwear.sneakers:
        return "Sneakers";
      case Footwear.boots:
        return "Boots";
      case Footwear.sandals:
        return "Sandals";
      case Footwear.loafers:
        return "Loafers";
      case Footwear.flipFlops:
        return "Flip Flops";
      case Footwear.heels:
        return "Heels";
      case Footwear.flats:
        return "Flats";
      case Footwear.others:
        return "Others";
    }
  }
}