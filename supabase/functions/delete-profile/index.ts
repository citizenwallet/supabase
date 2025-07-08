import { tokenTransferEventTopic } from "npm:@citizenwallet/sdk";
import { isAddress, ZeroAddress } from "npm:ethers";
import { ProfileDeleteData } from "../_citizen-wallet/index.ts";
import { getServiceRoleClient } from "../_db/index.ts";
import { deleteProfile, getProfile } from "../_db/profiles.ts";

// INSERT INTO "public"."t_logs_42220" ("hash", "tx_hash", "created_at", "updated_at", "nonce", "sender", "dest", "value", "data", "status") VALUES ('0x72b54c59a696250f0354560ea7fd17e1c29eb0d0cd20aca4e42253de66f694b3', '0xda039f2f614aa0df006fb223b4b5b04341af492d34e5abcb1a8d13f6a146b11c', '2025-07-07 11:41:37', '2025-07-07 11:41:36.324424', '0', '', '0x8dA817724Eb6A2aA47c0F8d8b8A98b9B3C2Ddb68', '0', '{"to": "0x0000000000000000000000000000000000000000", "from": "0xFe954e73Db802cE6bD63f67B82cb8Df64C73d8Ac", "topic": "0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef", "tokenId": "1453413301006377630992371589485139822566417094828"}', 'success');

/**
{
  "table": "public.t_logs_42220",
  "data": {
    "hash": "0x72b54c59a696250f0354560ea7fd17e1c29eb0d0cd20aca4e42253de66f694b3",
    "tx_hash": "0xda039f2f614aa0df006fb223b4b5b04341af492d34e5abcb1a8d13f6a146b11c",
    "created_at": "2025-07-07 11:41:37",
    "updated_at": "2025-07-07 11:41:36.324424",
    "nonce": "0",
    "sender": "",
    "dest": "0x8dA817724Eb6A2aA47c0F8d8b8A98b9B3C2Ddb68",
    "value": "0",
    "data": {
      "to": "0x0000000000000000000000000000000000000000",
      "from": "0xFe954e73Db802cE6bD63f67B82cb8Df64C73d8Ac", <-- to burn
      "topic": "0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef",
      "tokenId": "1453413301006377630992371589485139822566417094828"
    },
    "status": "success"
  }
}
*/

Deno.serve(async (req) => {
    const { record } = await req.json();

    const { dest, status, data } = record;
    console.log("this one record", record);

    if (!record || typeof record !== "object") {
        return new Response("Invalid record data", { status: 400 });
    }

    if (!dest || typeof dest !== "string") {
        return new Response(
            "Destination address is required and must be a string",
            { status: 400 },
        );
    }

    if (status !== "success") {
        return new Response("Transaction status is not success, ignoring", {
            status: 200,
        });
    }

    if (data.topic !== tokenTransferEventTopic) {
        return new Response("Transaction topic is not valid, ignoring", {
            status: 200,
        });
    }

    if (data.to != ZeroAddress) {
        return new Response("Transaction to is not valid, ignoring", {
            status: 200,
        });
    }

    if (
        data.from == ZeroAddress ||
        !isAddress(data.from)
    ) {
        return new Response("Transaction from is not valid, ignoring", {
            status: 200,
        });
    }

    const profileContract = dest;

    // Initialize Supabase client with service role key
    const supabaseClient = getServiceRoleClient();

    const metadataUpdateData = data as ProfileDeleteData;

    const profile = await getProfile(
        supabaseClient,
        metadataUpdateData.from,
        profileContract,
    );

    if (!profile) {
        console.log("profile not found, ignoring");
        return new Response("profile not found, ignoring", { status: 200 });
    }

    console.log("profile", profile);

    const result = await deleteProfile(
        supabaseClient,
        profile.data.account,
        profileContract,
    );

    console.log("result", result);

    return new Response("profile deleted", { status: 200 });
});
