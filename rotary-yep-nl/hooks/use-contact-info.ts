import { useMemo } from "react";
import type { Contact, Organization, Rotex } from "@/types/contact";

// Type guards
export const isOrganization = (
	contact: Contact | Organization | Rotex,
): contact is Organization => {
	return "club" in contact || "district" in contact;
};

export const isRotex = (
	contact: Contact | Organization | Rotex,
): contact is Rotex => {
	return "socialMedia" in contact;
};

export const useContactInfo = (contact: Contact | Organization | Rotex) => {
	return useMemo(() => {
		const isOrgType = isOrganization(contact);
		const isRotexType = isRotex(contact);
		const orgContact = isOrgType ? (contact as Organization) : null;

		return {
			isOrg: isOrgType,
			isRotex: isRotexType,
			primaryFunction:
				contact.functions?.find((func) => func && func.trim() !== "") || "",
			hasContact: !!(
				(contact.email && contact.email.trim() !== "") ||
				(contact.phoneNumber && contact.phoneNumber.trim() !== "")
			),
			hasBio: !!contact.bio?.trim(),
			hasSocial:
				isRotexType &&
				(contact as Rotex).socialMedia &&
				Object.values((contact as Rotex).socialMedia || {}).some(
					(url) => url && url.trim() !== "",
				),
			hasOrgInfo:
				isOrgType &&
				!!(
					(orgContact?.club && orgContact.club.trim() !== "") ||
					(orgContact?.district && orgContact.district.trim() !== "")
				),
		};
	}, [contact]);
};
