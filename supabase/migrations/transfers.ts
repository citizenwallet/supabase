import { getServiceRoleClient } from "../functions/_db/index.ts";
import type { SupabaseClient } from "jsr:@supabase/supabase-js@2";
import type { CommunityConfig } from "jsr:@citizenwallet/sdk";
import {
    type Transaction,
    type TransactionWithDescription,
    upsertTransaction,
    upsertTransactionWithDescription,
} from "../functions/_db/transactions.ts";

import { createMemberId } from "../functions/_db/profiles.ts";

import { readLogs, totalLogs } from "../functions/_db/logs.ts";
import "https://deno.land/std@0.214.0/dotenv/load.ts";
import {
    type ERC20TransferData,
    type ERC20TransferExtraData,
    formatERC20TransactionValue,
    getCommunityConfigsFromUrl,
} from "../functions/_citizen-wallet/index.ts";
import { ensureProfileExists } from "../functions/_citizen-wallet/profiles.ts";

// deno task migrate:transfers {chainId} {tokenContract}

const [chainId, tokenContract]: [string, string] = Deno.args;

if (!chainId || !tokenContract) {
    console.error("Please provide chainId and tokenContract as arguments");
    Deno.exit(1);
}

const processTransactions = async (
    supabaseClient: SupabaseClient,
    communities: CommunityConfig[],
    chainId: string,
    tokenContract: string,
    limit: number = 100,
    offset: number = 0,
) => {
    console.log(
        `Processing ${limit} transactions from ${offset} until ${
            offset + limit - 1
        }...`,
    );

    const logs = await readLogs(
        supabaseClient,
        chainId,
        tokenContract,
        limit,
        offset,
    );

    console.log(`Found ${logs.length} logs`);

    const oneCommunity = communities[0];

    for (const log of logs) {
        const erc20TransferData = log.data as ERC20TransferData;
        let erc20TransferExtraData: ERC20TransferExtraData = {
            description: "",
        };
        if (log.extra_data) {
            erc20TransferExtraData = log.extra_data as ERC20TransferExtraData;
        }

        const formattedValue = formatERC20TransactionValue(
            oneCommunity,
            erc20TransferData.value,
        );

        const transaction: Transaction = {
            id: log.hash,
            hash: log.tx_hash,
            from_member_id: createMemberId(
                erc20TransferData.from,
                oneCommunity.community.profile.address,
            ),
            to_member_id: createMemberId(
                erc20TransferData.to,
                oneCommunity.community.profile.address,
            ),
            token_contract: tokenContract,
            value: formattedValue,
            status: log.status,
            created_at: log.created_at,
            updated_at: log.created_at,
        };

        const transactionWithDescription: TransactionWithDescription = {
            id: log.hash,
            description: erc20TransferExtraData.description || "",
        };

        for (const community of communities) {
            await ensureProfileExists(
                supabaseClient,
                community,
                erc20TransferData.from,
            );
            await ensureProfileExists(
                supabaseClient,
                community,
                erc20TransferData.to,
            );
        }

        await upsertTransaction(supabaseClient, transaction);
        await upsertTransactionWithDescription(
            supabaseClient,
            transactionWithDescription,
        );
    }

     if (logs.length >= limit) {
        await processTransactions(
            supabaseClient,
            communities,
            chainId,
            tokenContract,
            limit,
            offset + limit,
        );
    }
};

const main = async () => {
    console.log(`Processing chain ${chainId} for contract ${tokenContract}`);

    const supabaseClient = getServiceRoleClient();

    supabaseClient;

    const total = await totalLogs(
        supabaseClient,
        chainId,
        tokenContract,
    );

    console.log(`Total logs: ${total}`);

    const communityConfigs = await getCommunityConfigsFromUrl();

    if (communityConfigs.length === 0) {
        return new Response("No community configs found", { status: 400 });
    }

    const communitiesWithDest = communityConfigs.filter((config) =>
        config.community.primary_token.address.toLowerCase() ===
            tokenContract.toLowerCase()
    );
};

main();
