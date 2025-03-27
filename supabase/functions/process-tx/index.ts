// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

// Setup type definitions for built-in Supabase Runtime APIs
import "jsr:@supabase/functions-js/edge-runtime.d.ts";

import {
  type ERC20TransferData,
  type ERC1152TransferData,
  formatERC20TransactionValue,
  getCommunityConfigsFromUrl,
} from "../_citizen-wallet/index.ts";
import { getServiceRoleClient } from "../_db/index.ts";
import { type Transaction, upsertTransaction } from "../_db/transactions.ts";
import { upsertInteraction } from "../_db/interactions.ts";
import { ensureProfileExists } from "../_citizen-wallet/profiles.ts";
import { tokenTransferEventTopic, tokenTransferSingleEventTopic } from "npm:@citizenwallet/sdk";
import { createMemberId } from "../_db/profiles.ts";

/**
 * Example record: ERC20 Transfer
 * {
 *   "data": {
 *     "to": "0x5566D6D4Df27a6fD7856b7564F81266863Ba3ee8",
 *     "from": "0x20eC5EAF89C0e06243eE39674844BF77edB43fCc",
 *     "topic": "0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef",
 *     "value": "100000"
 *   },
 *   "dest": "0x5815E61eF72c9E6107b5c5A05FD121F334f7a7f1",
 *   "hash": "0xd3587bcb15230bdc9a2cf7f81641798f47d091d0a6b8277c0993d643e027e900",
 *   "nonce": 0,
 *   "value": "0",
 *   "sender": "",
 *   "status": "success",
 *   "tx_hash": "0x1b8f3931e81e1cf6a3215d4763de52df86deaa2215c77cc8c44381d5fe8861c8",
 *   "created_at": "2025-02-23T14:30:35",
 *   "updated_at": "2025-02-23T14:30:36.349932"
 * }
 */

/**
 * Example record: ERC1152 Transfer
 * {
 *   "data": {
 *     "id": "0",
 *     "to": "0xE8D5fc9dc2EacF6FCbB97E7F92049834643DEe44",
 *     "from": "0x3ec9eE367660fbC5ea95Ed72E31823d2f59e291F",
 *     "topic": "0xc3d58168c5ae7397731d063d5bbf3d657854427343f4c083240f7aacaa2d0f62",
 *     "amount": "1",
 *     "operator": "0x3ec9eE367660fbC5ea95Ed72E31823d2f59e291F"
 *   },
 *   "dest": "0x56744910f7dEcD48c1a7FA61B4C317b15E99F156",
 *   "hash": "0xd3587bcb15230bdc9a2cf7f81641798f47d091d0a6b8277c0993d643e027e900",
 *   "nonce": 0,
 *   "value": "0",
 *   "sender": "",
 *   "status": "success",
 *   "tx_hash": "0x1b8f3931e81e1cf6a3215d4763de52df86deaa2215c77cc8c44381d5fe8861c8",
 *   "created_at": "2025-02-23T14:30:35",
 *   "updated_at": "2025-02-23T14:30:36.349932"
 * }
 */

const chainId = Deno.env.get("CHAIN_ID");

Deno.serve(async (req) => {
  const { record } = await req.json();

  console.log("record", record);

  if (!record || typeof record !== "object") {
    return new Response("Invalid record data", { status: 400 });
  }

  const {
    hash,
    tx_hash,
    created_at,
    updated_at,
    dest,
    status,
    data,
  } = record;

    let transferData: ERC20TransferData | ERC1152TransferData ;
  if (dest === '0x56744910f7dEcD48c1a7FA61B4C317b15E99F156') {
    transferData = data as ERC1152TransferData;
  } else {
    transferData = data as ERC20TransferData;
  }

  if (!dest || typeof dest !== "string") {
    return new Response(
      "Destination address is required and must be a string",
      { status: 400 },
    );
  }

   const skipTransfer = transferData.topic !== tokenTransferEventTopic || transferData.topic !== tokenTransferSingleEventTopic;

  if (skipTransfer) {
    return new Response("Not ERC20 or ERC1152 transfer, skip", { status: 200 });
  }

  const tokenContract = dest;

  const communityConfigs = await getCommunityConfigsFromUrl();

  if (communityConfigs.length === 0) {
    return new Response("No community configs found", { status: 400 });
  }

  const communitiesWithDest = communityConfigs.filter((config) =>
    config.community.primary_token.address === tokenContract && config.primaryToken.chain_id === parseInt(chainId ?? "0")
  );

  if (communitiesWithDest.length === 0) {
    return new Response(
      `No community found with token contract ${tokenContract}`,
      {
        status: 400,
      },
    );
  }

  // Initialize Supabase client
  const supabaseClient = getServiceRoleClient();

  for (const community of communitiesWithDest) {
    await ensureProfileExists(
      supabaseClient,
      community,
      transferData.from,
    );
    await ensureProfileExists(supabaseClient, community, transferData.to);
  }

  const firstCommunity = communitiesWithDest[0];


  let value: string;

  if ("value" in transferData) {
    value = transferData.value;
  } else if ("amount" in transferData) {
    value = transferData.amount;
  } else {
    value = '';
  }

  const formattedValue = formatERC20TransactionValue(
    firstCommunity,
    value,
  );

  const profileContract = firstCommunity.community.profile.address;

  const transaction: Transaction = {
    id: hash,
    hash: tx_hash,
    from_member_id: createMemberId(transferData.from, profileContract),
    to_member_id: createMemberId(transferData.to, profileContract),
    token_contract: tokenContract,
    value: formattedValue,
    status: status,
    created_at,
    updated_at,
  };

  const { error } = await upsertTransaction(supabaseClient, transaction);

  if (error) {
    console.error("Error inserting transaction:", error);
  }

  await upsertInteraction(
    supabaseClient,
    transaction,
  );

  return new Response("transaction processed", { status: 200 });
});

/* To invoke locally:

  1. Run `supabase start` (see: https://supabase.com/docs/reference/cli/supabase-start)
  2. Make an HTTP request:

  curl -i --location --request POST 'http://127.0.0.1:54321/functions/v1/notify-successful-transaction' \
    --header 'Authorization: Bearer ' \
    --header 'Content-Type: application/json' \
    --data '{"name":"Functions"}'

*/
