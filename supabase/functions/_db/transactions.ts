import type {
    PostgrestSingleResponse,
    SupabaseClient,
} from "jsr:@supabase/supabase-js@2";
import type { LogStatus } from "npm:@citizenwallet/sdk";

export interface Transaction {
    id: string;
    hash: string;
    from_member_id: string;
    to_member_id: string;
    token_contract: string;
    value: string;
    status: LogStatus;
    created_at: string;
    updated_at: string;
}

export interface TransactionWithDescription {
    id: string;
    description: string;
}

const TRANSACTIONS_TABLE = "a_transfers";

export const upsertTransaction = (
    client: SupabaseClient,
    transaction: Transaction,
) => {
    return client.from(TRANSACTIONS_TABLE).upsert(transaction, {
        onConflict: "id",
    });
};

export const upsertTransactionWithDescription = async (
    client: SupabaseClient,
    transaction: TransactionWithDescription,
) => {
    // check if exists
    const { data: existingTransaction } = await client.from(TRANSACTIONS_TABLE)
        .select("*").eq("id", transaction.id).maybeSingle();
    if (existingTransaction) {
        return client.from(TRANSACTIONS_TABLE).update({
            description: transaction.description,
        }).eq("id", transaction.id);
    }

    return client.from(TRANSACTIONS_TABLE).insert({
        ...transaction,
        hash: "",
    });
};

export const getTransactionByHash = (
    client: SupabaseClient,
    hash: string,
): Promise<PostgrestSingleResponse<Transaction>> => {
    // @ts-ignore: cryptic error
    return client.from(TRANSACTIONS_TABLE).select("*").eq("hash", hash)
        .maybeSingle();
};
