import { CommunityConfig, type Profile } from "npm:@citizenwallet/sdk";
import { formatUnits } from "npm:ethers";

import communityJson from "./community.json" with {
    type: "json",
};

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

export interface ERC20TransferExtraData {
    description: string;
}

export interface MetadataUpdateData {
    _tokenId: string;
}

export const communityConfig = () => {
    return new CommunityConfig(communityJson);
};

export const getCommunityConfigsFromUrl = async (): Promise<
    CommunityConfig[]
> => {
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

        const communitiesJson = await response.json();

        return communitiesJson.map((community: any) =>
            new CommunityConfig(community)
        ).filter(
            (community: CommunityConfig) => !community.config.community.hidden,
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
    data: ERC20TransferData,
    profile?: Profile,
): Notification => {
    const community = config.community;
    const token = config.primaryToken;

    const value = formatUnits(data.value, token.decimals);

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
