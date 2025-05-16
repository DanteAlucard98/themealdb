import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildMealCard(String id,String title, String? image, BuildContext context) {
  return InkWell(
    onTap: () {
      context.goNamed('detail-meals-screen',
       pathParameters: {'mealId': id},
      );
    },
    child: Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5, 
      child: SizedBox(
        height: 180.0.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)), 
              child: image != null
                ? Image.network(
                    image,
                    width: double.infinity, 
                    height: 120.0.h,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: double.infinity,
                    height: 120.0.h,
                    color: Colors.blue.withAlpha(50),
                    child: Icon(
                      Icons.fastfood,
                      size: 60.0.w,
                      color: Colors.blue.withAlpha(200),
                    ),
                  ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                title,
                style: GoogleFonts.montserrat(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}