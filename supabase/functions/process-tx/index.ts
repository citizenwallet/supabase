// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

// Setup type definitions for built-in Supabase Runtime APIs
import "jsr:@supabase/functions-js/edge-runtime.d.ts";

import {
  communityConfig,
  type ERC20TransferData,
  formatERC20TransactionValue,
} from "../_citizen-wallet/index.ts";
import { getServiceRoleClient } from "../_db/index.ts";
import { type Transaction, upsertTransaction } from "../_db/transactions.ts";
import { upsertInteraction } from "../_db/interactions.ts";
import { ensureProfileExists } from "../_citizen-wallet/profiles.ts";


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

  if (!dest || typeof dest !== "string") {
    return new Response(
      "Destination address is required and must be a string",
      { status: 400 },
    );
  }

  const community = communityConfig();

  if (dest.toLowerCase() !== community.primaryToken.address.toLowerCase()) {
    return new Response("Only process primary token transfers", {
      status: 200,
    });
  }

  // Initialize Supabase client
  const supabaseClient = getServiceRoleClient();

  const erc20TransferData = data as ERC20TransferData;

  await ensureProfileExists(supabaseClient, community, erc20TransferData.from);
  await ensureProfileExists(supabaseClient, community, erc20TransferData.to);

  const formattedValue = formatERC20TransactionValue(
    community,
    erc20TransferData.value,
  );

  // insert transaction into db
  const transaction: Transaction = {
    id: hash,
    hash: tx_hash,
    created_at,
    updated_at,
    from: erc20TransferData.from,
    to: erc20TransferData.to,
    value: formattedValue,
    status: status,
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
