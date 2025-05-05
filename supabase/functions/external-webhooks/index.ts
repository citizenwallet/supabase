import { serve } from "https://deno.land/std@0.177.1/http/server.ts";
import { getServiceRoleClient } from "../_db/index.ts";

serve(async (req) => {
  const { record } = await req.json();
  if (!record || typeof record !== "object") {
    return new Response("Invalid record data", { status: 400 });
  }

  const supabaseClient = getServiceRoleClient();

  // Fetch the webhook from the database
  const { data, error } = await supabaseClient
    .from("webhooks")
    .select("*")
    .eq("event_contract", record.dest)
    .eq("event_topic", record.data.topic);

  if (error) {
    console.error("Error fetching community config", error);
    return new Response("Error fetching community config", { status: 500 });
  }

  if (data.length === 0) {
    console.error("No webhook found for event", record.data.topic);
    return new Response("No webhook found for event", { status: 404 });
  }

  const webhook = data[0];

  const webhookUrl = webhook.url;
  const alias = webhook.alias;

  // Fetch the webhook secret from the database
  const { data: webhookSecretData, error: webhookSecretError } =
    await supabaseClient.from("webhook_secrets").select("*").eq("alias", alias);

  if (webhookSecretError) {
    console.error("Error fetching webhook secret", webhookSecretError);
    return new Response("Error fetching webhook secret", { status: 500 });
  }

  if (webhookSecretData.length === 0) {
    console.error("No webhook secret found for alias", alias);
    return new Response("No webhook secret found for alias", { status: 404 });
  }

  const webhookSecret = webhookSecretData[0];
  const webhookSecretKey = webhookSecret.secret;

  // Send the webhook request with timeout and error logging
  const controller = new AbortController();
  const timeoutId = setTimeout(() => controller.abort(), 10000);

  try {
    const response = await fetch(webhookUrl, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${webhookSecretKey}`,
      },
      body: JSON.stringify(record),
      signal: controller.signal,
    });

    clearTimeout(timeoutId);

    if (!response.ok) {
      console.error(
        `Webhook request failed with status ${response.status}: ${response.statusText}`
      );
    } else {
      console.log("Webhook response:", await response.text());
    }
  } catch (err) {
    clearTimeout(timeoutId);
    if (err.name === "AbortError") {
      console.error("Webhook request timed out after 10 seconds");
    } else {
      console.error("Error sending webhook request:", err);
    }
  }

  return new Response("OK", { status: 200 });
});
