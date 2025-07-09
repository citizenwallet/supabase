import { formatProfileImageLinks, type Profile } from "npm:@citizenwallet/sdk";
import type {
    PostgrestSingleResponse,
    SupabaseClient,
} from "npm:@supabase/supabase-js@2";

export interface ProfileWithTokenId extends Profile {
    token_id: string;
}

export interface ProfileWithProfileContractAddress extends Profile {
    profile_contract: string;
}

const PROFILES_TABLE = "a_members";

export const createMemberId = (
    account: string,
    profile_contract: string,
): string => {
    return `${account}:${profile_contract}`;
};

export const insertAnonymousProfile = async (
    client: SupabaseClient,
    account: string,
    profile_contract: string,
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

    const profileWithProfileContractAddress: ProfileWithProfileContractAddress =
        {
            ...profile,
            profile_contract,
        };

    return client.from(PROFILES_TABLE).insert(
        profileWithProfileContractAddress,
    );
};

export const upsertProfile = async (
    client: SupabaseClient,
    profile: ProfileWithTokenId,
    profile_contract: string,
): Promise<PostgrestSingleResponse<null>> => {
    return client
        .from(PROFILES_TABLE)
        .upsert(
            {
                id: createMemberId(profile.account, profile_contract),
                account: profile.account,
                profile_contract,
                username: profile.username,
                name: profile.name,
                description: profile.description,
                image: profile.image,
                image_medium: profile.image_medium,
                image_small: profile.image_small,
                token_id: profile.token_id,
            },
            {
                onConflict: "id",
            },
        );
};

export const getProfile = async (
    client: SupabaseClient,
    account: string,
    profile_contract: string,
): Promise<
    PostgrestSingleResponse<ProfileWithProfileContractAddress | null>
> => {
    const memberId = createMemberId(account, profile_contract);
    return client.from(PROFILES_TABLE).select().eq("id", memberId)
        .maybeSingle();
};

export const upsertAnonymousProfile = async (
    client: SupabaseClient,
    account: string,
    profile_contract: string,
): Promise<PostgrestSingleResponse<null>> => {
    const defaultProfileImageIpfsHash = Deno.env.get(
        "DEFAULT_PROFILE_IMAGE_IPFS_HASH",
    );
    if (!defaultProfileImageIpfsHash) {
        throw new Error("DEFAULT_PROFILE_IMAGE_IPFS_HASH is not set");
    }

    return await client
        .from(PROFILES_TABLE)
        .upsert(
            {
                id: createMemberId(account, profile_contract),
                account,
                profile_contract,
                username: "anonymous",
                name: "Anonymous",
                description: "This user does not have a profile",
                image: defaultProfileImageIpfsHash,
                image_medium: defaultProfileImageIpfsHash,
                image_small: defaultProfileImageIpfsHash,
            },
            {
                onConflict: "id",
            },
        );
};
