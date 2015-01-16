//
//  InfoViewController.m
//  CIDE
//
//  Created by Nayely Vergara on 16/01/15.
//  Copyright (c) 2015 Nayely Vergara. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@property (strong, nonatomic) NSArray *content;
@property (strong, nonatomic) NSArray *headers;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UITextView *contentTextView;

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *text1 = @"¿Está funcionando la reforma laboral?\n¿Resuelven las juntas los conflictos obrero patronales?\n¿Una sola ley produce criterios uniformes?\n\nEstas y otras interrogantes se abordan aquí y en el Foro de Justicia en el trabajo que se desarrolla el 22 de enero en la ciudad de Aguascalientes. \n\n¿Por qué es importante? \n\nEl taller, la fábrica, la oficina y otros centros de trabajo son campos propicios para que afloren problemas, conflictos y controversias.\n\nQuienes participan en el mundo laboral, el trabajador y el empleado, el patrón y el empleador, al igual que el administrador o gerente, tienen intereses encontrados y a menudo opuestos. En el proceso productivo desempeñan papeles bien delimitados en el que unos supervisan, exigen y controlan el trabajo de otros para lograr las metas y objetivos que permitirán competir, vender, ganar y expandir mercados. A menudo, la comunicación entre quienes participan en el proceso no es clara, frecuente ni oportuna y esto genera conflictos por no compartirse objetivos.\n\nLas unidades económicas requiren mecanismos ágiles, sencillos, poco costosos, pero sobre todo efectivos que canalicen y resuelvan con prontitud, certeza y transparencia las controversias que se dan en la oficina, la fábrica, el taller, y cualquier centro de trabajo. \n\nTe invitamos a compartir con el CIDE tus testimonios al utilizar o acercarte a la justicia en materia laboral en México. Estos testimonios nos permiten mapear problemáticas concretas y estar en condiciones de elaborar recomendaciones de mejora cercanas a la gente. \n\nTema: Justicia en el trabajo\nLugar: Aguascalientes\nFecha: 22 de enero de 2015";
    
    NSString *text2 = @"¿Qué tan conocidos y utilizados son los tribunales administrativos por los ciudadanos? \n¿Cómo lograr que los juicios administrativos sean más ágiles, sencillos y baratos? \n¿Qué procedimientos deben modificarse para hacer la justicia administrativa más cercana y útil a la gente? \n\nEstas y otras interrogantes se abordan aquí y en el Foro de Justicia para ciudadanos que se desarrolla el 29 de enero en la ciudad de Guanajuato. \n\n¿Por qué es importante? \n\nUna multa o clausura injustas, una licitación alejada de la ley o el mal mantenimiento de las calles, son ejemplos de actos de autoridad que se pueden combatir ante un Tribunal Contencioso Administrativo.\n\nLos juicios ante estos tribunales buscan solucionar los conflictos entre el Estado y los ciudadanos, a quienes se les brinda la posibilidad obtener un trato justo y asegurar una reparación adecuada de los agravios causados.\n\nCuando existe certeza sobre la aplicación del derecho, hay confianza en el funcionamiento de las instituciones. La justicia accesible, oportuna y las resoluciones respetadas, son un claro indicador de que se vive en un Estado de derecho. Ello resulta en garantía a la ciudadanía para poder resolver los conflictos directamente con la propia autoridad, así como para acudir a los tribunales contenciosos administrativos y obtener remedios efectivos en contra de abusos en el ejercicio del poder.\n\nSin embargo, la justicia administrativa no escapa a los problemas que enfrentan otros tipos de mecanismos judiciales, por lo que es recomendable preguntarse, de manera crítica, qué vale la pena cambiar para mejorar. \n\nTe invitamos a compartir con el CIDE tus testimonios al utilizar o acercarte a la justicia en materia administrativa en México. Estos testimonios nos permiten mapear problemáticas concretas y estar en condiciones de elaborar recomendaciones de mejora cercanas a la gente. \n\nTema: Justicia para ciudadanos\nLugar: Guanajuato\nFecha: 29 de enero de 2015";
    
    NSString *text3 = @"¿En qué casos se puede y debe simplificar la legislación en materia de justicia familiar? \n¿Cuándo es necesario utilizar sistemas alternativos de solución de conflictos?\n¿Se requieren nuevas políticas públicas para la justicia familiar en México?\n\nEstas y otras interrogantes se abordan aquí y en el “Foro de Justicia para familias” que se desarrolla el 4 de febrero en la ciudad de Tijuana. \nEl Foro “Justicia para familias” busca discutir problemáticas e identificar fórmulas sencillas para mantener el equilibrio y la cohesión familiar.\n¿Por qué es importante?\nDivorcio: Después del DF, al menos 8 entidades tienen la figura del divorcio incausado o sin causales, que en los hechos ha mostrado gran utilidad práctica.\nAlimentos: Los juicios siguen siendo largos y el deudor alimentario tiene vías para evitar el cumplimiento de obligaciones.\nSucesiones: Indispensable resolver problemas de sucesiones en familias de escasos recursos.\nAdopción: Los trámites de adopción son largos y engorrosos, por ello deben analizarse de manera tal que faciliten los procesos de los estudios psicológicos y económicos que ayudan a determinar la idoneidad de la adopción. \nInterdicción y tutela: Requerirá una revisión profunda para dar alternativas viables a personas que en los hechos pueden ser inexistentes jurídicamente por lo complejo del nombramiento de un tutor. \nViolencia intrafamiliar: Es mucho lo que se puede proponer para ayudar a personas que sufren violencia y que no encuentran actualmente cauce idóneo, oportuno y eficaz de protección.\nTe invitamos a compartir con el CIDE tus testimonios al utilizar o acercarte a la justicia en materia familiar en México. Estos testimonios nos permiten mapear problemáticas concretas y estar en condiciones de elaborar recomendaciones de mejora cercanas a la gente. \nTema: Justicia para familias\nLugar: Tijuana\nFecha: 4 de febrero de 2015";
    
    NSString *text4 = @"¿Cuáles son los conflictos más comunes a los que se enfrentan los emprendedores de nuestro país? \n¿Se resuelven o no? ¿Cómo? ¿A qué costos? \n¿Qué se podría hacer para que la resolución de conflictos propios de la actividad empresarial fuese rápida, accesible y eficaz?\n\nEstas y otras interrogantes se abordan aquí y en el “Foro de Justicia para emprendedores” que se desarrolla el 12 de febrero en la ciudad de Monterrey. \n\n¿Por qué es importante? \n\nLos conflictos a los que se enfrentan los empresarios son de muchos tipos y en varios ámbitos:\n\nEs muy común que tengan que lidiar con la extorsión y la “mordida” por parte de las autoridades administrativas.  \nEn el ámbito laboral, un pleito mal llevado puede significar la quiebra del negocio. \nTratándose de conflictos mercantiles, el cobro de deudas de montos menores es prácticamente incosteable con el sistema de justicia actual. Todo está diseñado para tener que contratar un abogado y, durante el proceso, tener que dar muchas propinas en el juzgado: al actuario, al secretario, al que saca las copias, etcétera.\n\nEl objetivo de este foro es conocer a fondo las características de los conflictos a los que se enfrentan los empresarios en México con más frecuencia y las limitaciones del sistema de justicia para resolverlos.\n\nTe invitamos a compartir con el CIDE tus testimonios al utilizar o acercarte a la justicia en materia familiar en México. Estos testimonios nos permiten mapear problemáticas concretas y estar en condiciones de elaborar recomendaciones de mejora cercanas a la gente. \n\nTema: Justicia para emprendedores\nLugar: Monterrey\nFecha: 12 de febrero de 2015";
    
    NSString *text5 = @"¿Cuáles son los conflictos más comunes en los espacios de convivencia? \n¿Qué mecanismos garantizan una rápida y eficaz resolución de problemas entre vecinos?\n¿Cómo mejorar la justicia de proximidad? \n\nEstas y otras interrogantes se abordan aquí y en el “Foro de Justicia vecinal y comunitaria” que se desarrolla el 19 de febrero en la ciudad de Tuxtla Gutiérrez. \n\n¿Por qué es importante?\n\nLos conflictos comunitarios y vecinales representan un área sensible y compleja del mundo social. Prácticamente en todos los espacios de convivencia, ya sean rurales o urbanos, el conflicto representa un aspecto constitutivo de la vida cotidiana.\n\nDisputas por el espacio y el uso de suelo, problemas sobre basura y contaminación auditiva en barrios y condominios, pleitos entre automovilistas por el derecho de paso o litigios entre autoridades y vecinos son, tan solo, una mínima lista del conjunto de interacciones sociales de carácter conflictivo que se presentan cotidianamente en la sociedad.\n\nSe entiende por conflicto vecinal a un tipo particular de relaciones sociales que es el resultado de la convergencia espacio-temporal de intereses incompatibles [razones del conflicto] entre dos o más actores [partes del conflicto] con respecto a los usos o localización de un pedazo concreto del territorio habitado [componente geográfico del conflicto]. \n\nEl Foro de Justicia vecinal y comunitaria busca identificar cómo mejorar los mecanismos de mediación y conciliación entre vecinos, acercar la justicia a las comunidades y prevenir la violencia en espacios o territorios específicos. \n\nTe invitamos a compartir con el CIDE tus testimonios al utilizar o acercarte a la justicia vecinal o comunitaria en México. Estos testimonios nos permiten mapear problemáticas concretas y estar en condiciones de elaborar recomendaciones de mejora cercanas a la gente. \n\nTema: Justicia vecinal y comunitaria\nLugar: Tuxtla Gutiérrez\nFecha: 19 de febrero de 2015";
    
    NSString *text6 = @"Los abusos e injusticias suceden en numerosos ámbitos y es fundamental conocerlos, entenderlos y modificarlos. \n\nDesde la resolución de conflictos agrarios, la necesidad de mejorar la capacitación de jueces y defensores, hasta la protección de consumidores y de usuarios del sistema bancario son otros temas de justicia cotidiana que requieren especial atención y consulta. \n\nLos temas que se abordan en el Foro “Otras Justicias” son:\n\nProtección a consumidores\nSistema bancario\nJusticia agraria\n\nTe invitamos a compartir con el CIDE tus testimonios al utilizar o acercarte a la justicia en materia agraria, bancaria o de protección a consumidores en México. Estos testimonios nos permiten mapear problemáticas concretas y estar en condiciones de elaborar recomendaciones de mejora cercanas a la gente. Consensado Consensuado \n\nTema: Justicia para consumidores, campesinos y usuarios de la banca\nLugar: Ciudad de México\nFecha: 26 de febrero de 2015";
    
    NSString *header1 = @"Justicia en el trabajo";
    NSString *header2 = @"Justicia para ciudadanos";
    NSString *header3 = @"Justicia para familias";
    NSString *header4 = @"Justicia para emprendedores";
    NSString *header5 = @"Justicia vecinal y comunitaria";
    NSString *header6 = @"Otros temas de Justicia Cotidiana";
    
    self.content = @[text1, text2, text3, text4, text5, text6];
    self.headers = @[header1, header2, header3, header4, header5, header6];
    
    self.titleLabel.text = self.headers[self.option];
    self.contentTextView.text = self.content[self.option];
    
    self.titleLabel.font = [UIFont fontWithName:@"SourceSansPro-Regular" size:18.0];
    self.contentTextView.font = [UIFont fontWithName:@"SourceSansPro-Regular" size:14.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
