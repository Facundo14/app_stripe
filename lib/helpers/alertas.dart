part of 'helpers.dart';

mostrarLoading(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        if (Platform.isAndroid) {
          return const AlertDialog(
            title: Text('Espere'),
            content: LinearProgressIndicator(),
          );
        } else {
          return const CupertinoAlertDialog(
            title: Text('Espere'),
            content: CupertinoActivityIndicator(),
          );
        }
      });
}

mostrarAlerta(BuildContext context, String titulo, String mensaje) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        if (Platform.isAndroid) {
          return AlertDialog(
            title: Text(titulo),
            content: Text(mensaje),
            actions: [
              MaterialButton(
                child: const Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        } else {
          return CupertinoAlertDialog(
            title: Text(titulo),
            content: Text(mensaje),
            actions: [
              CupertinoButton(
                child: const Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        }
      });
}
