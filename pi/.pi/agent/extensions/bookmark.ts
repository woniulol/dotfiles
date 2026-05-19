import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

export default function(pi: ExtensionAPI) {
    pi.registerCommand("bookmark", {
        description: "Bookmark last message (usage: /bookmark [label])",
        handler: async (args, ctx) => {
            const lable = args.trim() || `bookmark-${Date.now()}`;
            const entries = ctx.sessionManager.getEntries();
            for (let i = entries.length - 1; i >= 0; i--) {
                const entry = entries[i];
                if (entry.type === "message" && entry.message.role === "assistant") {
                    pi.setLabel(entry.id, lable);
                    ctx.ui.notify(`Bookmarked as: ${lable}`, "info");
                    return;
                }
            }
            ctx.ui.notify("No assistant message to bookmark", "warning");
        }
    })

    /** Remove a named bookmark. If name is not specified remove the latest one. */
    pi.registerCommand("unbookmark", {
        description: "Remove bookmark from last labeled entry",
        handler: async (args, ctx) => {
            const target = (args ?? "").trim() || undefined;
            const entries = ctx.sessionManager.getEntries();
            for (let i = entries.length - 1; i >= 0; i--) {
                const entry = entries[i];
                const label = ctx.sessionManager.getLabel(entry.id);
                if (label && (!target || target === label)) {
                    pi.setLabel(entry.id, undefined);
                    ctx.ui.notify(`Removed bookmark ${label}`, "info");
                    return;
                }
            }
            ctx.ui.notify(
                target
                    ? `No bookmark named '${target}' found`
                    : `No bookmark entry found`,
                "warning"
            )
        }
    })
}
