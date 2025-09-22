import 'package:dogs/domain/entities/breed.dart' as models;
import 'package:dogs/presentation/viewmodels/breeds_view_model.dart';
import 'package:dogs/presentation/viewmodels/favorites_view_model.dart';
import 'package:dogs/presentation/views/home/description_breed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _index = 0;
  String _query = "";
  final _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<BreedsProvider>(context, listen: false).getBreed();
    });
  }

  @override
  Widget build(BuildContext context) {
    final breedsProvider = Provider.of<BreedsProvider>(context);
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final error  = breedsProvider.errorMessage;
    if (error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await _showErrorDialog(context, error);
        breedsProvider.clearError();
      });
    }

    final filtered =
        breedsProvider.breeds.where((b) {
          final q = _query.trim().toLowerCase();
          if (q.isEmpty) return true;
          final name = b.name.toLowerCase();
          final group = (b.breedGroup ?? "").toLowerCase();
          return name.contains(q) || group.contains(q);
        }).toList();

    final filteredFavorites =
        favoritesProvider.favorites.where((b) {
          final q = _query.trim().toLowerCase();
          if (q.isEmpty) return true;
          final name = b.name.toLowerCase();
          final group = (b.breedGroup ?? "").toLowerCase();
          return name.contains(q) || group.contains(q);
        }).toList();

    final pages = [
      breedsProvider.errorMessage != null
          ? Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              breedsProvider.errorMessage!,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () => breedsProvider.getBreed(),
              child: const Text("Reintentar"),
            ),
          ],
        ),
      )
          : (breedsProvider.breeds.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: filtered.length,
        itemBuilder: (context, index) {
          final breed = filtered[index];
          return _CardsView(breed);
        },
      )),
      favoritesProvider.favorites.isEmpty
          ? const Center(child: Text("Aún no tienes razas favoritas"))
          : ListView.builder(
        itemCount: filteredFavorites.length,
        itemBuilder: (context, index) {
          final breed = filteredFavorites[index];
          return _CardsView(breed);
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dogs",
          style: GoogleFonts.changaOne(fontSize: 30, color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: TextField(
              controller: _searchCtrl,
              onChanged: (value) => setState(() => _query = value),
              textInputAction: TextInputAction.search,
              style: TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                hintText: "Buscar",
                hintStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(Icons.search, color: Colors.white),
                suffixIcon:
                    _query.isNotEmpty
                        ? IconButton(
                          icon: Icon(Icons.clear, color: Colors.white),
                          onPressed: () {
                            _searchCtrl.clear();
                            setState(() => _query = '');
                          },
                        )
                        : null,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(child: pages[_index]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: [
          NavigationDestination(icon: Icon(Icons.list), label: "Razas"),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            label: "Favoritas",
          ),
        ],
      ),
    );
  }
}
Future<void> _showErrorDialog(BuildContext context, String message) {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (ctx) => AlertDialog(
      title: const Text("Ups"),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(),
          child: const Text("Acepta"),
        ),
      ],
    ),
  );
}

class _CardsView extends StatefulWidget {
  final models.Breed breed;

  const _CardsView(this.breed, {super.key});

  @override
  State<_CardsView> createState() => _CardsViewState();
}

class _CardsViewState extends State<_CardsView> {

  void _descriptionBreed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DescriptionBreed(breed: widget.breed),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoritesProvider>(context);
    final isFav = favoriteProvider.isFavorite(widget.breed);

    return GestureDetector(
      onTap: _descriptionBreed,
      child: Card(
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              ClipRect(
                child: Image.network(
                  widget.breed.image.url,
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (widget.breed.breedGroup ?? "").isNotEmpty
                          ? widget.breed.breedGroup
                          : widget.breed.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      widget.breed.lifeSpan.isNotEmpty
                          ? widget.breed.lifeSpan
                          : "No Life",
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
              FilledButton(
                onPressed: () => favoriteProvider.toggleFavorite(widget.breed),
                style: FilledButton.styleFrom(backgroundColor: Colors.indigo),
                child: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? Colors.red : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
