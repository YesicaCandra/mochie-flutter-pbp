import 'package:flutter/material.dart';

import '../app_data.dart';
import '../models/mochi.dart';
import '../theme/app_theme.dart';
import '../widgets/app_snackbar.dart';
import '../widgets/mochi_image.dart';
import '../widgets/responsive.dart';
import 'cart_page.dart';
import 'favorite_page.dart';
import 'mochi_detail_page.dart';
import 'profile_page.dart';

final List<Mochi> mochiData = [
  Mochi(
    name: 'Mochi Strawberry',
    description: 'Mochi lembut dengan isian strawberry yang manis dan segar.',
    detailDescription: 'Mochi Strawberry dibuat dengan kulit mochi yang lembut dan kenyal, dipadukan dengan isian strawberry yang manis dan segar. Cocok dinikmati sebagai camilan manis kapan saja.',
    price: 'Rp12.000',
    rating: 4.8,
    image: 'assets/images/mochi strawberry.jpeg',
  ),

  Mochi(
    name: 'Mochi Matcha',
    description: 'Mochi dengan rasa matcha yang lembut dan sedikit pahit.',
    detailDescription: 'Mochi Matcha memiliki tekstur lembut dengan perpaduan rasa matcha yang khas, creamy, dan sedikit pahit sehingga memberikan rasa yang seimbang.',
    price: 'Rp13.000',
    rating: 4.7,
    image: 'assets/images/mochi matcha.webp',
  ),

  Mochi(
    name: 'Mochi Chocolate',
    description: 'Mochi dengan isian cokelat creamy yang manis.',
    detailDescription: 'Mochi Chocolate menghadirkan perpaduan kulit mochi yang lembut dengan isian cokelat creamy yang manis dan cocok untuk pecinta cokelat.',
    price: 'Rp12.000',
    rating: 4.9,
    image: 'assets/images/mochi chocolate.jpg',
  ),

  Mochi(
    name: 'Mochi Taro',
    description: 'Mochi lembut dengan rasa taro yang creamy dan harum.',
    detailDescription: 'Mochi Taro memiliki rasa taro yang lembut, creamy, dan harum dengan tekstur mochi yang kenyal.',
    price: 'Rp13.000',
    rating: 4.8,
    image: 'assets/images/mochi taro.jpg',
  ),

  Mochi(
    name: 'Mochi Mango',
    description: 'Perpaduan mochi lembut dengan rasa mangga yang segar.',
    detailDescription: 'Mochi Mango memiliki rasa mangga yang manis dan segar dengan tekstur mochi yang lembut dan kenyal.',
    price: 'Rp12.000',
    rating: 4.7,
    image: 'assets/images/mochi mango.jpg',
  ),

  Mochi(
    name: 'Mochi Red Velvet',
    description: 'Mochi dengan cita rasa red velvet yang lembut dan creamy.',
    detailDescription: 'Mochi Red Velvet menawarkan rasa red velvet yang lembut dan creamy dengan tekstur mochi yang kenyal.',
    price: 'Rp14.000',
    rating: 4.9,
    image: 'assets/images/mochi red velvet.jpg',
  ),

  Mochi(
    name: 'Mochi Pistachio',
    description: 'Mochi lembut dengan isian pistachio yang gurih dan creamy.',
    detailDescription: 'Mochi Pistachio menghadirkan kulit mochi yang lembut dengan cita rasa kacang pistachio yang khas, gurih, dan creamy.',
    price: 'Rp15.000',
    rating: 4.9,
    image: 'assets/images/mochi pistachio.jpg',
  ),

  Mochi(
    name: 'Mochi Durian',
    description: 'Mochi lembut dengan isian durian yang khas dan creamy.',
    detailDescription: 'Mochi Durian memadukan kulit mochi yang kenyal dengan isian durian yang lembut dan memiliki aroma khas.',
    price: 'Rp15.000',
    rating: 4.8,
    image: 'assets/images/mochi durian.jpg',
  ),

  Mochi(
    name: 'Mochi Blueberry',
    description:
        'Mochi dengan perpaduan blueberry yang manis dan sedikit asam.',
    detailDescription: 'Mochi Blueberry menawarkan perpaduan kulit mochi yang lembut dengan rasa blueberry yang manis dan sedikit asam.',
    price: 'Rp14.000',
    rating: 4.8,
    image: 'assets/images/mochi blueberry.webp',
  ),

  Mochi(
    name: 'Mochi Cookies & Cream',
    description: 'Mochi creamy dengan perpaduan krim dan biskuit cokelat.',
    detailDescription: 'Mochi Cookies & Cream memadukan kulit mochi yang kenyal dengan isian krim lembut dan cita rasa biskuit cokelat.',
    price: 'Rp14.000',
    rating: 4.9,
    image: 'assets/images/mochi cookies & cream.jpeg',
  ),

  Mochi(
    name: 'Mochi Dubai Chewy',
    description: 'Mochi dengan sensasi cokelat dan pistachio yang istimewa.',
    detailDescription: 'Mochi Dubai Chewy terinspirasi dari perpaduan cokelat dan pistachio dengan tekstur mochi yang lembut dan kenyal.',
    price: 'Rp18.000',
    rating: 4.9,
    image: 'assets/images/mochi dubai chewy.jpg',
  ),

  Mochi(
    name: 'Mochi Mint Chocolate',
    description: 'Perpaduan rasa mint yang segar dengan cokelat.',
    detailDescription: 'Mochi Mint Chocolate memadukan sensasi mint yang menyegarkan dengan rasa cokelat yang kaya dalam balutan kulit mochi yang kenyal.',
    price: 'Rp15.000',
    rating: 4.8,
    image: 'assets/images/mochi mint chocolate.jpg',
  ),

  Mochi(
    name: 'Mochi Caramel',
    description: 'Mochi manis dengan sentuhan karamel yang lembut.',
    detailDescription: 'Mochi Caramel menawarkan rasa karamel yang manis dengan tekstur lembut dan kenyal untuk menemani waktu santai.',
    price: 'Rp14.000',
    rating: 4.7,
    image: 'assets/images/mochi caramel.jpg',
  ),

  Mochi(
    name: 'Mochi Tiramisu',
    description: 'Mochi dengan cita rasa kopi dan krim ala tiramisu.',
    detailDescription: 'Mochi Tiramisu menghadirkan perpaduan cita rasa kopi dan krim yang lembut dalam kulit mochi yang kenyal.',
    price: 'Rp15.000',
    rating: 4.9,
    image: 'assets/images/mochi tiramisu.jpg',
  ),

  Mochi(
    name: 'Mochi Vanilla',
    description: 'Mochi lembut dengan rasa vanilla yang manis dan harum.',
    detailDescription: 'Mochi Vanilla memiliki cita rasa vanilla yang lembut dan harum, cocok untuk pencinta camilan manis dengan rasa klasik.',
    price: 'Rp13.000',
    rating: 4.7,
    image: 'assets/images/mochi vanilla.jpg',
  ),
];

// Gaya teks judul (Fredoka).
TextStyle _displayStyle(
  double size, {
  Color color = AppTheme.cocoa,
  double? height,
}) {
  return TextStyle(
    fontFamily: AppTheme.fontDisplay,
    fontSize: size,
    fontWeight: FontWeight.w600,
    color: color,
    height: height,
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  String _searchQuery = '';
  String _selectedFilter = 'Semua';
  String _selectedSort = 'Default';

  final TextEditingController _searchController = TextEditingController();

  final List<String> _filters = [
    'Semua',
    'Strawberry',
    'Matcha',
    'Chocolate',
    'Taro',
    'Mango',
    'Red Velvet',
    'Pistachio',
    'Durian',
    'Blueberry',
    'Cookies & Cream',
    'Dubai Chewy',
    'Mint Chocolate',
    'Caramel',
    'Tiramisu',
    'Vanilla',
  ];

  double _getPrice(String price) {
    final number = price
        .replaceAll('Rp', '')
        .replaceAll('.', '')
        .replaceAll(',', '')
        .trim();

    return double.tryParse(number) ?? 0;
  }

  String _sortLabel() {
    switch (_selectedSort) {
      case 'Rating tertinggi':
        return 'Rating ↑';
      case 'Harga termahal':
        return 'Harga ↑';
      case 'Harga termurah':
        return 'Harga ↓';
      default:
        return 'Filter';
    }
  }

  List<Mochi> get _filteredMochi {
    List<Mochi> result = List<Mochi>.from(mochiData);

    // SEARCH
    if (_searchQuery.isNotEmpty) {
      result = result.where((mochi) {
        final name = mochi.name.toLowerCase();
        final description = mochi.description.toLowerCase();
        final query = _searchQuery.toLowerCase();

        return name.contains(query) || description.contains(query);
      }).toList();
    }

    // PILIHAN RASA
    if (_selectedFilter != 'Semua') {
      result = result.where((mochi) {
        final name = mochi.name.toLowerCase();

        return name.contains(_selectedFilter.toLowerCase());
      }).toList();
    }

    // SORT / URUTKAN
    if (_selectedSort == 'Rating tertinggi') {
      result.sort((a, b) => b.rating.compareTo(a.rating));
    }

    if (_selectedSort == 'Harga termahal') {
      result.sort((a, b) => _getPrice(a.price).compareTo(_getPrice(b.price)));

      result = result.reversed.toList();
    }

    if (_selectedSort == 'Harga termurah') {
      result.sort((a, b) => _getPrice(a.price).compareTo(_getPrice(b.price)));
    }

    return result;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onNavigationTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // ===========================================================
  // TOMBOL KERANJANG (dengan badge jumlah)
  // ===========================================================

  Widget _buildCartButton() {
    return ValueListenableBuilder<List<Map<String, dynamic>>>(
      valueListenable: AppData.cart,
      builder: (context, cart, child) {
        final totalQuantity = cart.fold<int>(
          0,
          (sum, item) => sum + ((item['quantity'] ?? 1) as int),
        );

        return Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.cocoa.withValues(alpha: 0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: IconButton(
                tooltip: 'Keranjang',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartPage()),
                  );
                },
                icon: const Icon(
                  Icons.shopping_bag_outlined,
                  color: AppTheme.cocoa,
                ),
              ),
            ),

            if (totalQuantity > 0)
              Positioned(
                right: -5,
                top: -5,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  constraints: const BoxConstraints(
                    minWidth: 20,
                    minHeight: 20,
                  ),
                  decoration: const BoxDecoration(
                    color: AppTheme.primaryDeep,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    totalQuantity > 9 ? '9+' : '$totalQuantity',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppTheme.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  // ===========================================================
  // SAPAAN
  // ===========================================================

  Widget _buildGreeting(bool isRow) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello, Mochi Lover!',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppTheme.cocoa.withValues(alpha: 0.8),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          'Temukan Mochi Favoritmu',
          style: _displayStyle(isRow ? 28 : 24, height: 1.15),
        ),
      ],
    );
  }

  // ===========================================================
  // KOTAK PENCARIAN
  // ===========================================================

  Widget _buildSearchField() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppTheme.cocoa.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
        style: const TextStyle(
          color: AppTheme.cocoa,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
        decoration: InputDecoration(
          hintText: 'Cari mochi favoritmu...',
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: AppTheme.primaryDeep,
            size: 22,
          ),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  tooltip: 'Hapus pencarian',
                  onPressed: () {
                    _searchController.clear();

                    setState(() {
                      _searchQuery = '';
                    });
                  },
                  icon: const Icon(Icons.close_rounded, color: AppTheme.cocoa),
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: AppTheme.primary, width: 1.5),
          ),
        ),
      ),
    );
  }

  // ===========================================================
  // BANNER PROMO
  // ===========================================================

  Widget _buildPromoBanner(bool isRow) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: isRow ? 132 : 128),
      padding: EdgeInsets.symmetric(horizontal: isRow ? 32 : 18, vertical: 18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppTheme.primaryDeep, AppTheme.primary],
        ),
        borderRadius: BorderRadius.circular(isRow ? 28 : 26),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withValues(alpha: 0.25),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.yellow,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'MOCHIÉ SPECIAL',
                    style: TextStyle(
                      color: AppTheme.cocoa,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  isRow
                      ? 'Sweet moments, one bite away'
                      : 'Sweet moments,\none bite away',
                  style: _displayStyle(
                    isRow ? 28 : 22,
                    color: AppTheme.white,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // Dua bola mochi dekoratif
          SizedBox(
            width: isRow ? 130 : 108,
            height: isRow ? 92 : 72,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: _MochiBall(
                    size: isRow ? 92 : 70,
                    color: AppTheme.peach,
                  ),
                ),
                Positioned(
                  left: isRow ? 66 : 52,
                  bottom: 0,
                  child: _MochiBall(
                    size: isRow ? 70 : 56,
                    color: AppTheme.yellow,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // CHIP PILIHAN RASA
  // Layar lebar: dibungkus (wrap) agar mudah diklik dengan mouse.
  // Layar sempit: daftar horizontal yang bisa digeser.
  // ===========================================================

  Widget _buildChip(String filter) {
    final isSelected = _selectedFilter == filter;

    return ChoiceChip(
      label: Text(filter),
      selected: isSelected,
      onSelected: (_) {
        setState(() {
          _selectedFilter = filter;
        });
      },
      labelStyle: TextStyle(
        color: isSelected ? AppTheme.white : AppTheme.cocoa,
        fontWeight: FontWeight.w800,
        fontSize: 13,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      backgroundColor: AppTheme.white,
      selectedColor: AppTheme.primaryDeep,
      side: BorderSide(
        color: isSelected ? AppTheme.primaryDeep : AppTheme.dustyRose,
        width: 1.5,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      showCheckmark: false,
    );
  }

  Widget _buildFilterChips(bool isRow, double hPad) {
    if (isRow) {
      return Padding(
        padding: EdgeInsets.fromLTRB(hPad, 16, hPad, 0),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _filters.map(_buildChip).toList(),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: SizedBox(
        height: 42,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: hPad),
          scrollDirection: Axis.horizontal,
          itemCount: _filters.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: _buildChip(_filters[index]),
            );
          },
        ),
      ),
    );
  }

  // ===========================================================
  // JUDUL "VARIAN MOCHI" + FILTER/SORT
  // ===========================================================

  PopupMenuItem<String> _sortItem(String value, IconData icon, Color color) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(icon, size: 19, color: color),
          const SizedBox(width: 10),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(double hPad) {
    final isSortActive = _selectedSort != 'Default';

    return Padding(
      padding: EdgeInsets.fromLTRB(hPad, 18, hPad, 12),
      child: Row(
        children: [
          Text('Varian Mochi', style: _displayStyle(20)),

          const Spacer(),

          PopupMenuButton<String>(
            initialValue: _selectedSort,
            onSelected: (value) {
              setState(() {
                _selectedSort = value;
              });
            },
            itemBuilder: (context) {
              return [
                _sortItem('Default', Icons.grid_view_rounded, AppTheme.cocoa),
                _sortItem(
                  'Rating tertinggi',
                  Icons.star_rounded,
                  AppTheme.primaryDeep,
                ),
                _sortItem(
                  'Harga termahal',
                  Icons.arrow_upward_rounded,
                  AppTheme.cocoa,
                ),
                _sortItem(
                  'Harga termurah',
                  Icons.arrow_downward_rounded,
                  AppTheme.cocoa,
                ),
              ];
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: isSortActive ? AppTheme.softPink : AppTheme.white,
                borderRadius: BorderRadius.circular(13),
                border: Border.all(
                  color: isSortActive ? AppTheme.primary : AppTheme.dustyRose,
                  width: 1.5,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _sortLabel(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.cocoa,
                    ),
                  ),
                  const SizedBox(width: 2),
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 18,
                    color: AppTheme.cocoa,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // KONTEN HOME
  // ===========================================================

  Widget _buildHomeContent() {
    // Dihitung sekali per build.
    final mochiList = _filteredMochi;

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final isRow = width >= Breakpoints.medium;
          final useGrid = width >= Breakpoints.grid;
          final hPad = isRow ? 32.0 : 20.0;

          return Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: Breakpoints.maxContent,
              ),
              child: CustomScrollView(
                slivers: [
                  // HEADER
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(hPad, 18, hPad, 0),
                      child: isRow
                          ? Row(
                              children: [
                                ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxWidth: 300,
                                  ),
                                  child: _buildGreeting(true),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: ConstrainedBox(
                                      constraints: const BoxConstraints(
                                        maxWidth: 420,
                                      ),
                                      child: _buildSearchField(),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                _buildCartButton(),
                              ],
                            )
                          : Row(
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: ConstrainedBox(
                                      constraints: const BoxConstraints(
                                        maxWidth: 240,
                                      ),
                                      child: _buildGreeting(false),
                                    ),
                                  ),
                                ),
                                _buildCartButton(),
                              ],
                            ),
                    ),
                  ),

                  // PENCARIAN (layar sempit)
                  if (!isRow)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(hPad, 16, hPad, 0),
                        child: _buildSearchField(),
                      ),
                    ),

                  // BANNER
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(hPad, 16, hPad, 0),
                      child: _buildPromoBanner(isRow),
                    ),
                  ),

                  // CHIP RASA
                  SliverToBoxAdapter(child: _buildFilterChips(isRow, hPad)),

                  // JUDUL + SORT
                  SliverToBoxAdapter(child: _buildSectionHeader(hPad)),

                  // DAFTAR PRODUK
                  if (mochiList.isEmpty)
                    SliverToBoxAdapter(child: _buildEmptyResult())
                  else if (useGrid)
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(hPad, 0, hPad, 30),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 380,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              mainAxisExtent: 310,
                            ),
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final mochi = mochiList[index];

                          return AnimatedMochiCard(
                            index: index,
                            child: _buildGridCard(context, mochi),
                          );
                        }, childCount: mochiList.length),
                      ),
                    )
                  else
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(hPad, 0, hPad, 30),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final mochi = mochiList[index];

                          return AnimatedMochiCard(
                            index: index,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _buildPolishedCard(context, mochi),
                            ),
                          );
                        }, childCount: mochiList.length),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyResult() {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: const BoxDecoration(
              color: AppTheme.softPink,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.search_off_rounded,
              size: 44,
              color: AppTheme.primary,
            ),
          ),

          const SizedBox(height: 16),

          Text('Mochi tidak ditemukan', style: _displayStyle(20)),

          const SizedBox(height: 6),

          Text(
            'Coba gunakan kata kunci atau filter lain.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppTheme.cocoa.withValues(alpha: 0.75)),
          ),

          const SizedBox(height: 18),

          TextButton(
            onPressed: () {
              _searchController.clear();

              setState(() {
                _searchQuery = '';
                _selectedFilter = 'Semua';
                _selectedSort = 'Default';
              });
            },
            child: const Text('RESET PENCARIAN'),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // BAGIAN KARTU YANG DIPAKAI BERSAMA
  // ===========================================================

  void _openDetail(BuildContext context, Mochi mochi) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            MochiDetailPage(mochi: mochi),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 0.08);
          const end = Offset.zero;

          final slideAnimation = Tween<Offset>(begin: begin, end: end).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
          );

          final fadeAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          );

          return FadeTransition(
            opacity: fadeAnimation,
            child: SlideTransition(position: slideAnimation, child: child),
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: AppTheme.white,
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: AppTheme.cocoa.withValues(alpha: 0.07),
          blurRadius: 18,
          offset: const Offset(0, 7),
        ),
      ],
    );
  }

  // Tombol hati. Ikut berubah saat favorit diubah dari halaman lain.
  Widget _buildFavoriteButton(Mochi mochi) {
    return ValueListenableBuilder<List<Map<String, dynamic>>>(
      valueListenable: AppData.favorites,
      builder: (context, favorites, child) {
        return AnimatedFavoriteButton(
          isFavorite: AppData.isFavorite(mochi.name),
          onPressed: () {
            AppData.toggleFavorite(mochi.toMap());
          },
        );
      },
    );
  }

  Widget _buildRatingPill(double rating) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppTheme.yellow,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star_rounded, size: 13, color: AppTheme.cocoa),
          const SizedBox(width: 3),
          Text(
            rating.toString(),
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: AppTheme.cocoa,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailButton(BuildContext context, Mochi mochi) {
    return SizedBox(
      height: 36,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MochiDetailPage(mochi: mochi),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.softPink,
          foregroundColor: AppTheme.cocoa,
          elevation: 0,
          minimumSize: Size.zero,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'DETAIL',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }

  Widget _buildAddToCartButton(BuildContext context, Mochi mochi) {
    return SizedBox(
      width: 52,
      height: 36,
      child: AnimatedCartButton(
        onPressed: () {
          AppData.addToCart(mochi.toMap());

          AppSnackBar.success(context, '${mochi.name} ditambahkan ke cart');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primary,
          foregroundColor: AppTheme.white,
          elevation: 0,
          minimumSize: Size.zero,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Icon(Icons.shopping_bag_outlined, size: 18),
      ),
    );
  }

  // ===========================================================
  // KARTU HORIZONTAL (layar sempit, satu kolom)
  // ===========================================================

  Widget _buildPolishedCard(BuildContext context, Mochi mochi) {
    return Container(
      decoration: _cardDecoration(),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {
            _openDetail(context, mochi);
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                // GAMBAR + FAVORIT
                Stack(
                  children: [
                    MochiImage(
                      path: mochi.image,
                      width: 104,
                      height: 128,
                      borderRadius: 18,
                    ),

                    Positioned(
                      top: 6,
                      right: 6,
                      child: _buildFavoriteButton(mochi),
                    ),
                  ],
                ),

                const SizedBox(width: 12),

                // KONTEN
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mochi.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: _displayStyle(16),
                      ),

                      const SizedBox(height: 2),

                      Text(
                        mochi.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.35,
                          color: AppTheme.cocoa.withValues(alpha: 0.8),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Row(
                        children: [
                          _buildRatingPill(mochi.rating),

                          const Spacer(),

                          Text(
                            mochi.price,
                            style: _displayStyle(
                              16,
                              color: AppTheme.primaryDeep,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      Row(
                        children: [
                          Expanded(child: _buildDetailButton(context, mochi)),

                          const SizedBox(width: 8),

                          _buildAddToCartButton(context, mochi),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ===========================================================
  // KARTU VERTIKAL (layar lebar, grid)
  // ===========================================================

  Widget _buildGridCard(BuildContext context, Mochi mochi) {
    return Container(
      decoration: _cardDecoration(),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {
            _openDetail(context, mochi);
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // GAMBAR + FAVORIT
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      MochiImage(
                        path: mochi.image,
                        width: double.infinity,
                        height: double.infinity,
                        borderRadius: 18,
                      ),

                      Positioned(
                        top: 8,
                        right: 8,
                        child: _buildFavoriteButton(mochi),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    Expanded(
                      child: Text(
                        mochi.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: _displayStyle(16),
                      ),
                    ),

                    const SizedBox(width: 8),

                    Text(
                      mochi.price,
                      style: _displayStyle(16, color: AppTheme.primaryDeep),
                    ),
                  ],
                ),

                const SizedBox(height: 2),

                Text(
                  mochi.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.35,
                    color: AppTheme.cocoa.withValues(alpha: 0.8),
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    _buildRatingPill(mochi.rating),

                    const SizedBox(width: 8),

                    Expanded(child: _buildDetailButton(context, mochi)),

                    const SizedBox(width: 8),

                    _buildAddToCartButton(context, mochi),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ===========================================================
  // NAVIGASI: BAR BAWAH (sempit) DAN RAIL KIRI (lebar)
  // ===========================================================

  Widget _buildBottomBar() {
    return ValueListenableBuilder<List<Map<String, dynamic>>>(
      valueListenable: AppData.favorites,
      builder: (context, favorites, child) {
        return Container(
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: AppTheme.cocoa.withValues(alpha: 0.08),
                blurRadius: 20,
                offset: const Offset(0, -6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            child: NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: _onNavigationTap,
              backgroundColor: Colors.transparent,
              elevation: 0,
              destinations: [
                const NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home_rounded),
                  label: 'Home',
                ),

                NavigationDestination(
                  icon: Badge(
                    isLabelVisible: favorites.isNotEmpty,
                    label: Text(favorites.length.toString()),
                    child: const Icon(Icons.favorite_border_rounded),
                  ),
                  selectedIcon: Badge(
                    isLabelVisible: favorites.isNotEmpty,
                    label: Text(favorites.length.toString()),
                    child: const Icon(Icons.favorite_rounded),
                  ),
                  label: 'Favorite',
                ),

                const NavigationDestination(
                  icon: Icon(Icons.person_outline_rounded),
                  selectedIcon: Icon(Icons.person_rounded),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRail() {
    return ValueListenableBuilder<List<Map<String, dynamic>>>(
      valueListenable: AppData.favorites,
      builder: (context, favorites, child) {
        return Container(
          decoration: BoxDecoration(
            color: AppTheme.white,
            boxShadow: [
              BoxShadow(
                color: AppTheme.cocoa.withValues(alpha: 0.06),
                blurRadius: 24,
                offset: const Offset(6, 0),
              ),
            ],
          ),
          child: SafeArea(
            child: NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: _onNavigationTap,
              backgroundColor: Colors.transparent,
              minWidth: 92,
              labelType: NavigationRailLabelType.all,
              indicatorColor: AppTheme.dustyRose,
              selectedIconTheme: const IconThemeData(
                color: AppTheme.primaryDeep,
              ),
              unselectedIconTheme: const IconThemeData(color: AppTheme.cocoa),
              selectedLabelTextStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: AppTheme.primaryDeep,
              ),
              unselectedLabelTextStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppTheme.cocoa,
              ),
              leading: const Padding(
                padding: EdgeInsets.only(top: 12, bottom: 18),
                child: MochiImage(
                  path: 'assets/images/mochie_logo.png',
                  width: 48,
                  height: 48,
                  borderRadius: 14,
                  fit: BoxFit.contain,
                ),
              ),
              destinations: [
                const NavigationRailDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home_rounded),
                  label: Text('Home'),
                ),

                NavigationRailDestination(
                  icon: Badge(
                    isLabelVisible: favorites.isNotEmpty,
                    label: Text(favorites.length.toString()),
                    child: const Icon(Icons.favorite_border_rounded),
                  ),
                  selectedIcon: Badge(
                    isLabelVisible: favorites.isNotEmpty,
                    label: Text(favorites.length.toString()),
                    child: const Icon(Icons.favorite_rounded),
                  ),
                  label: const Text('Favorite'),
                ),

                const NavigationRailDestination(
                  icon: Icon(Icons.person_outline_rounded),
                  selectedIcon: Icon(Icons.person_rounded),
                  label: Text('Profile'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ===========================================================
  // BUILD
  // ===========================================================

  @override
  Widget build(BuildContext context) {
    final useRail = MediaQuery.sizeOf(context).width >= Breakpoints.wide;

    // IndexedStack menjaga posisi scroll tiap tab saat berpindah.
    final body = IndexedStack(
      index: _selectedIndex,
      children: [
        _buildHomeContent(),
        FavoritePage(onExplore: () => _onNavigationTap(0)),
        ProfilePage(onSelectTab: _onNavigationTap),
      ],
    );

    // Tombol kembali di tab Favorite/Profile membawa ke tab Home,
    // bukan langsung keluar aplikasi.
    return PopScope(
      canPop: _selectedIndex == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _onNavigationTap(0);
        }
      },
      child: Scaffold(
        backgroundColor: AppTheme.cream,
        body: useRail
            ? Row(
                children: [
                  _buildRail(),
                  Expanded(child: body),
                ],
              )
            : body,
        bottomNavigationBar: useRail ? null : _buildBottomBar(),
      ),
    );
  }
}

// =============================================================
// BOLA MOCHI DEKORATIF (untuk banner)
// =============================================================

class _MochiBall extends StatelessWidget {
  final double size;
  final Color color;

  const _MochiBall({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          center: const Alignment(-0.3, -0.4),
          radius: 0.9,
          colors: [AppTheme.white, color],
          stops: const [0.0, 0.72],
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.cocoa.withValues(alpha: 0.15),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
    );
  }
}

// =============================================================
// ANIMASI KARTU, FAVORIT, DAN TOMBOL CART
// =============================================================

class AnimatedMochiCard extends StatefulWidget {
  final Widget child;
  final int index;

  const AnimatedMochiCard({
    super.key,
    required this.child,
    required this.index,
  });

  @override
  State<AnimatedMochiCard> createState() => _AnimatedMochiCardState();
}

class _AnimatedMochiCardState extends State<AnimatedMochiCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Jeda dibatasi agar kartu di bagian bawah daftar
    // tidak muncul terlambat saat di-scroll.
    final step = widget.index > 5 ? 5 : widget.index;

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 350 + (step * 70)),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    Future.delayed(Duration(milliseconds: step * 70), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(position: _slideAnimation, child: widget.child),
    );
  }
}

class AnimatedFavoriteButton extends StatefulWidget {
  final bool isFavorite;
  final VoidCallback onPressed;

  const AnimatedFavoriteButton({
    super.key,
    required this.isFavorite,
    required this.onPressed,
  });

  @override
  State<AnimatedFavoriteButton> createState() => _AnimatedFavoriteButtonState();
}

class _AnimatedFavoriteButtonState extends State<AnimatedFavoriteButton> {
  double _scale = 1.0;

  Future<void> _handleTap() async {
    setState(() {
      _scale = 1.25;
    });

    widget.onPressed();

    await Future.delayed(const Duration(milliseconds: 120));

    if (mounted) {
      setState(() {
        _scale = 1.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutBack,
        child: Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.95),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            widget.isFavorite ? Icons.favorite : Icons.favorite_border,
            color: AppTheme.primaryDeep,
            size: 18,
          ),
        ),
      ),
    );
  }
}

class AnimatedCartButton extends StatefulWidget {
  final VoidCallback onPressed;
  final ButtonStyle? style;
  final Widget child;

  const AnimatedCartButton({
    super.key,
    required this.onPressed,
    this.style,
    required this.child,
  });

  @override
  State<AnimatedCartButton> createState() => _AnimatedCartButtonState();
}

class _AnimatedCartButtonState extends State<AnimatedCartButton> {
  double _scale = 1.0;

  Future<void> _handlePressed() async {
    setState(() {
      _scale = 0.96;
    });

    widget.onPressed();

    await Future.delayed(const Duration(milliseconds: 100));

    if (mounted) {
      setState(() {
        _scale = 1.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _scale,
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeOut,
      child: ElevatedButton(
        onPressed: _handlePressed,
        style: widget.style,
        child: widget.child,
      ),
    );
  }
}
