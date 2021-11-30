import 'package:openfoodfacts/openfoodfacts.dart';

// gets product name based on barcode
Future<Product> getProduct(var barcode) async {
  ProductQueryConfiguration configuration = ProductQueryConfiguration(barcode,
      language: OpenFoodFactsLanguage.ENGLISH, fields: [ProductField.ALL]);
  ProductResult result = await OpenFoodAPIClient.getProduct(configuration);

  if (result.status == 1) {
    return result.product!;
  } else {
    throw Exception('product not found, please insert data for ' +
        barcode); // have to do this eventually
  }
}
