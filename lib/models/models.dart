// ─── Millet Types ────────────────────────────────────────────────────────────

enum MilletType {
  navane('Navane', 'Foxtail Millet', '🌾'),
  sajje('Sajje', 'Pearl Millet', '🌿'),
  baragu('Baragu', 'Sorghum', '🌱'),
  ragi('Ragi', 'Finger Millet', '🍂'),
  oodalu('Oodalu', 'Barnyard Millet', '🌾'),
  saame('Saame', 'Little Millet', '🌿');

  final String kannadaName;
  final String englishName;
  final String emoji;

  const MilletType(this.kannadaName, this.englishName, this.emoji);
}

// ─── Millet Price ─────────────────────────────────────────────────────────────

class MilletPrice {
  final MilletType millet;
  final String city;
  final double currentPrice; // ₹ per kg
  final List<double> last7Days; // price history
  final DateTime updatedAt;

  const MilletPrice({
    required this.millet,
    required this.city,
    required this.currentPrice,
    required this.last7Days,
    required this.updatedAt,
  });

  double get high7 => last7Days.reduce((a, b) => a > b ? a : b);
  double get low7 => last7Days.reduce((a, b) => a < b ? a : b);
  double get change => currentPrice - last7Days[last7Days.length - 2];
  double get changePercent => (change / last7Days[last7Days.length - 2]) * 100;
  bool get isUp => change >= 0;
}

// ─── Sample Mandi Data ────────────────────────────────────────────────────────

class MandiData {
  static const List<String> cities = [
    'Bengaluru',
    'Davangere',
    'Mysuru',
    'Hubli',
    'Shivamogga'
  ];

  static List<MilletPrice> getPrices(String city) => [
        MilletPrice(
          millet: MilletType.navane,
          city: city,
          currentPrice: 38.5,
          last7Days: [34.0, 35.5, 36.0, 37.0, 36.5, 37.8, 38.5],
          updatedAt: DateTime.now(),
        ),
        MilletPrice(
          millet: MilletType.sajje,
          city: city,
          currentPrice: 28.0,
          last7Days: [30.0, 29.5, 29.0, 28.5, 27.0, 28.2, 28.0],
          updatedAt: DateTime.now(),
        ),
        MilletPrice(
          millet: MilletType.baragu,
          city: city,
          currentPrice: 22.5,
          last7Days: [20.0, 21.0, 21.5, 22.0, 22.5, 22.0, 22.5],
          updatedAt: DateTime.now(),
        ),
        MilletPrice(
          millet: MilletType.ragi,
          city: city,
          currentPrice: 45.0,
          last7Days: [42.0, 43.0, 44.5, 44.0, 43.5, 44.8, 45.0],
          updatedAt: DateTime.now(),
        ),
        MilletPrice(
          millet: MilletType.oodalu,
          city: city,
          currentPrice: 32.0,
          last7Days: [33.5, 33.0, 32.5, 32.0, 31.5, 32.0, 32.0],
          updatedAt: DateTime.now(),
        ),
        MilletPrice(
          millet: MilletType.saame,
          city: city,
          currentPrice: 55.0,
          last7Days: [50.0, 51.5, 52.0, 53.0, 54.0, 54.5, 55.0],
          updatedAt: DateTime.now(),
        ),
      ];
}

// ─── Recipe ───────────────────────────────────────────────────────────────────

class Recipe {
  final String id;
  final String title;
  final String titleKannada;
  final MilletType milletType;
  final int cookTimeMinutes;
  final int servings;
  final String difficulty; // Easy / Medium / Hard
  final String description;
  final List<String> ingredients;
  final List<String> steps;
  final List<String> healthTags;
  final String imageEmoji;
  bool isSaved;

  Recipe({
    required this.id,
    required this.title,
    required this.titleKannada,
    required this.milletType,
    required this.cookTimeMinutes,
    required this.servings,
    required this.difficulty,
    required this.description,
    required this.ingredients,
    required this.steps,
    required this.healthTags,
    required this.imageEmoji,
    this.isSaved = false,
  });
}

// ─── Sample Recipes ───────────────────────────────────────────────────────────

class RecipeData {
  static List<Recipe> all = [
    Recipe(
      id: '1',
      title: 'Navane Dosa',
      titleKannada: 'ನವಣೆ ದೋಸೆ',
      milletType: MilletType.navane,
      cookTimeMinutes: 20,
      servings: 4,
      difficulty: 'Easy',
      description:
          'Crispy foxtail millet dosa — a healthy twist on the classic Karnataka breakfast.',
      ingredients: [
        '2 cups Navane (Foxtail Millet)',
        '½ cup Urad Dal',
        '1 tsp Fenugreek seeds',
        'Salt to taste',
        'Oil for cooking',
      ],
      steps: [
        'Soak navane, urad dal, and fenugreek for 6–8 hours.',
        'Grind to a smooth batter; ferment overnight.',
        'Add salt and mix well. Heat tawa on medium flame.',
        'Pour a ladle of batter, spread in circles.',
        'Drizzle oil, cook till golden. Flip and cook 30 sec.',
        'Serve with coconut chutney and sambar.',
      ],
      healthTags: ['Diabetic Friendly', 'High Fibre', 'Low GI'],
      imageEmoji: '🫓',
    ),
    Recipe(
      id: '2',
      title: 'Ragi Mudde',
      titleKannada: 'ರಾಗಿ ಮುದ್ದೆ',
      milletType: MilletType.ragi,
      cookTimeMinutes: 15,
      servings: 2,
      difficulty: 'Medium',
      description:
          'The iconic Karnataka finger millet balls — a protein-rich staple food.',
      ingredients: [
        '1 cup Ragi flour',
        '1½ cups Water',
        '½ tsp Salt',
        '1 tsp Ghee',
      ],
      steps: [
        'Boil water with salt in a heavy-bottomed pan.',
        'Reduce flame; add ragi flour slowly, stirring continuously.',
        'Mix vigorously to avoid lumps. Cover and cook 5 min.',
        'Add ghee; shape into smooth balls while hot.',
        'Serve hot with raagi soppu saaru or chicken curry.',
      ],
      healthTags: ['Iron Rich', 'Calcium Rich', 'Gluten Free'],
      imageEmoji: '🟤',
    ),
    Recipe(
      id: '3',
      title: 'Sajje Roti',
      titleKannada: 'ಸಜ್ಜೆ ರೊಟ್ಟಿ',
      milletType: MilletType.sajje,
      cookTimeMinutes: 25,
      servings: 3,
      difficulty: 'Easy',
      description:
          'Pearl millet flatbread — earthy, wholesome, and full of rural Karnataka character.',
      ingredients: [
        '2 cups Sajje (Pearl Millet) flour',
        'Warm water as needed',
        '½ tsp Salt',
        '1 tbsp Sesame seeds',
        'Ghee to serve',
      ],
      steps: [
        'Mix flour, salt, sesame seeds in a bowl.',
        'Add warm water gradually; knead to soft dough.',
        'Divide into equal balls. Pat flat on a damp cloth.',
        'Transfer to hot tawa; cook on medium heat.',
        'Cook both sides till brown spots appear.',
        'Smear with ghee; serve with peanut chutney.',
      ],
      healthTags: ['Vegan', 'High Protein', 'Iron Rich'],
      imageEmoji: '🫔',
    ),
    Recipe(
      id: '4',
      title: 'Baragu Upma',
      titleKannada: 'ಬರಗು ಉಪ್ಮ',
      milletType: MilletType.baragu,
      cookTimeMinutes: 30,
      servings: 3,
      difficulty: 'Easy',
      description:
          'Sorghum upma — a nutritious, filling breakfast that keeps you energised all morning.',
      ingredients: [
        '1 cup Baragu (Sorghum), soaked overnight',
        '1 Onion, finely chopped',
        '2 Green chillies',
        '1 tsp Mustard seeds',
        '½ tsp Turmeric',
        'Curry leaves, Coriander',
        'Salt, Oil',
      ],
      steps: [
        'Pressure cook soaked baragu for 3 whistles. Drain.',
        'Heat oil; add mustard, curry leaves, green chillies.',
        'Sauté onions till translucent.',
        'Add cooked baragu, turmeric, salt; mix well.',
        'Cook on low flame for 5 min; garnish with coriander.',
        'Serve hot with lemon juice squeezed on top.',
      ],
      healthTags: ['Diabetic Friendly', 'Heart Healthy', 'High Fibre'],
      imageEmoji: '🥣',
    ),
    Recipe(
      id: '5',
      title: 'Saame Pongal',
      titleKannada: 'ಸಾಮೆ ಪೊಂಗಲ್',
      milletType: MilletType.saame,
      cookTimeMinutes: 20,
      servings: 4,
      difficulty: 'Easy',
      description:
          'Little millet khara pongal — a festive and comforting one-pot meal.',
      ingredients: [
        '1 cup Saame (Little Millet)',
        '¼ cup Moong Dal',
        '1 tsp Cumin seeds',
        '1 tsp Black pepper',
        '2 tbsp Ghee',
        'Cashews, Ginger',
        'Salt, Curry leaves',
      ],
      steps: [
        'Dry roast saame and moong dal for 2 min.',
        'Pressure cook with 3 cups water and salt (2 whistles).',
        'Heat ghee; fry cashews, cumin, pepper, ginger, curry leaves.',
        'Add tempering to cooked millet; mix gently.',
        'Adjust consistency with hot water if needed.',
        'Serve hot with coconut chutney and sambar.',
      ],
      healthTags: ['Gluten Free', 'Weight Loss', 'Low GI'],
      imageEmoji: '🍚',
    ),
  ];
}

// ─── Health Fact ──────────────────────────────────────────────────────────────

class HealthFact {
  final MilletType millet;
  final String headline;
  final String body;
  final List<String> nutrients;
  final List<String> benefits;
  final String emoji;

  const HealthFact({
    required this.millet,
    required this.headline,
    required this.body,
    required this.nutrients,
    required this.benefits,
    required this.emoji,
  });
}

class HealthData {
  static const List<HealthFact> facts = [
    HealthFact(
      millet: MilletType.navane,
      headline: 'Navane Controls Blood Sugar',
      body: 'Foxtail millet has a very low Glycemic Index (31). '
          'It releases glucose slowly, preventing sugar spikes — '
          'making it the ideal grain for people with Type 2 Diabetes.',
      nutrients: [
        'Low GI (31)',
        '12.3g Protein/100g',
        '8g Fibre/100g',
        'Rich in Zinc & B-vitamins'
      ],
      benefits: [
        'Controls Blood Sugar',
        'Aids Weight Management',
        'Boosts Immunity',
        'Heart Health'
      ],
      emoji: '🌾',
    ),
    HealthFact(
      millet: MilletType.ragi,
      headline: 'Ragi — Nature\'s Calcium Bank',
      body: 'Finger millet has 10× more calcium than rice. '
          'It strengthens bones, prevents osteoporosis, and is '
          'ideal for growing children and lactating mothers.',
      nutrients: [
        '344mg Calcium/100g',
        '7.3g Protein/100g',
        '3.6g Fibre/100g',
        'Rich in Iron & Amino Acids'
      ],
      benefits: [
        'Strong Bones & Teeth',
        'Prevents Anaemia',
        'Gluten Free',
        'Reduces Anxiety'
      ],
      emoji: '🍂',
    ),
    HealthFact(
      millet: MilletType.sajje,
      headline: 'Sajje Powers Your Energy',
      body: 'Pearl millet is packed with iron and protein. '
          'It combats anaemia, provides sustained energy, '
          'and is a powerful superfood for physical workers and athletes.',
      nutrients: [
        '8mg Iron/100g',
        '10.6g Protein/100g',
        'High in Magnesium',
        'B6, Folate, Niacin'
      ],
      benefits: [
        'Prevents Anaemia',
        'Sustained Energy',
        'Muscle Health',
        'Reduces Cholesterol'
      ],
      emoji: '🌿',
    ),
    HealthFact(
      millet: MilletType.baragu,
      headline: 'Baragu — Heart-Healthy Grain',
      body: 'Sorghum is rich in antioxidants and heart-protective '
          'compounds. It requires 70% less water than paddy, '
          'making it the most climate-resilient crop in Karnataka.',
      nutrients: [
        'High Antioxidants',
        '11g Protein/100g',
        '6.7g Fibre/100g',
        'Phosphorus, Potassium'
      ],
      benefits: [
        'Protects Heart',
        'Anti-Cancer Properties',
        'Gluten Free',
        'Climate Resilient'
      ],
      emoji: '🌱',
    ),
    HealthFact(
      millet: MilletType.saame,
      headline: 'Saame for Weight Management',
      body: 'Little millet is one of the lightest and most digestible '
          'grains. Its high fibre and low calorie count makes it '
          'a perfect choice for healthy weight loss diets.',
      nutrients: [
        'Low Calorie',
        '7.7g Protein/100g',
        'High Fibre',
        'B-vitamins, Magnesium'
      ],
      benefits: [
        'Weight Loss Aid',
        'Easy Digestion',
        'Detox Properties',
        'Liver Health'
      ],
      emoji: '🌾',
    ),
  ];
}

// ─── FPO / Direct Buy ─────────────────────────────────────────────────────────

class FpoOrg {
  final String name;
  final String district;
  final String contact;
  final List<MilletType> availableMillets;
  final double rating;
  final int membersCount;
  final String description;

  const FpoOrg({
    required this.name,
    required this.district,
    required this.contact,
    required this.availableMillets,
    required this.rating,
    required this.membersCount,
    required this.description,
  });
}

class FpoData {
  static const List<FpoOrg> orgs = [
    FpoOrg(
      name: 'Davanagere Millet Farmers Cooperative',
      district: 'Davangere',
      contact: '+91 98765 43210',
      availableMillets: [
        MilletType.navane,
        MilletType.sajje,
        MilletType.baragu
      ],
      rating: 4.5,
      membersCount: 320,
      description:
          'Established in 2018, supplying certified organic millets directly from 320+ small farmers.',
    ),
    FpoOrg(
      name: 'Shivamogga Siri Dhanya FPO',
      district: 'Shivamogga',
      contact: '+91 97654 32109',
      availableMillets: [MilletType.ragi, MilletType.saame, MilletType.oodalu],
      rating: 4.8,
      membersCount: 215,
      description:
          'Specialising in rare minor millets. Award-winning FPO with direct farm-to-consumer delivery.',
    ),
    FpoOrg(
      name: 'Bidar Millets Producer Organisation',
      district: 'Bidar',
      contact: '+91 99887 76655',
      availableMillets: [MilletType.sajje, MilletType.baragu],
      rating: 4.2,
      membersCount: 180,
      description:
          'Northern Karnataka\'s largest millet FPO, known for pearl and sorghum varieties.',
    ),
    FpoOrg(
      name: 'Tumkur Green Grains Collective',
      district: 'Tumkur',
      contact: '+91 88776 65544',
      availableMillets: [MilletType.navane, MilletType.ragi],
      rating: 4.6,
      membersCount: 275,
      description:
          'Foxtail and finger millet specialists with ISO-certified processing unit.',
    ),
  ];
}
