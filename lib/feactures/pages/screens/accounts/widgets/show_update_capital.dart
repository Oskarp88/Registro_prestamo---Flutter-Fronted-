import 'package:flutter/material.dart';

void showUpdateCapitalDialog({
 required BuildContext context, 
 required String title,
 required String text,
 required Function() onPressed
}) {  
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(
            '$text\n'
            '\n'
            '¿Deseas continuar?'
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 2
                )
              ),
              onPressed: onPressed,
              child: const Text('Confirmar'),
            ),
          ],
        );
      },  
  );

  }
