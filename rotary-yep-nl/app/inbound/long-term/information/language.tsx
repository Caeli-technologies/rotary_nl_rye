import { StyleSheet, View, Text, ScrollView, Platform } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { Ionicons } from "@expo/vector-icons";
import { useTheme } from "@/hooks/use-theme";

export default function LanguageScreen() {
  const { colors: themeColors } = useTheme();

  return (
    <SafeAreaView
      style={[styles.container, { backgroundColor: themeColors.background }]}
      edges={["bottom"]}
    >
      <ScrollView
        style={styles.scrollView}
        showsVerticalScrollIndicator={false}
        contentInsetAdjustmentBehavior="automatic"
      >
        <View style={styles.content}>
          {/* Header Section */}
          <View style={styles.headerSection}>
            <View
              style={[
                styles.headerIcon,
                { backgroundColor: `${themeColors.primary}15` },
              ]}
            >
              <Ionicons
                name="chatbubble-outline"
                size={32}
                color={themeColors.primary}
              />
            </View>
            <Text style={[styles.headerTitle, { color: themeColors.text }]}>
              Language
            </Text>
            <Text
              style={[
                styles.headerSubtitle,
                { color: themeColors.textSecondary },
              ]}
            >
              Learning Dutch for a successful exchange experience
            </Text>
          </View>

          {/* Language Challenge */}
          <View style={styles.section}>
            <View
              style={[
                styles.challengeCard,
                {
                  backgroundColor: themeColors.card,
                  shadowColor: themeColors.shadow,
                  borderLeftColor: themeColors.secondary,
                },
              ]}
            >
              <View style={styles.challengeHeader}>
                <Ionicons
                  name="trending-up-outline"
                  size={24}
                  color={themeColors.secondary}
                />
                <Text
                  style={[styles.challengeTitle, { color: themeColors.text }]}
                >
                  The Challenge
                </Text>
              </View>
              <Text style={[styles.challengeText, { color: themeColors.text }]}>
                There&apos;s no hiding it: Dutch is a very difficult language to
                learn. However, we do expect you to master the language and that
                within months after your arrival you will be fluent in our
                language.
              </Text>
            </View>
          </View>

          {/* DOC Course */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons
                name="school-outline"
                size={24}
                color={themeColors.primary}
              />
              <Text style={[styles.sectionTitle, { color: themeColors.text }]}>
                Dutch Orientation Course (DOC)
              </Text>
            </View>

            <View
              style={[
                styles.docCard,
                {
                  backgroundColor: themeColors.card,
                  shadowColor: themeColors.shadow,
                },
              ]}
            >
              <View style={styles.docDetails}>
                <View style={styles.docItem}>
                  <Ionicons
                    name="calendar-outline"
                    size={16}
                    color={themeColors.info}
                  />
                  <Text style={[styles.docText, { color: themeColors.text }]}>
                    September (August group) & February (new arrivals)
                  </Text>
                </View>
                <View style={styles.docItem}>
                  <Ionicons
                    name="time-outline"
                    size={16}
                    color={themeColors.info}
                  />
                  <Text style={[styles.docText, { color: themeColors.text }]}>
                    6 days intensive course
                  </Text>
                </View>
                <View style={styles.docItem}>
                  <Ionicons
                    name="people-outline"
                    size={16}
                    color={themeColors.info}
                  />
                  <Text style={[styles.docText, { color: themeColors.text }]}>
                    Small groups with fellow exchange students
                  </Text>
                </View>
                <View style={styles.docItem}>
                  <Ionicons
                    name="globe-outline"
                    size={16}
                    color={themeColors.info}
                  />
                  <Text style={[styles.docText, { color: themeColors.text }]}>
                    Language learning + cultural insights
                  </Text>
                </View>
              </View>
              <Text
                style={[
                  styles.docNote,
                  {
                    color: themeColors.primary,
                    borderTopColor: themeColors.border,
                  },
                ]}
              >
                Lots of fun included with students from around the world!
              </Text>
            </View>
          </View>

          {/* Host Family Support */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons
                name="home-outline"
                size={24}
                color={themeColors.primary}
              />
              <Text style={[styles.sectionTitle, { color: themeColors.text }]}>
                Host Family Support
              </Text>
            </View>

            <View
              style={[
                styles.supportCard,
                {
                  backgroundColor: themeColors.card,
                  shadowColor: themeColors.shadow,
                  borderLeftColor: themeColors.success,
                },
              ]}
            >
              <View style={styles.supportHeader}>
                <Ionicons
                  name="heart-outline"
                  size={20}
                  color={themeColors.success}
                />
                <Text
                  style={[styles.supportTitle, { color: themeColors.text }]}
                >
                  Your Learning Partners
                </Text>
              </View>
              <Text style={[styles.supportText, { color: themeColors.text }]}>
                Your first host family will also help you to learn Dutch and you
                will receive books to start learning the language as soon as you
                are in the Netherlands.
              </Text>
            </View>
          </View>
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  scrollView: {
    flex: 1,
  },
  content: {
    padding: 16,
    paddingBottom: 34,
  },

  // Header Section
  headerSection: {
    alignItems: "center",
    paddingVertical: 24,
    marginBottom: 32,
  },
  headerIcon: {
    width: 80,
    height: 80,
    borderRadius: 40,
    justifyContent: "center",
    alignItems: "center",
    marginBottom: 16,
  },
  headerTitle: {
    fontSize: Platform.OS === "ios" ? 28 : 24,
    fontWeight: Platform.OS === "ios" ? "700" : "600",
    textAlign: "center",
    marginBottom: 8,
  },
  headerSubtitle: {
    fontSize: 16,
    textAlign: "center",
    lineHeight: 22,
    paddingHorizontal: 20,
  },

  // Section Styles
  section: {
    marginBottom: 24,
  },
  sectionHeader: {
    flexDirection: "row",
    alignItems: "center",
    marginBottom: 16,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: "600",
    marginLeft: 12,
  },

  // Challenge Card
  challengeCard: {
    borderRadius: 16,
    padding: 20,
    marginBottom: 16,
    borderLeftWidth: 4,
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.08,
    shadowRadius: 20,
    elevation: 4,
  },
  challengeHeader: {
    flexDirection: "row",
    alignItems: "center",
    marginBottom: 12,
  },
  challengeTitle: {
    fontSize: 18,
    fontWeight: "600",
    marginLeft: 8,
  },
  challengeText: {
    fontSize: 16,
    lineHeight: 24,
  },

  // DOC Card
  docCard: {
    borderRadius: 16,
    padding: 20,
    marginBottom: 16,
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.08,
    shadowRadius: 20,
    elevation: 4,
  },
  docDetails: {
    marginBottom: 16,
  },
  docItem: {
    flexDirection: "row",
    alignItems: "center",
    marginBottom: 12,
  },
  docText: {
    fontSize: 14,
    marginLeft: 8,
    flex: 1,
  },
  docNote: {
    fontSize: 14,
    fontStyle: "italic",
    textAlign: "center",
    paddingTop: 12,
    borderTopWidth: 1,
    fontWeight: "500",
  },

  // Support Card
  supportCard: {
    borderRadius: 16,
    padding: 20,
    marginBottom: 16,
    borderLeftWidth: 4,
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.08,
    shadowRadius: 20,
    elevation: 4,
  },
  supportHeader: {
    flexDirection: "row",
    alignItems: "center",
    marginBottom: 12,
  },
  supportTitle: {
    fontSize: 16,
    fontWeight: "600",
    marginLeft: 8,
  },
  supportText: {
    fontSize: 16,
    lineHeight: 24,
  },
});
