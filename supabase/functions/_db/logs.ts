import type { SupabaseClient } from "jsr:@supabase/supabase-js@2";
import type { Log } from "npm:@citizenwallet/sdk";

const TABLE_NAME = "t_logs";

export const totalLogs = async (
    client: SupabaseClient,
    chainId: string,
    contractAddress: string,
): Promise<number> => {
    const { count, error } = await client
        .from(`${TABLE_NAME}_${chainId}`)
        .select("*", { count: "exact", head: true })
        .eq("dest", contractAddress);

    if (error) {
        console.error("Error fetching total logs:", error);
        return 0;
    }

    return count ?? 0;
};

export const readLogs = async (
    client: SupabaseClient,
    chainId: string,
    contractAddress: string,
    limit: number = 100,
    offset: number = 0,
): Promise<Log[]> => {
    const { data, error } = await client
        .from(`${TABLE_NAME}_${chainId}`)
        .select("*")
        .eq("dest", contractAddress)
        .order("created_at", { ascending: false })
        .range(offset, offset + limit - 1);

    if (error) {
        console.error("Error fetching logs:", error);
        return [];
    }

    return data as Log[];
};

export const readLogsWithData = async (
    client: SupabaseClient,
    chainId: string,
    contractAddress: string,
    limit: number = 100,
    offset: number = 0,
): Promise<Log[]> => {
    // Step 1: Get hashes from t_logs_42220
    const { data: logs, error: logsError } = await client
        .from(`${TABLE_NAME}_${chainId}`)
        .select("*")
        .eq("dest", contractAddress)
        .order("created_at", { ascending: false })
        .range(offset, offset + limit - 1);

    if (logsError || !logs) {
        console.error("Error fetching logs:", logsError);
        return [];
    }

    // Extract hashes
    const hashes = logs.map((log) => log.hash);

    // Step 2: Get data from t_logs_data_42220
    const { data: logData, error: dataError } = await client
        .from(`${TABLE_NAME}_data_${chainId}`)
        .select("*")
        .in("hash", hashes);

    if (dataError || !logData) {
        console.error("Error fetching log data:", dataError);
        return [];
    }

    // Combine the results
    const logMap = new Map<string, any>();
    logData.forEach((data) => {
        logMap.set(data.hash, data.data);
    });

    return logs.map((log) => ({
        ...log,
        extra_data: logMap.get(log.hash) || null,
    })) as Log[];
};

export const getLogByHash = async (
    client: SupabaseClient,
    chainId: number,
    hash: string,
): Promise<Log | null> => {
    const { data, error } = await client.from(`${TABLE_NAME}_${chainId}`)
        .select("*").eq(
            "hash",
            hash,
        ).maybeSingle();
    return data as Log | null;
};
