export { mdjcContacts } from "./mdjc";
export { rotexContacts } from "./rotex";
export { longTermContacts } from "./long-term";
export { shortTermContacts } from "./short-term";

import type { ContactSection } from "@/types/contact";
import { mdjcContacts } from "./mdjc";
import { rotexContacts } from "./rotex";
import { longTermContacts } from "./long-term";
import { shortTermContacts } from "./short-term";

export const contactSections: ContactSection[] = [
	{
		id: "mdjc",
		title: "MDJC",
		contacts: mdjcContacts,
	},
	{
		id: "longterm",
		title: "Long Term",
		contacts: longTermContacts,
	},
	{
		id: "shortterm",
		title: "Short Term",
		contacts: shortTermContacts,
	},
	{
		id: "rotex",
		title: "ROTEX",
		contacts: rotexContacts,
	},
];
