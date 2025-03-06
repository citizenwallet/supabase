// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

// Setup type definitions for built-in Supabase Runtime APIs
import "jsr:@supabase/functions-js/edge-runtime.d.ts";

import {
  communityConfig,
  type ERC20TransferExtraData,
} from "../_citizen-wallet/index.ts";
import { getServiceRoleClient } from "../_db/index.ts";
import {
  type TransactionWithDescription,
  upsertTransactionWithDescription,
} from "../_db/transactions.ts";
import { getLogByHash } from "../_db/logs.ts";

/**
 * Example record format:
 * {
 *   "data": {
 *     "description": "Test"
 *   },
 *   "hash": "0xd7f2946b1cd995324f17b5956f9d1f3b4e3e9c9429b56d2f9230788546edaad3",
 *   "created_at": "2025-03-05T16:07:18.771495",
 *   "updated_at": "2025-03-05T16:07:18.771495"
 * }
 */

Deno.serve(async (req) => {
  const { record } = await req.json();

  console.log("record", record);

  if (!record || typeof record !== "object") {
    return new Response("Invalid record data", { status: 400 });
  }

  const {
    hash,
    data,
  } = record;

  // Initialize Supabase client
  const supabaseClient = getServiceRoleClient();

  let erc20TransferExtraData: ERC20TransferExtraData = { description: "" };
  if (data) {
    erc20TransferExtraData = data as ERC20TransferExtraData;
  }

  // insert transaction into db
  const transaction: TransactionWithDescription = {
    id: hash,
    description: erc20TransferExtraData.description || "",
  };

  const { error } = await upsertTransactionWithDescription(
    supabaseClient,
    transaction,
  );
  if (error) {
    console.error("Error inserting transaction:", error);
  }

  return new Response("transaction data processed", { status: 200 });
});

/* To invoke locally:

  1. Run `supabase start` (see: https://supabase.com/docs/reference/cli/supabase-start)
  2. Make an HTTP request:

  curl -i --location --request POST 'http://127.0.0.1:54321/functions/v1/notify-successful-transaction' \
    --header 'Authorization: Bearer ' \
    --header 'Content-Type: application/json' \
    --data '{"name":"Functions"}'

*/
