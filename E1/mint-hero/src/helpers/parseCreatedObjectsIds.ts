import { SuiObjectChange } from '@mysten/sui/client'

interface Args {
	objectChanges: SuiObjectChange[]
}

interface Response {
	swordsIds: string[]
	heroesIds: string[]
}

/**
 * Parses the provided SuiObjectChange[].
 * Extracts the IDs of the created Heroes and Swords NFTs, filtering by objectType.
 */
export const parseCreatedObjectsIds = ({ objectChanges }: Args): Response => {
	const heroesIds: string[] = []
	const swordsIds: string[] = []

	objectChanges.forEach((objectChange) => {
		if (objectChange.type === 'created') {
			const { objectId, objectType } = objectChange
			if (objectType.endsWith('::hero::Hero')) heroesIds.push(objectId)
			if (objectType.endsWith('::blacksmith::Sword')) swordsIds.push(objectId)
		}
	})
	return {
		swordsIds,
		heroesIds,
	}
}
