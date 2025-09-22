import 'package:dogs/domain/entities/breed.dart' as models;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class DescriptionBreed extends StatelessWidget {
  final models.Breed breed;
  const DescriptionBreed({super.key, required this.breed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Información", style: GoogleFonts.changaOne(fontSize: 30,color: Colors.white),)
        ,backgroundColor: Colors.indigo,foregroundColor: Colors.white,),
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              Image.network(breed.image.url,
              width: 250,
              height: 250,
              fit: BoxFit.cover),
              SizedBox(height: 30),
              Text(breed.name,
              style: GoogleFonts.lobster(fontSize: 30,fontWeight: FontWeight.bold, color: Colors.indigo),textAlign: TextAlign.center
              ),
              SizedBox(height: 20),
              Text("Nombre:  " + breed.breedGroup, style: GoogleFonts.crimsonText(fontSize: 20),textAlign: TextAlign.center
              ),
              SizedBox(height: 8),
              Text("Grupo:  " + breed.breedGroup, style: GoogleFonts.crimsonText(fontSize: 20),textAlign: TextAlign.center
              ),
              SizedBox(height: 8),
              Text("Tiempo de vida:  " + breed.lifeSpan, style: GoogleFonts.crimsonText(fontSize: 20),textAlign: TextAlign.center
              ),
              SizedBox(height: 8),
              Text("Temperamento:  " + breed.temperament, style: GoogleFonts.crimsonText(fontSize: 20),textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text("Origen:  " + (breed.origin.isNotEmpty == true ? breed.origin : "Sin información"), style: GoogleFonts.crimsonText(fontSize: 20),textAlign: TextAlign.center
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}

