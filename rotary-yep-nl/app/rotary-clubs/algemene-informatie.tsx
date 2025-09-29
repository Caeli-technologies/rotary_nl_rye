import React from 'react';
import { 
  StyleSheet, 
  View, 
  Text, 
  ScrollView, 
  TouchableOpacity,
  Platform
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { router } from 'expo-router';
import { StatusBar } from 'expo-status-bar';

interface InfoSectionProps {
  title: string;
  content: string;
}

function InfoSection({ title, content }: InfoSectionProps) {
  return (
    <View style={styles.infoSection}>
      <Text style={styles.sectionTitle}>{title}</Text>
      <Text style={styles.sectionContent}>{content}</Text>
    </View>
  );
}

export default function AlgemeneInformatieScreen() {
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
    <SafeAreaView style={styles.container} edges={['top']}>
      <StatusBar style="auto" />
      <View style={styles.header}>
        <TouchableOpacity 
          style={styles.backButton} 
          onPress={() => router.back()}
          hitSlop={{ top: 10, bottom: 10, left: 10, right: 10 }}
        >
          <Ionicons 
            name={Platform.OS === 'ios' ? 'chevron-back' : 'arrow-back'} 
            size={Platform.OS === 'ios' ? 28 : 24} 
            color={Platform.OS === 'ios' ? '#007AFF' : '#1A237E'} 
          />
        </TouchableOpacity>
        <Text style={styles.headerTitle}>Algemene Informatie</Text>
        <View style={styles.placeholder} />
      </View>

      <ScrollView 
        style={styles.scrollView}
        showsVerticalScrollIndicator={false}
        contentInsetAdjustmentBehavior="automatic"
      >
        <View style={styles.content}>
          {infoSections.map((section, index) => (
            <InfoSection
              key={index}
              title={section.title}
              content={section.content}
            />
          ))}
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: Platform.OS === 'ios' ? '#F2F2F7' : '#F5F5F5',
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingHorizontal: 20,
    paddingVertical: Platform.OS === 'ios' ? 15 : 12,
    backgroundColor: Platform.OS === 'ios' ? '#F8F9FA' : '#FFFFFF',
    ...Platform.select({
      ios: {
        shadowColor: '#000',
        shadowOffset: { width: 0, height: 1 },
        shadowOpacity: 0.1,
        shadowRadius: 1,
      },
      android: {
        elevation: 2,
      },
    }),
  },
  backButton: {
    width: Platform.OS === 'ios' ? 32 : 40,
    height: Platform.OS === 'ios' ? 32 : 40,
    borderRadius: Platform.OS === 'ios' ? 16 : 20,
    backgroundColor: Platform.OS === 'ios' ? 'transparent' : '#F5F5F5',
    alignItems: 'center',
    justifyContent: 'center',
  },
  headerTitle: {
    fontSize: Platform.OS === 'ios' ? 17 : 18,
    fontWeight: Platform.OS === 'ios' ? '600' : 'bold',
    color: Platform.OS === 'ios' ? '#000' : '#1A237E',
    textAlign: 'center',
    flex: 1,
  },
  placeholder: {
    width: 40,
  },
  scrollView: {
    flex: 1,
  },
  content: {
    padding: Platform.OS === 'ios' ? 16 : 20,
  },
  infoSection: {
    backgroundColor: '#fff',
    borderRadius: Platform.OS === 'ios' ? 10 : 8,
    padding: Platform.OS === 'ios' ? 16 : 20,
    marginBottom: Platform.OS === 'ios' ? 10 : 16,
    ...Platform.select({
      ios: {
        shadowColor: '#000',
        shadowOffset: { width: 0, height: 1 },
        shadowOpacity: 0.05,
        shadowRadius: 2,
      },
      android: {
        elevation: 1,
      },
    }),
  },
  sectionTitle: {
    fontSize: Platform.OS === 'ios' ? 20 : 18,
    fontWeight: Platform.OS === 'ios' ? '600' : 'bold',
    color: Platform.OS === 'ios' ? '#000' : '#1A237E',
    marginBottom: Platform.OS === 'ios' ? 8 : 12,
    lineHeight: Platform.OS === 'ios' ? 26 : 24,
  },
  sectionContent: {
    fontSize: Platform.OS === 'ios' ? 16 : 15,
    lineHeight: Platform.OS === 'ios' ? 22 : 20,
    color: Platform.OS === 'ios' ? '#3C3C43' : '#333',
    textAlign: 'left',
  },
});