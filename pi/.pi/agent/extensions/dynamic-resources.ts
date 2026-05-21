import {dirname, join, resolve} from "node:path"
import { fileURLToPath } from "node:url"
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent"

const baseDir = resolve(dirname(fileURLToPath(import.meta.url)), "..");

export default function (pi: ExtensionAPI) {
    pi.on("resources_discover", () => {

        return {
            skillPaths: [join(baseDir, "skills/")],
            // promptPaths: [join(baseDir, "dynamic.md")],
            // themePaths: [join(baseDir, "dynamic.json")]
        }
    })
}
