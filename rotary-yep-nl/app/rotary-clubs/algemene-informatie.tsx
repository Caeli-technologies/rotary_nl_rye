import React, { useCallback } from 'react';
import { 
  StyleSheet, 
  View, 
  Text, 
  ScrollView
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { StatusBar } from 'expo-status-bar';

interface InfoSectionProps {
  title: string;
  content: string;
}

const InfoSection = React.memo(({ title, content }: InfoSectionProps) => {
  return (
    <View style={styles.infoSection}>
      <Text style={styles.sectionTitle}>{title}</Text>
      <Text style={styles.sectionContent}>{content}</Text>
    </View>
  );
});

export default function AlgemeneInformatieScreen() {
  const renderInfoSection = useCallback((section: { title: string; content: string }, index: number) => (
    <InfoSection
      key={index}
      title={section.title}
      content={section.content}
    />
  ), []);

  const infoSections = [
    {
      title: 'Sponsoring - wat houdt het in?',
      content: 'Het is de bedoeling dat een Rotary club als sponsor optreedt voor een scholier die graag als ambassadeur van Rotary International een schooljaar naar het buitenland uitgezonden wil worden. Dit is mogelijk voor alle jongeren, zowel uit Rotary als uit niet-Rotary gezinnen. In datzelfde jaar ontvangt de club een buitenlandse scholier in haar midden. Deze gaat hier naar school met leeftijdsgenoten en wordt tijdens het jaar bij twee tot maximaal vier gastgezinnen ondergebracht.\n\nLeeftijd - voor de uitzending en ontvangst van de scholier gelden indicatieve leeftijdsgrenzen. In principe is dit 15½ - 18½ jaar.'
    },
    {
      title: 'De uitwisseling',
      content: 'De uitwisseling vindt plaats op basis van wederkerigheid. Dit wil zeggen dat elke Rotary club die een scholier uitzendt, in hetzelfde jaar een het jaarkind ontvangt. Deze scholier wordt tijdens het jaar bij diverse gastgezinnen ondergebracht. De club bezoekt tevoren de gastgezinnen.'
    },
    {
      title: 'Kosten',
      content: 'Voor sponsoring van een Nederlandse scholier naar het buitenland zijn er geen kosten verbonden voor jullie club. Wel zijn er kosten voor de ontvangst van een jaarstudent. (Dit programma is op basis van wederkerigheid, dus het een kan niet zonder het ander plaatsvinden).\n\nDe maximaal totale kosten die hiermee gemoeid zijn voor jullie club bedragen € 2.000,-- voor een heel schooljaar/uitwisselingsjaar. De landelijke Rotary-organisatie MDJC vindt het Rotary uitwisselingsprogramma zo belangrijk, dat zij een tegemoetkoming in de kosten (subsidie) van € 1.250,-- betalen voor elke club die wil hosten. Dat betekent dat de feitelijke kosten voor jullie club voor een heel jaar dan nog maximaal € 750,- bedragen.'
    },
    {
      title: 'Gastgezinnen',
      content: 'De CJC zoekt samen met de student die uitgezonden wil worden naar drie gastgezinnen en een reservegezin. Het is prettig als er kinderen van dezelfde leeftijd in het gezin zijn, maar dat is beslist niet noodzakelijk. In gezinnen met kinderen van dezelfde leeftijd krijgen ze eerder aansluiting met leeftijdsgenoten, maar oudere echtparen zijn vaak fantastische gastouders en in gezinnen met kleine kinderen leren de studenten vaak eerder onze taal.\n\nSamenwerking met een andere Rotary club is dan mogelijk een leuke optie en biedt meer mogelijkheden voor het vinden van gastgezinnen.\n\nOm je als club goed te informeren (of te enthousiasmeren) over het meedoen aan deze jaaruitwisseling zijn er oud-exchange studenten in Nederland die graag over hun ervaringen komen vertellen. Daarnaast kun je als club ook meer informatie opvragen bij de leden van MDJC of je eigen District Jeugd Commissaris.'
    }
  ];

  return (
    <SafeAreaView style={styles.safeArea} edges={['bottom']}>
      <StatusBar style="auto" />
      <View style={styles.container}>
        <ScrollView 
          style={styles.scrollView}
          contentContainerStyle={styles.scrollContent}
          showsVerticalScrollIndicator={false}
          contentInsetAdjustmentBehavior="automatic"
        >
          {infoSections.map(renderInfoSection)}
        </ScrollView>
      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  safeArea: {
    flex: 1,
    backgroundColor: '#F2F2F7',
  },
  container: {
    flex: 1,
  },
  scrollView: {
    flex: 1,
  },
  scrollContent: {
    padding: 16,
    paddingBottom: 34,
  },
  infoSection: {
    backgroundColor: '#FFFFFF',
    borderRadius: 12,
    padding: 16,
    marginBottom: 12,
    shadowColor: '#000000',
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.08,
    shadowRadius: 8,
    elevation: 2,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#000000',
    marginBottom: 12,
    lineHeight: 24,
  },
  sectionContent: {
    fontSize: 15,
    lineHeight: 22,
    color: '#3C3C43',
    textAlign: 'left',
  },
});