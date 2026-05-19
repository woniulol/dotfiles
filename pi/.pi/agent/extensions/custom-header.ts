import type { ExtensionAPI, Theme } from "@earendil-works/pi-coding-agent";
import { VERSION } from "@earendil-works/pi-coding-agent";

// function getPiMascot(theme: Theme): string[] {
//     const piBlue = (text: string) => theme.fg("accent", text);
//     const white = (text: string) => text;
//     const black = (text: string) => theme.fg("dim", text);
//
//     const BLOCK = "█";
//     const PUPIL = "▌"; // Vertical half-block for the pupil
//
//     const eye = `${white(BLOCK)}${black(PUPIL)}`;
//     const lineEyes = `     ${eye}  ${eye}`;
//     const lineBar = `  ${piBlue(BLOCK.repeat(14))}`;
//     const lineLeg = `     ${piBlue(BLOCK.repeat(2))}    ${piBlue(BLOCK.repeat(2))}`;
//     return ["", lineEyes, lineBar, lineLeg, lineLeg, lineLeg, lineLeg, ""];
// }

export default function(pi: ExtensionAPI) {
    // pi.on("session_start", async (_event, ctx) => {
    //     if (ctx.hasUI) {
    //         ctx.ui.setHeader((_tui, _theme) => {
    //             return {
    //                 render(width: number): string[] {
    //                     const tools = pi.getAllTools().map(tool => tool.name);
    //                     const toolLine = ` 🛠️  Tools: ${tools.join(" │ ")}`;
    //                     const border = "─".repeat(width);
    //                     return [toolLine, border];
    //                 },
    //                 invalidate() { },
    //             };
    //         });
    //     }
    // });

    pi.registerCommand("builtin-header", {
        description: " Restore built-in header with keybinding hints",
        handler: async (_args, ctx) => {
            ctx.ui.setHeader(undefined)
            ctx.ui.notify("Built-in header restored", "info")
        }
    })
}
