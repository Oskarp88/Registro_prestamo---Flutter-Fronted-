import 'package:flutter/material.dart';

class MyColors {
  // Usamos un mapa para que los grupos de colores tengan nombre
  static const List<List<Color>> myColors = [
     [
      esmeralda0,
      esmeralda2, // color inferior
      esmeralda5,
      esmeralda7,
      esmeralda8,
      greebAccentDark9,
    ],
    [
      zafiro0,
      zafiro1,
      zafiro5, // color inferior
      zafiro6,
     zafiro7,// color superior
      zafiro8,
    ],
    [
      plata0,
      plata1,
      plata2,
      plata3,
      plata4,
      plata8,
    ],
    [
      MyColors.alizarin0,
      rubi0,
      rubi3,
      rubi5,
      rubi6,
      rubi7,
    ],
    [
      yellow0,
      yellow1,
      yellow2,
      yellow3,
      yellow4,
      yellow5,
      yellow6,
      yellow7,
      yellow8,
      yellow9,    
    ],
  ];

  static const Color primaryColor = Color(0xff4868ff);
  static const Color opacityBlack = Color(0x80232323); 
  static const Color cobre =  Color(0xFFB87333);
 static const Color plata =  Color(0xFFC0C0C0);
 static const Color oro =  Color(0xFFFFD700);
 static const Color esmeralda = Color(0xFF50C878); // Emerald
 static const Color rubi = Color(0xFFE0115F); // Ruby
 static const Color zafiroAzul =  Color(0xFF0F52BA); // Sapphire Blue
 

  static const Color primary = Color(0xff4868ff);
  static const Color secondary = Color(0xffffe248);
  static const Color accent = Color(0xffb0c7ff);

  //text colors
  static const Color textPrimary = Color(0xff333333);
  static const Color textSecondary = Color(0xff6c7570);
  static const Color textWhite = Colors.white;

  //Background Colors
  static const Color light = Color(0xfff6f6f6);
  static const Color dark = Color(0xff272727);
  static const Color primaryBackground = Color(0xfff3f5ff);

  //background container colors
  static const Color lightContainer = Color(0xfff6f6f6);
  static  Color darkContainer = Colors.white.withOpacity(0.1);
  
  //button Colors
  static const Color buttonPrimary = Color(0xff4b68ff);
  static const Color buttonSecondary = Color(0xff6c7570);
  static const Color buttonDisable = Color(0xffc4c4c4);

  //border Colors
  static const Color borderPrimary = Color(0xffd9d9d9);
  static const Color borderSecondary = Color(0xffe6e6e6);

  //Error and validation Colors
  static const Color error = Color(0xffd32f2f);
  static const Color success = Color(0xff388e3c);
  static const Color warning = Color(0xfff57c00);
  static const Color info = Color(0xff1976d2);

  //Neutral Shades 
  static const Color black = Color(0xff232323);
  static const Color darkerGrey = Color(0xff4f4f4f);
  static const Color darkGrey = Color(0xff939393);
  static const Color grey = Color(0xffe0e0e0);
  static const Color softGrey = Color(0xfff4f4f4);
  static const Color lightGrey = Color(0xfff9f9f9);
  static const Color white = Color(0xffffffff);

  static const Color blackRow = Color(0xff2E86C1);
  static const Color whiteRow = Color(0xffebecd0);
  static const Color blackBackgroundColor = Color(0xff2874a6);
  static const Color borderBottomColor = Color(0xff4a697c);

  static const Color greenBlack = Color(0xff779556);
  static const Color greenWhite = Color(0xffebecd0);

  static const Color backgroundColor = Color(0xff202020);
  static const Color selectedColor = Color(0xffffee58);
  static const Color destinationPieceColor = Color(0xfffff176);
  static const Color initPositionPieceColor = Color(0xfffff59d);

  //red
  static const Color redDark0 = Color(0xfff9ebea);
  static const Color redDark1 = Color(0xfff2d7d5);
  static const Color redDark2 = Color(0xffe6b0aa);
  static const Color redDark3 = Color(0xffd98880);
  static const Color redDark4 = Color(0xffcd6155);
  static const Color redDark5 = Color(0xffc0392b);
  static const Color redDark6 = Color(0xffa93226);
  static const Color redDark7 = Color(0xff922b21);
  static const Color redDark8 = Color(0xff7b241c);
  static const Color redDark9 = Color(0xff641e16);

  static const Color redLight0 = Color(0xfffdedec);
  static const Color redLight1 = Color(0xfffadbd8);
  static const Color redLight2 = Color(0xfff5b7b1);
  static const Color redLight3 = Color(0xfff1948a);
  static const Color redLight4 = Color(0xffec7063);
  static const Color redLight5 = Color(0xffe74c3c);
  static const Color redLight6 = Color(0xffcb4335);
  static const Color redLight7 = Color(0xffb03a2e);
  static const Color redLight8 = Color(0xff943126);
  static const Color redLight9 = Color(0xff78281f);

  //Amethyst
  static const Color violetLight0 = Color(0xfff5eef8);
  static const Color violetLight1 = Color(0xffebdef0);
  static const Color violetLight2 = Color(0xffd7bde2);
  static const Color violetLight3 = Color(0xffc39bd3);
  static const Color violetLight4 = Color(0xffaf7ac5);
  static const Color violetLight5 = Color(0xff9b59b6);
  static const Color violetLight6 = Color(0xff7d3c98);
  static const Color violetLight7 = Color(0xff76448a);
  static const Color violetLight8 = Color(0xff633974);
  static const Color violetLight9 = Color(0xff512e5f);
  
  //Wisteria
  static const Color violetDark0 = Color(0xfff4ecf7);
  static const Color violetDark1 = Color(0xffe8daef);
  static const Color violetDark2 = Color(0xffd2b4de);
  static const Color violetDark3 = Color(0xffbb8fce);
  static const Color violetDark4 = Color(0xffa569bd);
  static const Color violetDark5 = Color(0xff8e44ad);
  static const Color violetDark6 = Color(0xff7d3c98);
  static const Color violetDark7 = Color(0xff6c3483);
  static const Color violetDark8 = Color(0xff5b2c6f);
  static const Color violetDark9 = Color(0xff4a235a);

  static const Color blue0 = Color(0xffe3f2fd);
  static const Color blue1 = Color(0xffbbdefb);
  static const Color blue2 = Color(0xff90caf9);
  static const Color blue3 = Color(0xff64b5f6);
  static const Color blue4 = Color(0xff42a5f5);
  static const Color blue5 = Color(0xff2196f3);
  static const Color blue6 = Color(0xff1e88e5);
  static const Color blue7 = Color(0xff1976d2);
  static const Color blue8 = Color(0xff1565c0);
  static const Color blue9 = Color(0xff0d47a1);
  static const Color blue10 = Color(0xff82b1ff);
  static const Color blue11 = Color(0xff448aff);
  static const Color blue12 = Color(0xff2979ff);
  static const Color blue13 = Color(0xff2962ff);
  

  //Belize hole
  static const Color blueDark0 = Color(0xffeaf2f8);
  static const Color blueDark1 = Color(0xffd4e6f1);
  static const Color blueDark2 = Color(0xffa9cce3);
  static const Color blueDark3 = Color(0xff7fb3d5);
  static const Color blueDark4 = Color(0xff5499c7);
  static const Color blueDark5 = Color(0xff2980b9);
  static const Color blueDark6 = Color(0xff2471a3);
  static const Color blueDark7 = Color(0xff1f618d);
  static const Color blueDark8 = Color(0xff1a5276);
  static const Color blueDark9 = Color(0xff154360);
  
  //Peter river
  static const Color blueLight0 = Color(0xffebf5fb);
  static const Color blueLight1 = Color(0xffd6eaf8);
  static const Color blueLight2 = Color(0xffaed6f1);
  static const Color blueLight3 = Color(0xff85c1e9);
  static const Color blueLight4 = Color(0xff5dade2);
  static const Color blueLight5 = Color(0xff3498db);
  static const Color blueLight6 = Color(0xff2e86c1);
  static const Color blueLight7 = Color(0xff2874a6);
  static const Color blueLight8 = Color(0xff21618c);
  static const Color blueLight9 = Color(0xff1b4f72);

  //green accent
  static const Color greebAccentLight0 = Color(0xffe8f8f5);
  static const Color greebAccentLight1 = Color(0xffd1f2eb);
  static const Color greebAccentLight2 = Color(0xffa3e4d7);
  static const Color greebAccentLight3 = Color(0xff76d7c4);
  static const Color greebAccentLight4 = Color(0xff48c9b0);
  static const Color greebAccentLight5 = Color(0xff1abc9c);
  static const Color greebAccentLight6 = Color(0xff17a589);
  static const Color greebAccentLight7 = Color(0xff148f77);
  static const Color greebAccentLight8 = Color(0xff117864);
  static const Color greebAccentLight9 = Color(0xff0e6251);

  static const Color greebAccentDark0 = Color(0xffe8f6f3);
  static const Color greebAccentDark1 = Color(0xffd0ece7);
  static const Color greebAccentDark2 = Color(0xffa2d9ce);
  static const Color greebAccentDark3 = Color(0xff73c6b6);
  static const Color greebAccentDark4 = Color(0xff45b39d);
  static const Color greebAccentDark5 = Color(0xff16a085);
  static const Color greebAccentDark6 = Color(0xff138d75);
  static const Color greebAccentDark7 = Color(0xff117a65);
  static const Color greebAccentDark8 = Color(0xff0e6655);
  static const Color greebAccentDark9 = Color(0xff0b5345);

  //green
  static const Color greenDark0 = Color(0xffe9f7ef);
  static const Color greenDark1 = Color(0xffd4efdf);
  static const Color greenDark2 = Color(0xffa9dfbf);
  static const Color greenDark3 = Color(0xff7dcea0);
  static const Color greenDark4 = Color(0xff52be80);
  static const Color greenDark5 = Color(0xff27ae60);
  static const Color greenDark6 = Color(0xff229954);
  static const Color greenDark7 = Color(0xff1e8449);
  static const Color greenDark8 = Color(0xff196f3d);
  static const Color greenDark9 = Color(0xff145a32);

  static const Color greenLight0 = Color(0xffeafaf1);
  static const Color greenLight1 = Color(0xffd5f5e3);
  static const Color greenLight2 = Color(0xffabebc6);
  static const Color greenLight3 = Color(0xff82e0aa);
  static const Color greenLight4 = Color(0xff58d68d);
  static const Color greenLight5 = Color(0xff2ecc71);
  static const Color greenLight6 = Color(0xff28b463);
  static const Color greenLight7 = Color(0xff239b56);
  static const Color greenLight8 = Color(0xff1d8348);
  static const Color greenLight9 = Color(0xff186a3b);

  //yellow
  static const Color yellow0 = Color(0xfffef9e7);
  static const Color yellow1 = Color(0xfffcf3cf);
  static const Color yellow2 = Color(0xfff9e79f);
  static const Color yellow3 = Color(0xfff7dc6f);
  static const Color yellow4 = Color(0xfff4d03f);
  static const Color yellow5 = Color(0xfff1c40f);
  static const Color yellow6 = Color(0xffd4ac0d);
  static const Color yellow7 = Color(0xffb7950b);
  static const Color yellow8 = Color(0xff9a7d0a);
  static const Color yellow9 = Color(0xff7d6608);

  //ORANGE
  static const Color orangeLight0 = Color(0xfffef5e7);
  static const Color orangeLight1 = Color(0xfffdebd0);
  static const Color orangeLight2 = Color(0xfffad7a0);
  static const Color orangeLight3 = Color(0xfff8c471);
  static const Color orangeLight4 = Color(0xfff5b041);
  static const Color orangeLight5 = Color(0xfff39c12);
  static const Color orangeLight6 = Color(0xffd68910);
  static const Color orangeLight7 = Color(0xffb9770e);
  static const Color orangeLight8 = Color(0xff9c640c);
  static const Color orangeLight9 = Color(0xff7e5109);

  static const Color orangeDark0 = Color(0xfffdf2e9);
  static const Color orangeDark1 = Color(0xfffae5d3);
  static const Color orangeDark2 = Color(0xfff5cba7);
  static const Color orangeDark3 = Color(0xfff0b27a);
  static const Color orangeDark4 = Color(0xffeb984e);
  static const Color orangeDark5 = Color(0xffe67e22);
  static const Color orangeDark6 = Color(0xffca6f1e);
  static const Color orangeDark7 = Color(0xffaf601a);
  static const Color orangeDark8 = Color(0xff935116);
  static const Color orangeDark9 = Color(0xff784212);

  static const Color orangeDarkFull0 = Color(0xfffbeee6);
  static const Color orangeDarkFull1 = Color(0xfff6ddcc);
  static const Color orangeDarkFull2 = Color(0xffedbb99);
  static const Color orangeDarkFull3 = Color(0xffe59866);
  static const Color orangeDarkFull4 = Color(0xffdc7633);
  static const Color orangeDarkFull5 = Color(0xffd35400);
  static const Color orangeDarkFull6 = Color(0xffba4a00);
  static const Color orangeDarkFull7 = Color(0xffa04000);
  static const Color orangeDarkFull8 = Color(0xff873600);
  static const Color orangeDarkFull9 = Color(0xff6e2c00);

  //Pomegranate
  static const Color pomegranate0 = Color(0xfff9ebea);
  static const Color pomegranate1 = Color(0xfff2d7d5);
  static const Color pomegranate2 = Color(0xffe6b0aa);
  static const Color pomegranate3 = Color(0xffd98880);
  static const Color pomegranate4 = Color(0xffcd6155);
  static const Color pomegranate5 = Color(0xffc0392b);
  static const Color pomegranate6 = Color(0xffa93226);
  static const Color pomegranate7 = Color(0xff922b21);
  static const Color pomegranate8 = Color(0xff7b241c);
  static const Color pomegranate9 = Color(0xff641e16);

  //Alizarin
  static const Color alizarin0 = Color(0xfffdedec);
  static const Color alizarin1 = Color(0xfffadbd8);
  static const Color alizarin2 = Color(0xfff5b7b1);
  static const Color alizarin3 = Color(0xfff1948a);
  static const Color alizarin4 = Color(0xffec7063);
  static const Color alizarin5 = Color(0xffe74c3c);
  static const Color alizarin6 = Color(0xffcb4335);
  static const Color alizarin7 = Color(0xffb03a2e);
  static const Color alizarin8 = Color(0xff943126);
  static const Color alizarin9 = Color(0xff78281f);

  //white
  static const Color white0 = Color(0xfffdfefe);
  static const Color white1 = Color(0xfffbfcfc);
  static const Color white2 = Color(0xfff7f9f9);
  static const Color white3 = Color(0xfff4f6f7);
  static const Color white4 = Color(0xfff0f3f4);
  static const Color white5 = Color(0xffecf0f1);
  static const Color white6 = Color(0xffd0d3d4);
  static const Color white7 = Color(0xffb3b6b7);
  static const Color white8 = Color(0xff979a9a);
  static const Color white9 = Color(0xff7b7d7d);

  //silver
  static const Color silver0 = Color(0xfff8f9f9);
  static const Color silver1 = Color(0xfff2f3f4);
  static const Color silver2 = Color(0xffe5e7e9);
  static const Color silver3 = Color(0xffd7dbdd);
  static const Color silver4 = Color(0xffcacfd2);
  static const Color silver5 = Color(0xffbdc3c7);
  static const Color silver6 = Color(0xffa6acaf);
  static const Color silver7 = Color(0xff909497);
  static const Color silver8 = Color(0xff797d7f);
  static const Color silver9 = Color(0xff626567);

  //concrete
  static const Color concrete0 = Color(0xfff4f6f6);
  static const Color concrete1 = Color(0xffeaeded);
  static const Color concrete2 = Color(0xffd5dbdb);
  static const Color concrete3 = Color(0xffbfc9ca);
  static const Color concrete4 = Color(0xffaab7b8);
  static const Color concrete5 = Color(0xff95a5a6);
  static const Color concrete6 = Color(0xff839192);
  static const Color concrete7 = Color(0xff717d7e);
  static const Color concrete8 = Color(0xff5f6a6a);
  static const Color concrete9 = Color(0xff4d5656);
  
  //wesAsphalt
  static const Color wesAsphalt0 = Color(0xffebedef);
  static const Color wesAsphalt1 = Color(0xffd6dbdf);
  static const Color wesAsphalt2 = Color(0xffaeb6bf);
  static const Color wesAsphalt3 = Color(0xff85929e);
  static const Color wesAsphalt4 = Color(0xff5d6d7e);
  static const Color wesAsphalt5 = Color(0xff34495e);
  static const Color wesAsphalt6 = Color(0xff2e4053);
  static const Color wesAsphalt7 = Color(0xff283747);
  static const Color wesAsphalt8 = Color(0xff212f3c);
  static const Color wesAsphalt9 = Color(0xff1b2631);

  //cobre
  static const Color cobre0 = Color(0xffFFD8B1);
  static const Color cobre1 = Color(0xffFFBB88);
  static const Color cobre2 = Color(0xffFFA06C);
  static const Color cobre3 = Color(0xffFF874C);
  static const Color cobre4 = Color(0xffE07038);
  static const Color cobre5 = Color(0xffC95A29);
  static const Color cobre6 = Color(0xffA34723);
  static const Color cobre7 = Color(0xff823817);
  static const Color cobre8 = Color(0xff662A12);
  static const Color cobre9 = Color(0xff4B1F0D);

  //plata
  static const Color plata0 = Color(0xffF5F5F5);
  static const Color plata1 = Color(0xffEAEAEA);
  static const Color plata2 = Color(0xffD9D9D9);
  static const Color plata3 = Color(0xffC0C0C0);
  static const Color plata4 = Color(0xffA8A8A8);
  static const Color plata5 = Color(0xff909090);
  static const Color plata6 = Color(0xff787878);
  static const Color plata7 = Color(0xff606060);
  static const Color plata8 = Color(0xff484848);
  static const Color plata9 = Color(0xff303030);

  //oro
  static const Color oro0 = Color(0xffFFFDF2);
  static const Color oro1 = Color(0xffFFF7C2);
  static const Color oro2 = Color(0xffFFEE93);
  static const Color oro3 = Color(0xffFFE066);
  static const Color oro4 = Color(0xffFFD700);
  static const Color oro5 = Color(0xffFFCC00);
  static const Color oro6 = Color(0xffF7C600);
  static const Color oro7 = Color(0xffE6B800);
  static const Color oro8 = Color(0xffD4A900);
  static const Color oro9 = Color(0xffB58B00);

  //esmeralda
  static const Color esmeralda0 = Color(0xffE0F8F5);
  static const Color esmeralda1 = Color(0xffB2F2E6);
  static const Color esmeralda2 = Color(0xff7DEAD9);
  static const Color esmeralda3 = Color(0xff3CDAC5);
  static const Color esmeralda4 = Color(0xff2ECC71);
  static const Color esmeralda5 = Color(0xff27AE60);
  static const Color esmeralda6 = Color(0xff1E9B53);
  static const Color esmeralda7 = Color(0xff168C47);
  static const Color esmeralda8 = Color(0xff0F7C3B);
  static const Color esmeralda9 = Color(0xff066C30);

  //rubi
  static const Color rubi0 = Color(0xffFFD6D6);
  static const Color rubi1 = Color(0xffFFA3A3);
  static const Color rubi2 = Color(0xffFF7070);
  static const Color rubi3 = Color(0xffFF3D3D);
  static const Color rubi4 = Color(0xffFF0A0A);
  static const Color rubi5 = Color(0xffD60000);
  static const Color rubi6 = Color(0xffAD0000);
  static const Color rubi7 = Color(0xff850000);
  static const Color rubi8 = Color(0xff5C0000);
  static const Color rubi9 = Color(0xff330000);

  //zafiro
  static const Color zafiro0 = Color(0xffD0E7FF);
  static const Color zafiro1 = Color(0xffA0CBFF);
  static const Color zafiro2 = Color(0xff70AFFF);
  static const Color zafiro3 = Color(0xff4093FF);
  static const Color zafiro4 = Color(0xff1077FF);
  static const Color zafiro5 = Color(0xff0D5FCC);
  static const Color zafiro6 = Color(0xff0A4799);
  static const Color zafiro7 = Color(0xff073066);
  static const Color zafiro8 = Color(0xff05274D);
  static const Color zafiro9 = Color(0xff041F3A);
}
