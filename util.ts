/**
 * A function that takes a SUI network URL and identifies the network type.
 * @param {string} url The SUI network URL.
 * @returns {"testnet" | "devnet" | "mainnet"} The identified network or "unknown" if no match is found.
 * @example
 * const suiNetworkUrl = "https://fullnode.testnet.sui.io:443";
 * const networkType = returnNetwork(suiNetworkUrl); // Returns: "testnet"
 */
export const returnNetwork = (url: string): "testnet" | "devnet" | "mainnet" => {
  // Check for the presence of each network name in the URL string.
  // Using .toLowerCase() makes the function case-insensitive.
  const lowerCaseUrl = url.toLowerCase();

  if (lowerCaseUrl.includes("testnet")) {
    return "testnet";
  } else if (lowerCaseUrl.includes("devnet")) {
    return "devnet";
  } else if (lowerCaseUrl.includes("mainnet")) {
    return "mainnet";
  } else {
    return "testnet";
  }
}