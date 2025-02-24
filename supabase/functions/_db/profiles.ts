import { formatProfileImageLinks, type Profile } from "npm:@citizenwallet/sdk";
import type {
    PostgrestSingleResponse,
    SupabaseClient,
} from "jsr:@supabase/supabase-js@2";

export interface ProfileWithTokenId extends Profile {
    token_id: string;
}

export interface ProfileWithContractAddress extends Profile {
    contract: string;
}

const PROFILES_TABLE = "a_members";

export const insertAnonymousProfile = async (
    client: SupabaseClient,
    account: string,
    contract: string,
): Promise<PostgrestSingleResponse<null>> => {
    const defaultProfileImageIpfsHash = Deno.env.get(
        "DEFAULT_PROFILE_IMAGE_IPFS_HASH",
    );
    if (!defaultProfileImageIpfsHash) {
        throw new Error("DEFAULT_PROFILE_IMAGE_IPFS_HASH is not set");
    }

    const ipfsUrl = Deno.env.get("IPFS_URL");
    if (!ipfsUrl) {
        throw new Error("IPFS_URL is not set");
    }

    const profile: Profile = formatProfileImageLinks(ipfsUrl, {
        account,
        username: "anonymous",
        name: "Anonymous",
        description: "This user does not have a profile",
        image: defaultProfileImageIpfsHash,
        image_medium: defaultProfileImageIpfsHash,
        image_small: defaultProfileImageIpfsHash,
    });

    const profileWithContractAddress: ProfileWithContractAddress = {
        ...profile,
        contract,
    };

    return client.from(PROFILES_TABLE).insert(profileWithContractAddress);
};

export const upsertProfile = async (
    client: SupabaseClient,
    profile: ProfileWithTokenId,
    contract: string,
): Promise<PostgrestSingleResponse<null>> => {
    const profileWithContractAddress: ProfileWithContractAddress = {
        ...profile,
        contract,
    };
    
    return client
        .from(PROFILES_TABLE)
        .upsert(profileWithContractAddress, {
            onConflict: "account,contract",
        });
};

export const getProfile = async (
    client: SupabaseClient,
    account: string,
    contract: string,
): Promise<PostgrestSingleResponse<Profile | null>> => {
    return client.from(PROFILES_TABLE).select().ilike("account", account)
        .ilike("contract", contract)
        .maybeSingle();
};
