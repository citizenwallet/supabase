// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

// Setup type definitions for built-in Supabase Runtime APIs
import "jsr:@supabase/functions-js/edge-runtime.d.ts";

import { sendNotification } from "../_firebase/index.ts";
import {
  createERC20TransferNotification,
  type ERC20TransferData,
  getCommunityConfigsFromUrl,
} from "../_citizen-wallet/index.ts";
import type { Profile } from "npm:@citizenwallet/sdk";
import { getServiceRoleClient } from "../_db/index.ts";
import { getTokensForAddress } from "../_db/tokens.ts";
import { getProfile } from "../_db/profiles.ts";
import { tokenTransferEventTopic } from "npm:@citizenwallet/sdk";

/**
 * Example record:
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

 const chainId = Deno.env.get("CHAIN_ID");

Deno.serve(async (req) => {
  const { record } = await req.json();

  console.log("record", record);

  if (!record || typeof record !== "object") {
    return new Response("Invalid record data", { status: 400 });
  }

  const { dest, status, data } = record;
  const erc20TransferData = data as ERC20TransferData;

  if (!dest || typeof dest !== "string") {
    return new Response(
      "Destination address is required and must be a string",
      { status: 400 },
    );
  }

  if (erc20TransferData.topic !== tokenTransferEventTopic) {
    return new Response("Not ERC20 transfer, skip", { status: 200 });
  }

  const tokenContract = dest.toLowerCase();

  const communityConfigs = await getCommunityConfigsFromUrl();

  if (communityConfigs.length === 0) {
    return new Response("No community configs found", { status: 400 });
  }

  const communitiesWithDest = communityConfigs.filter((config) =>
    config.community.primary_token.address.toLowerCase() === tokenContract.toLowerCase() && config.primaryToken.chain_id === parseInt(chainId ?? "0")
  );

  if (communitiesWithDest.length === 0) {
    return new Response(
      `No community found with token contract ${tokenContract}`,
      {
        status: 400,
      },
    );
  }

  if (status !== "success") {
    return new Response("Transaction status is not success, ignoring", {
      status: 200,
    });
  }

  // Initialize Supabase client
  const supabaseClient = getServiceRoleClient();

  const chainId = Deno.env.get("CHAIN_ID");
  if (!chainId) {
    return new Response("CHAIN_ID is required", { status: 500 });
  }

  // Fetch tokens for the destination address (contract interacted with)
  const { data: tokens, error } = await getTokensForAddress(
    supabaseClient,
    chainId,
    dest,
    erc20TransferData.to,
  );

  if (error) {
    console.error("Error fetching tokens:", error);
    return new Response("Error fetching tokens", { status: 500 });
  }

  if (!tokens || tokens.length === 0) {
    return new Response("No tokens found for the account", { status: 200 });
  }

  for (const community of communitiesWithDest) {
    let profile: Profile | undefined;
    const { data: profileData, error: profileError } = await getProfile(
      supabaseClient,
      erc20TransferData.from,
      community.community.profile.address,
    );

    if (profileError || !profileData) {
      console.error("Error fetching profile:", profileError);
    } else {
      profile = profileData;
    }

    const notification = createERC20TransferNotification(
      community,
      erc20TransferData,
      profile,
    );

    const message = {
      tokens: tokens.map((t) => t.token),
      notification,
      android: {
        priority: "high" as "high", // Ensure notifications are always sent with high priority
      },
      apns: {
        payload: {
          aps: {
            sound: "default", // Ensure notifications trigger a sound on iOS
          },
        },
      },
    };

    const failedTokens = await sendNotification(message);

    if (failedTokens.length > 0) {
      console.warn(
        "Failed to send notifications to some tokens:",
        failedTokens,
      );
    }
  }

  return new Response("notification sent", { status: 200 });
});

/* To invoke locally:

  1. Run `supabase start` (see: https://supabase.com/docs/reference/cli/supabase-start)
  2. Make an HTTP request:

  curl -i --location --request POST 'http://127.0.0.1:54321/functions/v1/notify-successful-transaction' \
    --header 'Authorization: Bearer ' \
    --header 'Content-Type: application/json' \
    --data '{"name":"Functions"}'

*/
