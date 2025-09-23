import { BalanceChange } from '@mysten/sui/client'
import { SUI_TYPE_ARG } from '@mysten/sui/utils'

interface Args {
	balanceChanges: BalanceChange[]
	senderAddress: string
	recipientAddress: string
}

interface Response {
	recipientSUIBalanceChange: number
	senderSUIBalanceChange: number
}

/**
 * Parses the balance changes as they are returned by the SDK.
 * Filters out and formats the ones that correspond to SUI tokens and to the defined sender and recipient addresses.
 */
export const parseBalanceChanges = ({ balanceChanges, senderAddress, recipientAddress }: Args): Response => {
	const recipientSUIBalanceChange = balanceChanges.find(({ owner, coinType }) => {
		const addressOwner = (owner as { AddressOwner: string }).AddressOwner
		return addressOwner === recipientAddress && coinType === SUI_TYPE_ARG
	})

	const senderSUIBalanceChange = balanceChanges.find(({ owner, coinType }) => {
		const addressOwner = (owner as { AddressOwner: string }).AddressOwner

		return addressOwner === senderAddress && coinType === SUI_TYPE_ARG
	})

	return {
		recipientSUIBalanceChange: parseInt(recipientSUIBalanceChange?.amount ?? '0'),
		senderSUIBalanceChange: parseInt(senderSUIBalanceChange?.amount ?? '0'),
	}
}
