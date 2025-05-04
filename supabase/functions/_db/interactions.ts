import type { SupabaseClient } from "npm:@supabase/supabase-js@2";
import { Transaction } from "./transactions.ts";

const INTERACTIONS_TABLE = "a_interactions";

export const upsertInteraction = async (
    client: SupabaseClient,
    transaction: Pick<
        Transaction,
        "id" | "from_member_id" | "to_member_id"
    >,
) => {
    const timestamp = new Date().toISOString();

    // First direction: from->to
    await client
        .from(INTERACTIONS_TABLE)
        .upsert(
            {
                id: crypto.randomUUID(),
                transfer_id: transaction.id,
                first_person_member_id: transaction.from_member_id,
                second_person_member_id: transaction.to_member_id,
                new_interaction: true,
                updated_at: timestamp,
                created_at: timestamp,
            },
            {
                onConflict: "transfer_id,first_person_member_id,second_person_member_id",
                ignoreDuplicates: false,
            },
        )
        .select()
        .single();

    // Second direction: to->from
    await client
        .from(INTERACTIONS_TABLE)
        .upsert({
            id: crypto.randomUUID(),
            transfer_id: transaction.id,
            first_person_member_id: transaction.to_member_id,
            second_person_member_id: transaction.from_member_id,
            new_interaction: true,
            updated_at: timestamp,
            created_at: timestamp,
        }, {
            onConflict: "transfer_id,first_person_member_id,second_person_member_id",
            ignoreDuplicates: false,
        })
        .select()
        .single();
};
