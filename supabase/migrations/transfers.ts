import { getServiceRoleClient } from "../functions/_db/index.ts";
import type { SupabaseClient } from "jsr:@supabase/supabase-js@2";
import {
    type CommunityConfig,
    tokenTransferEventTopic,
} from "npm:@citizenwallet/sdk";
import {
    type Transaction,
    type TransactionWithDescription,
    upsertTransaction,
    upsertTransactionWithDescription,
} from "../functions/_db/transactions.ts";
import { upsertInteraction } from "../functions/_db/interactions.ts";

import { createMemberId } from "../functions/_db/profiles.ts";

import { readLogsWithData, totalLogs } from "../functions/_db/logs.ts";
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
) => {

    let offset = 0;

    while (true) {
          console.log(
            `Processing ${limit} transactions from ${offset}...`,
        );

            const logs = await readLogsWithData(
        supabaseClient,
        chainId,
        tokenContract,
        limit,
        offset,
            );
        
        console.log(`Found ${logs.length} logs`);

           if (logs.length === 0) {
            break;
           }

           const oneCommunity = communities[0];

          for (const log of logs) {


            
        const erc20TransferData = log.data as ERC20TransferData;

        if (erc20TransferData.topic !== tokenTransferEventTopic) {
            console.log(
                "Skipping non-ERC20 transfer",
                JSON.stringify(log, null, 2),
            );
            continue;
        }

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
        await upsertInteraction(supabaseClient, transaction);
    }

    if (logs.length < limit) {
        console.log(`No more logs to process`);
        break;
        }

         offset += logs.length;

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

    if (total === 0) {
        console.error("No logs found for chainId and tokenContract");
        Deno.exit(1);
    }

    console.log(`Total logs: ${total}`);

    const communityConfigs = await getCommunityConfigsFromUrl();

    if (communityConfigs.length === 0) {
        console.error("No community configs found");
        Deno.exit(1);
    }

   const communitiesWithDest = communityConfigs.filter((config) =>
        config.community.primary_token.address === tokenContract && config.primaryToken.chain_id === parseInt(chainId)
    );

    if (communitiesWithDest.length === 0) {
        console.error("No communities with token contract found");
        Deno.exit(1);
    }

    console.log(
        `Found ${communitiesWithDest.length} communities with destination ${tokenContract}`,
    );
    console.log(`${communitiesWithDest.map((c) => c.community.name)}`);

    await processTransactions(
        supabaseClient,
        communitiesWithDest,
        chainId,
        tokenContract,
        100,
    );
};

main();
