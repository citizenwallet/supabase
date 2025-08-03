import { CommunityConfig, Config, type Profile } from "npm:@citizenwallet/sdk";
import { formatUnits } from "npm:ethers";

// Define under the functions service in docker-compose.yml of the supabase clone.
// Define value in docker/.env
const COMMUNITIES_CONFIG_URL = Deno.env.get("COMMUNITIES_CONFIG_URL");

export interface Notification {
    title: string;
    body: string;
}

export interface ERC20TransferData {
    from: string;
    to: string;
    value: string;
    topic: string;
}

export interface ERC1152TransferData {
    id: string;
    to: string;
    from: string;
    topic: string;
    amount: string;
    operator: string;
}

export interface ERC20TransferExtraData {
    description: string;
}

export interface ERC1152TransferExtraData {
    description: string;
}

export interface MetadataUpdateData {
    _tokenId: string;
}

export interface ProfileDeleteData {
    to: string;
    from: string;
    topic: string;
    tokenId: string;
}

export interface RoleChangeData {
    role: string;
    topic: string;
    sender: string;
    account: string;
}

interface CommunityT {
    alias: string;
    chain_id: number;
    active: boolean;
    created_at: Date;
    updated_at: Date;
    json: Config;
}

export const getCommunityConfigs = async (): Promise<CommunityConfig[]> => {
    if (!COMMUNITIES_CONFIG_URL) {
        throw new Error(
            "COMMUNITIES_CONFIG_URL environment variable is not set",
        );
    }

    try {
        const response = await fetch(COMMUNITIES_CONFIG_URL);

        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }

        const communities = await response.json() as CommunityT[];

        return communities.map((community: CommunityT) =>
            new CommunityConfig(community.json)
        );
    } catch (error) {
        console.error("Error fetching communities:", error);
        throw error;
    }
};

export const formatERC20TransactionValue = (
    config: CommunityConfig,
    value: string,
) => {
    const token = config.primaryToken;
    return formatUnits(value, token.decimals);
};

export const createERC20TransferNotification = (
    config: CommunityConfig,
    data: ERC20TransferData | ERC1152TransferData,
    profile?: Profile,
): Notification => {
    const community = config.community;
    const token = config.primaryToken;

    let value: string;

    if ("value" in data) {
        value = formatUnits(data.value, token.decimals);
    } else if ("amount" in data) {
        value = formatUnits(data.amount, token.decimals);
    } else {
        value = "";
    }

    if (profile) {
        return {
            title: community.name,
            body:
                `${value} ${token.symbol} received from ${profile.name} (@${profile.username})`,
        };
    }

    return {
        title: community.name,
        body: `${value} ${token.symbol} received`,
    };
};
