class Product {
  final String name;
  final String imagePath;
  final List<String> availableSizes;

  const Product({
    required this.name,
    required this.imagePath,
    required this.availableSizes,
  });
}

const Map<String, Product> productDatabase = {
  // Ductless Fume Hoods
  'SPD': Product(
    name: 'Ascent™ Opti',
    imagePath: 'assets/images/Ductless-SPD.png',
    availableSizes: ['3 ft', '4 ft'],
  ),
  'SPT': Product(
    name: 'Ascent™ Opti Titramax',
    imagePath: 'assets/images/Ductless-SPT.png',
    availableSizes: ['3 ft', '4 ft'],
  ),
  'SPF': Product(
    name: 'Ascent™ Opti Formax',
    imagePath: 'assets/images/Ductless-SPF.png',
    availableSizes: ['3 ft', '4 ft'],
  ),
  'PW1': Product(
    name: 'Powdermax™',
    imagePath: 'assets/images/Ductless-PW1.png',
    availableSizes: ['3 ft', '4 ft'],
  ),
  'ADC-B': Product(
    name: 'Ascent™ Max B Series',
    imagePath: 'assets/images/Ductless-ADC-B.png',
    availableSizes: ['2 ft', '3 ft', '4 ft', '5 ft', '6 ft'],
  ),
  'ADC-C': Product(
    name: 'Ascent™ Max C Series',
    imagePath: 'assets/images/Ductless-ADC-C.png',
    availableSizes: ['3 ft', '4 ft', '5 ft', '6 ft'],
  ),
  'ADC-D': Product(
    name: 'Ascent™ Max D Series',
    imagePath: 'assets/images/Ductless-ADC-D.png',
    availableSizes: ['3 ft', '4 ft', '5 ft', '6 ft'],
  ),
  'ADC-F': Product(
    name: 'Ascent™ Max F Series',
    imagePath: 'assets/images/Ductless-ADC-F.png',
    availableSizes: ['3 ft', '4 ft', '6 ft'],
  ),
  // Ducted Fume Hoods
  'EFP': Product(
    name: 'Frontier™ Perchloric Acid',
    imagePath: 'assets/images/Ducted-EFP.png',
    availableSizes: ['4 ft', '5 ft', '6 ft', '8 ft'],
  ),
  'EFA-XP': Product(
    name: 'Frontier™ Acela XP',
    imagePath: 'assets/images/Ducted-EFA-XP.png',
    availableSizes: ['4 ft', '5 ft', '6 ft', '8 ft'],
  ),
  'EFI': Product(
    name: 'Frontier™ Radioisotope',
    imagePath: 'assets/images/Ducted-EFI.png',
    availableSizes: ['4 ft', '5 ft', '6 ft', '8 ft'],
  ),
  'PPH': Product(
    name: 'Frontier™ PPH',
    imagePath: 'assets/images/Ducted-PPH.png',
    availableSizes: ['4 ft', '5 ft', '6 ft', '8 ft'],
  ),
  'EFQ': Product(
    name: 'Frontier™ Acid Digestion',
    imagePath: 'assets/images/Ducted-EFQ.png',
    availableSizes: ['4 ft', '5 ft', '6 ft', '8 ft'],
  ),
  'EFA-M': Product(
    name: 'Frontier™ Acela Mining',
    imagePath: 'assets/images/Ducted-EFA-M.png',
    availableSizes: ['4 ft', '5 ft', '6 ft', '8 ft'],
  ),
  'EFF': Product(
    name: 'Frontier™ Floor Mounted',
    imagePath: 'assets/images/Ducted-EFF.png',
    availableSizes: ['4 ft', '5 ft', '6 ft', '8 ft'],
  ),
  'EFD-A': Product(
    name: 'Frontier™ Duo A Series',
    imagePath: 'assets/images/Ducted-EFD-A.png',
    availableSizes: ['4 ft', '5 ft', '6 ft', '8 ft'],
  ),
  'EFD-B': Product(
    name: 'Frontier™ Duo B Series',
    imagePath: 'assets/images/Ducted-EFD-B.png',
    availableSizes: ['4 ft', '5 ft', '6 ft', '8 ft'],
  ),
  'EFA': Product(
    name: 'Frontier™ Acela',
    imagePath: 'assets/images/Ducted-EFA.png',
    availableSizes: ['4 ft', '5 ft', '6 ft', '8 ft'],
  ),
  'EFH': Product(
    name: 'Frontier™ Mono',
    imagePath: 'assets/images/Ducted-EFH.png',
    availableSizes: ['4 ft', '5 ft', '6 ft'],
  ),
};
