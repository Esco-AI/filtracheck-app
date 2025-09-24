import '../models/product_details.dart';

const Map<String, ProductDetails> productSpecifications = {
  // Ductless Fume Hoods
  'SPD': ProductDetails(
    name: 'Ascent™ Opti',
    specifications: [
      'Has a main carbon filter',
      'Ergonomic arm ports and cable pass-throughs',
      'Has mobile cart',
      'Available Sizes: 3 and 4 ft.',
    ],
  ),
  'SPT': ProductDetails(
    name: 'Ascent™ Opti Titramax',
    specifications: [
      'Ideal for titration applications',
      'Equipped with carbon filter',
      'Has taller workzone and a horizontal sliding sash',
      'Available Sizes: 3 and 4 ft.',
    ],
  ),
  'SPF': ProductDetails(
    name: 'Ascent™ Opti Formax',
    specifications: [
      'Formalin-dispensing ductless fume hood',
      'Has a main carbon filter',
      'Optional VOC Sensor',
      'Available Sizes: 3 and 4 ft.',
    ],
  ),
  'PW1': ProductDetails(
    name: 'Powdermax™',
    specifications: [
      'Ideal for handling powdered chemicals',
      'Equipped with HEPA filter',
      'Phenolic worktop for lesser vibrations',
      'Available Sizes: 3 and 4 ft.',
    ],
  ),
  'ADC-B': ProductDetails(
    name: 'Ascent™ Max – B Series',
    specifications: [
      'Standard model',
      'Has a main carbon filter',
      'Optional VOC Sensor',
      'May have provisions for PP drip cup, swan neck faucet and service fixtures',
      'Available Sizes: 2,3,4,5,6 ft.',
    ],
  ),
  'ADC-C': ProductDetails(
    name: 'Ascent™ Max – C Series',
    specifications: [
      'Has a main carbon filter and secondary carbon filter at the exhaust',
      'Optional VOC Sensor',
      'May have provisions for PP drip cup, swan neck faucet and service fixtures',
      'Available Sizes: 3,4,5,6 ft.',
    ],
  ),
  'ADC-D': ProductDetails(
    name: 'Ascent™ Max – D Series',
    specifications: [
      'Has a main carbon filter and a secondary HEPA filter at the exhaust',
      'Optional VOC Sensor',
      'May have provisions for PP drip cup, swan neck faucet and service fixtures',
      'Available Sizes: 3,4,5,6 ft.',
    ],
  ),
  'ADC-E': ProductDetails(
    name: 'Ascent™ Max – E Series',
    specifications: [
      'Has a main carbon filter and a secondary HEPA filter at the exhaust',
      'Optional VOC Sensor',
      'May have provisions for PP drip cup, swan neck faucet and service fixtures',
      'Available Sizes: 3,4,5,6 ft.',
    ],
  ),
  'ADC-F': ProductDetails(
    name: 'Ascent™ Max – F Series',
    specifications: [
      'Has a main HEPA filter and secondary HEPA filter at the exhaust',
      'Available Sizes: 3, 4, 6 ft.',
    ],
  ),
  // Ducted Fume Hoods
  'EFH': ProductDetails(
    name: 'Frontier® Mono',
    specifications: [
      'ASHRAE 110-2016 certified',
      'Single wall design',
      'Worktop and service fixtures are installed on the base cabinet',
      'No sash sloping',
      'Phenolic resin liner and baffle',
      'Available sizes: 4, 5 and 6 ft',
    ],
  ),
  'EFD-A': ProductDetails(
    name: 'Frontier® Duo- A Series',
    specifications: [
      'Dual-wall construction',
      'With black color phenolic resin as default worktop',
      'Has service fixtures',
      'Ergonomic 8° sloped front sash',
      'Available sizes: 4, 5, 6 and 8 ft',
    ],
  ),
  'EFD-B': ProductDetails(
    name: 'Frontier® Duo- B Series',
    specifications: [
      'ASHRAE 110-2016 certified',
      'Microprocessor control system',
      'Dual-wall construction',
      'With black color phenolic resin as default worktop',
      'Has service fixtures',
      'Ergonomic 8° sloped front sash',
      'Available sizes: 4, 5, 6 and 8 ft',
    ],
  ),
  'EFA': ProductDetails(
    name: 'Frontier® Acela',
    specifications: [
      'ASHRAE 110-2016 certified',
      'Tri-wall construction',
      'Low energy-consumption, high performance fume hood',
      '5° sloped front sash design',
      'Superior containment at 0.3 m/s face velocity',
      'Available sizes: 4, 5, 6 and 8 ft',
    ],
  ),
  'EFQ': ProductDetails(
    name: 'Frontier® Acid Digestion',
    specifications: [
      'ASHRAE 110-2016 compliant',
      'Tri-wall construction',
      'Designed for acid-digestion applications (except perchloric acid)',
      'Built with u-PVC or PP internal surface has polycarbonate sash to prevent etching',
      'Available sizes: 4, 5, 6 and 8 ft',
    ],
  ),
  'EFA-M': ProductDetails(
    name: 'Frontier® Acela Mining',
    specifications: [
      'ASHRAE 110-2016 compliant',
      'Tri-wall construction',
      'Provides the highest level of containment and protection against highly corrosive chemicals at high temperature',
      'With European-made ceramic worktop',
      'Available sizes: 4, 5, 6 and 8 ft',
    ],
  ),
  'EFA-XP': ProductDetails(
    name: 'Frontier® Acela XP',
    specifications: [
      'Tri-wall construction',
      'Provides the highest level of containment and almost no possibility of sparks in the work zone',
      'Standard accessories include: Explosion proof light fixture, Explosion proof Electrical Socket Outlet, Explosion proof ON-OFF light switch, Explosion proof Junction Box',
      'Available sizes: 4, 5, 6 and 8 ft',
    ],
  ),
  'EFP': ProductDetails(
    name: 'Frontier® Perchloric Acid',
    specifications: [
      'ASHRAE 110-2016 compliant',
      'Tri-wall construction',
      'Ideal when handling hot perchloric acid and nitric acid',
      'Built with seamless stainless steel interior chamber',
      'Equipped with a wash down system',
      'Has a scrubber as a compulsory accessory',
      'Available sizes: 4, 5, 6 and 8 ft',
    ],
  ),
  'EFF': ProductDetails(
    name: 'Frontier® Floor Mounted',
    specifications: [
      'ASHRAE 110 compliant',
      'Tri-wall construction',
      'Designed to provide comfortable space when dealing with large apparatus and containers of hazardous materials.',
      'Large internal height',
      'Available sizes: 4, 5, 6 and 8 ft',
    ],
  ),
  'EFI': ProductDetails(
    name: 'Frontier® Radioisotope',
    specifications: [
      'ASHRAE 110-2016 compliant',
      'Designed for handling radioactive materials',
      'Full stainless-steel interior for easy cleaning and decontamination',
      'Available sizes: 4, 5, 6 and 8 ft',
    ],
  ),
  'PPH': ProductDetails(
    name: 'Frontier® PPH',
    specifications: [
      'ASHRAE 110-2016 certified',
      'Highest level of protection and containment against highly corrosive acids',
      'Full polypropylene interior and exterior makes it metal free and suitable for trace metal analysis',
      'Available sizes: 4, 5, 6 and 8 ft',
    ],
  ),
};
