import { SuiObjectResponse } from '@mysten/sui/client'

export interface Hero {
	id: string
	health: string
	stamina: string
}

interface HeroContent {
	fields: {
		id: { id: string }
		health: string
		stamina: string
	}
	dataType: string
	type: string
	hasPublicTransfer: boolean
}

/**
 * Parses the content of a hero object in a SuiObjectResponse.
 * Maps it to a Hero object.
 */
export const parseHeroContent = (objectResponse: SuiObjectResponse): Hero => {
	const objectContent = objectResponse?.data?.content as HeroContent
	return {
		id: objectContent?.fields?.id.id,
		health: objectContent?.fields.health,
		stamina: objectContent?.fields.stamina,
	}
}
