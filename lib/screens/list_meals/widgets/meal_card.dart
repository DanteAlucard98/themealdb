import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recetas_adpp_2025/main.dart';
import 'package:recetas_adpp_2025/general_widgets/network_image_with_fallback.dart';
import 'package:recetas_adpp_2025/general_widgets/favorite_button.dart';


//Clase para obtener la tarjeta de la comida
Widget buildMealCard(String id, String title, String? image, BuildContext context) {
  return InkWell(
    onTap: () {
      context.goNamed('detail-meals-screen',
       pathParameters: {'mealId': id},
      );
    },
    //Tarjeta de la comida
    child: Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5, 
      color: AppColors.cardBackground,
      child: Stack(
        children: [
          SizedBox(
            height: 180.0.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Imagen de la comida
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)), 
                  child: image != null
                    ? NetworkImageWithFallback(
                        imageUrl: image,
                        width: double.infinity, 
                        height: 120.0.h,
                        fit: BoxFit.cover,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
                      )
                    : Container(
                        width: double.infinity,
                        height: 120.0.h,
                        color: AppColors.primary.withOpacity(0.1),
                        child: Icon(
                          Icons.fastfood,
                          size: 60.0.w,
                          color: AppColors.primary,
                        ),
                      ),
                ),
                //Título de la comida
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: GoogleFonts.montserrat(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          // Botón de favorito
          Positioned(
            top: 8.0,
            right: 8.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: FavoriteButton(
                mealId: id,
                size: 28.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

