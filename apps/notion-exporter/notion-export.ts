import process from "node:process";
import { NotionExporter } from "notion-exporter";

const DEBUG = Boolean(process.env.DEBUG?.trim());

const debug = (...args: unknown[]) => {
  if (DEBUG) {
    console.error("[debug]", new Date().toISOString(), ...args);
  }
};

const fetchEnv = (envName: string): string => {
  const variable = process.env[envName]?.trim();
  if (!variable) {
    throw new Error(`Missing ${envName}`);
  }
  return variable;
};

// notion-exporter has no debug option, so wrap fetch to log every call.
// Headers are never logged, so the tokens stay out of the output.
const attachDebugLogging = () => {
  const originalFetch = globalThis.fetch;
  globalThis.fetch = async (input, init) => {
    const url = input instanceof URL ? input.href : typeof input === "string" ? input : input.url;
    debug("request", init?.method ?? "GET", url, init?.body ?? "");
    try {
      const res = await originalFetch(input, init);
      // Task lifecycle is in the body of the task_output lookup; surface it while polling.
      const lifecycle = (await res.clone().text()).match(/"lifecycle":"(\w+)"/)?.[1];
      debug("response", res.status, url, lifecycle ? `lifecycle=${lifecycle}` : "");
      return res;
    } catch (error) {
      debug("request failed", url, error);
      throw error;
    }
  };
};

async function main() {
  const NOTION_BLOCK_ID = fetchEnv("NOTION_BLOCK_ID");
  const OUTPUT_DIR = fetchEnv("OUTPUT_DIR");
  const NOTION_TOKEN = fetchEnv("NOTION_TOKEN");
  const NOTION_FILE_TOKEN = fetchEnv("NOTION_FILE_TOKEN");
  debug("block", NOTION_BLOCK_ID, "output", OUTPUT_DIR);

  if (DEBUG) {
    attachDebugLogging();
  }

  await new NotionExporter(NOTION_TOKEN, NOTION_FILE_TOKEN, {
    recursive: true,
    pollInterval: 2000,
  }).getMdFiles(NOTION_BLOCK_ID, OUTPUT_DIR);

  console.log("Export completed successfully!");
}

main().catch((error: unknown) => {
  console.error("Error:", error);
  process.exit(1);
});
