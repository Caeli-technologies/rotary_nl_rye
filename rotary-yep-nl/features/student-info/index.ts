/**
 * Student Info Feature - Public API
 *
 * This module provides components and content for displaying
 * information pages for inbound and outbound exchange students.
 */

// Components
export {
  InfoPage,
  ContentSection,
  ContentCard,
  HighlightGrid,
  TipCard,
  TimelineCard,
  VideoPlayer,
  MenuList,
  ProgramHub,
} from "./components";

// Content - Inbound
export {
  welcomeContent,
  flightArrivalContent,
  languageContent,
  insuranceContent,
  travelContent,
} from "./content/inbound/long-term";

// Content - Outbound
export {
  howToSignUpContent,
  selectionDayContent,
  selectionWeekendContent,
  top3CountriesContent,
  complyWithContent,
} from "./content/outbound/long-term";

// Types
export type {
  IconName,
  AccentColor,
  PageHeader,
  TextBlock,
  CardBlock,
  HighlightItem,
  HighlightBlock,
  TimelineItem,
  TimelineBlock,
  GridItem,
  GridBlock,
  TipItem,
  TipBlock,
  VideoBlock,
  CTABlock,
  ContentBlock,
  Section,
  InfoPageContent,
  MenuItem,
  MenuSection,
  HubPageContent,
  StudentInfoType,
  ProgramType,
} from "./types";
