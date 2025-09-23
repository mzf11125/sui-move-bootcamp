import { SuiTransactionBlockResponse } from '@mysten/sui/client'
import { getSigner } from './getSigner'
import { ENV } from '../env'
import { Transaction } from '@mysten/sui/transactions'
import { suiClient } from '../suiClient'

/**
 * Builds, signs, and executes a transaction for:
 * * minting a Hero NFT: use the `package_id::hero::mint_hero` function
 * * minting a Sword NFT: use the `package_id::blacksmith::new_sword` function
 * * attaching the Sword to the Hero: use the `package_id::hero::equip_sword` function
 * * transferring the Hero to the signer
 */
export const mintHeroWithSword = async (): Promise<SuiTransactionBlockResponse> => {
	const signer = getSigner({ secretKey: ENV.USER_SECRET_KEY })
	const tx = new Transaction()
	tx.setGasBudget(1000000000)

	// Mint a Hero
	const hero = tx.moveCall({
		target: `${ENV.PACKAGE_ID}::hero::mint_hero`,
		arguments: [],
	})

	// Mint a Sword
	const sword = tx.moveCall({
		target: `${ENV.PACKAGE_ID}::blacksmith::new_sword`,
		arguments: [tx.pure.u64(100)],
	})

	// Equip the Sword to the Hero
	tx.moveCall({
		target: `${ENV.PACKAGE_ID}::hero::equip_sword`,
		arguments: [hero, sword],
	})

	// Transfer the Hero to the signer
	tx.transferObjects([hero], signer.toSuiAddress())

	const txResponse = suiClient.signAndExecuteTransaction({
		transaction: tx,
		signer,
		options: {
			showEffects: true,
			showObjectChanges: true,
			showEvents: true,
		},
	})

	return txResponse
}
