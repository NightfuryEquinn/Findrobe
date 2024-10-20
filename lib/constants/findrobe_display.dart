class FindrobeDisplay {
  final String name;
  final String punchline;
  final String image;

  FindrobeDisplay({
    required this.name,
    required this.punchline,
    required this.image
  });
}

enum TopWearList {
  tShirt(
    name: "T-Shirts",
    punchline: "Effortless comfort, everyday.",
    image: "assets/clothings/tshirt.png",
  ),
  shirt(
    name: "Shirts",
    punchline: "Sharp and polished for any occasion.",
    image: "assets/clothings/shirt.png",
  ),
  blouse(
    name: "Blouses",
    punchline: "Elegance meets versatility.",
    image: "assets/clothings/blouse.png",
  ),
  tankTop(
    name: "Tank Tops",
    punchline: "Stay cool and casual all day.",
    image: "assets/clothings/tank_top.png",
  ),
  hoodie(
    name: "Hoodies",
    punchline: "Cozy comfort in every layer.",
    image: "assets/clothings/hoodie.png",
  ),
  sweater(
    name: "Sweaters",
    punchline: "Snuggle up with timeless warmth.",
    image: "assets/clothings/sweater.png",
  ),
  jacket(
    name: "Jackets",
    punchline: "Layer up in style and substance.",
    image: "assets/clothings/jacket.png",
  ),
  coat(
    name: "Coats",
    punchline: "Keep the chill out with chic outerwear.",
    image: "assets/clothings/coat.png",
  );

  final String name;
  final String punchline;
  final String image;

  const TopWearList({
    required this.name,
    required this.punchline,
    required this.image
  });
}

enum BottomWearList {
  jeans(
    name: "Jeans",
    punchline: "A classic that never goes out of style.",
    image: "assets/clothings/jeans.png",
  ),
  trousers(
    name: "Trousers",
    punchline: "Tailored fit for sharp looks.",
    image: "assets/clothings/trousers.png",
  ),
  leggings(
    name: "Leggings",
    punchline: "Comfort that moves with you.",
    image: "assets/clothings/leggings.png",
  ),
  shorts(
    name: "Shorts",
    punchline: "Breeze through the day in style.",
    image: "assets/clothings/shorts.png",
  ),
  skirt(
    name: "Skirts",
    punchline: "Feminine flair, effortless grace.",
    image: "assets/clothings/skirt.png",
  ),
  cargoPants(
    name: "Cargo Pants",
    punchline: "Utility meets everyday comfort.",
    image: "assets/clothings/cargo_pants.png",
  ),
  joggers(
    name: "Joggers",
    punchline: "Athleisure for the active you.",
    image: "assets/clothings/joggers.png",
  );

  final String name;
  final String punchline;
  final String image;

  const BottomWearList({
    required this.name,
    required this.punchline,
    required this.image
  });
}

enum FootwearList {
  sportsShoes(
    name: "Sports Shoes",
    punchline: "Perform your best with every step.",
    image: "assets/clothings/sports_shoes.png",
  ),
  sneakers(
    name: "Sneakers",
    punchline: "Casual comfort, wherever you go.",
    image: "assets/clothings/sneakers.png",
  ),
  boots(
    name: "Boots",
    punchline: "Bold and rugged for any terrain.",
    image: "assets/clothings/boots.png",
  ),
  sandals(
    name: "Sandals",
    punchline: "Easy-breezy style for sunny days.",
    image: "assets/clothings/sandals.png",
  ),
  loafers(
    name: "Loafers",
    punchline: "Slip into sleek sophistication.",
    image: "assets/clothings/loafers.png",
  ),
  flipFlops(
    name: "Flip-Flops",
    punchline: "Relaxed and ready for the beach.",
    image: "assets/clothings/flip_flops.png",
  ),
  heels(
    name: "Heels",
    punchline: "Elevate your elegance with ease.",
    image: "assets/clothings/heels.png",
  ),
  flats(
    name: "Flats",
    punchline: "All-day comfort, endless style.",
    image: "assets/clothings/flats.png",
  );

  final String name;
  final String punchline;
  final String image;

  const FootwearList({
    required this.name,
    required this.punchline,
    required this.image
  });
}