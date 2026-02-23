import { NotionExporter } from "notion-exporter";

const fetchEnv = (envName) => {
  const variable = process.env[envName]?.trim();
  if (!variable) {
    throw new Error(`Missing ${envName}`);
  }
  return variable;
};

async function main() {
  const NOTION_BLOCK_ID = fetchEnv("NOTION_BLOCK_ID");
  const OUTPUT_DIR = fetchEnv("OUTPUT_DIR");

  await new NotionExporter("", "", {
    recursive: true,
    pollInterval: 2000,
  }).getMdFiles(NOTION_BLOCK_ID, OUTPUT_DIR);

  console.log("Export completed successfully!");
}

main().catch(error => {
  console.error("Error:", error);
  process.exit(1);
});
