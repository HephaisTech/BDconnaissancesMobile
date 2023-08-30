import 'package:get/get.dart';

class LocalString extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'start': 'start',
          'Base_de_Connaissances': 'Knowledge Base',
        },
        'fr_FR': {
          'start': 'start',
          'Base_de_Connaissances': 'Base de Connaissances',
        },
      };
}
