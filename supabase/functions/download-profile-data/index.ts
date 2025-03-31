// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

// Setup type definitions for built-in Supabase Runtime APIs
import "jsr:@supabase/functions-js/edge-runtime.d.ts";

import {
    getCommunityConfigs,
    type MetadataUpdateData,
} from "../_citizen-wallet/index.ts";
import { getServiceRoleClient } from "../_db/index.ts";
import { upsertProfile } from "../_db/profiles.ts";
import { getProfileFromId } from "npm:@citizenwallet/sdk";

/**
 * Example record:
 * {
 *   "data": {
 *     "topic": "0xf8e1a15aba9398e019f0b49df1a4fde98ee17ae345cb5f6b5e2c27f5033e8ce7",
 *     "_tokenId": "187958928820613595928785719286779462408251654092"
 *   },
 *   "dest": "0x56Cc38bDa01bE6eC6D854513C995f6621Ee71229",
 *   "hash": "0x95cb5578a8061ae4e8b41bd0859491ebd957181d6b27ea96392976d2d737ed75",
 *   "nonce": 0,
 *   "value": "0",
 *   "sender": "",
 *   "status": "success",
 *   "tx_hash": "0x131774b7d3ecdad2e75cb2e388b8a5ed592b05e5f3982383badff711c3326140",
 *   "created_at": "2025-02-23T12:26:10",
 *   "updated_at": "2025-02-23T12:26:11.705259"
 * }
 */

Deno.serve(async (req) => {
    const { record } = await req.json();

    console.log("record", record);

    if (!record || typeof record !== "object") {
        return new Response("Invalid record data", { status: 400 });
    }

    const { dest, status, data } = record;

    if (!dest || typeof dest !== "string") {
        return new Response(
            "Destination address is required and must be a string",
            { status: 400 },
        );
    }
    const profileContract = dest
    const communityConfigs = await getCommunityConfigs();

    if (communityConfigs.length === 0) {
        return new Response("No community configs found", { status: 400 });
    }

    const communitiesWithDest = communityConfigs.filter((config) =>
        config.community.profile.address === profileContract
    );

    if (communitiesWithDest.length === 0) {
        return new Response(
            `No community found with profile contract ${profileContract}`,
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

    // Initialize Supabase client with service role key
    const supabaseClient = getServiceRoleClient();

    for (const community of communitiesWithDest) {
        const metadataUpdateData = data as MetadataUpdateData;

        const profile = await getProfileFromId(
            community.ipfs.url.replace(/^https?:\/\//, ''),
            community,
            metadataUpdateData._tokenId,
        );

        if (!profile) {
            console.log("profile not found, ignoring");
            continue;
        }

        const result = await upsertProfile(
            supabaseClient,
            profile,
            community.community.profile.address,
        );

        if (result.error) {
            console.error(result.error);
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
