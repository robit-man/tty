# TTY interface

## Direction

The terminal fills a black viewport. The connection form opens in a modal. The upper-right plus and connection dot remain visible during use. Every session row and the centered plus entry share the same width. Session rows show only the session's name: its qtty session, or the SSH user for a plain shell. Dragging a row reveals a dashed trash target at the bottom of the rail, and dropping the row there asks before closing the session. Delete or Backspace on a focused row does the same. The caret stays on the left while the rail slides in or out. The terminal fills the available width with the rail collapsed. The keyboard controls appear next to the on-screen keyboard when the terminal has focus.

## Tokens

The inline CSS in [index.html](index.html) owns the runtime tokens.

| Role | Value |
| --- | --- |
| Page, terminal, modal | Black |
| Primary text | #f0f0f0 |
| Secondary text | #9c9c9c |
| Borders | White at 16% and 32% opacity |
| Control surfaces | White at 4.5%, 11%, and 17% opacity |
| Connection status | Gray when disconnected, amber while connecting, green when connected |
| Input and dialog button height | 46 px |
| Inner radius, modal padding, outer radius | 10 px, 12 px, 22 px |
| Session rows | 8 px radius, 6 px × 8 px padding, white at 2.2% (7% selected) over a 9% (20% selected) border |
| Gap between form controls | 8 px |
| Modal fade and sidebar slide | 100 ms with reduced-motion support |

Use the system sans-serif for controls and the built-in monospace stack for terminal output.

## Interaction

Keep each tab’s connection and scrollback independent. A connection error stays in the form and allows a retry. Keep the connection form centered, and move it only as far as needed to stay usable above the on-screen keyboard. The Recents menu overlays the form and fills in a saved browser terminal link and username. Keep up to eight recent links in local browser storage and provide a clear action. Send the token in the WebSocket hello and clear the form’s link when the modal closes. SSH credentials stay in the terminal exchange. A network change, such as Wi-Fi to cellular, does not end a session. Heartbeats detect a dead connection, and the page checks again when the browser reports a network or visibility change. The page then resumes the same PTY on a new WebSocket. The connection dot turns amber while reconnecting. The gateway replays missed output by byte offset and reports how many input bytes it received. The page resends only keys the gateway never got. The resume secret stays in memory. A deliberate disconnect tells the gateway to end the PTY.

Drag a tab or pane header to dock its terminal. Drag the upper-right plus to preview a new pane and choose its destination before opening the connection form. The preview dims the workspace and highlights the destination. A single pane can split in either direction. Nested panes split perpendicular to their parent. Every pane has a black header. Its label opens text-size controls for that session, and minimizing the pane keeps its session available from the sidebar. Dividers fade into view on hover and can be dragged to resize panes. A two-finger drag in a terminal becomes wheel input, so programs that track the mouse, such as Claude Code, Codex, vim and less, scroll their own views on touch screens as they do with a desktop wheel.

The pane header actions are Share, Fork, Minimize and Close. Fork opens a new qtty session beside the pane in the same working directory, using the pane's SSH login when it is still open. A pane remembers its qtty session. Press Enter in a disconnected pane to sign in again and return to that session. After a reload, panes with qtty sessions come back offline, ready to sign in.

A long press on a terminal selects the word under the finger, and dragging extends the selection. Lifting the finger opens a small menu with Copy, Paste and Select all. A double tap followed by a drag selects in the same way, across lines, and the second tap never reaches the program. When a program tracks the mouse, such as Claude Code or Codex, a double-click followed by a drag selects text instead of sending the click, and the menu opens when the button is released. Right-click opens the same menu on a desktop and keeps the current selection.

When SSH asks for a password or key passphrase, a pill appears in the pane's lower corner. The first time, it offers to save the password: you type it once into a password field, and the page creates a Face ID or Touch ID passkey and stores the password encrypted with AES-GCM under a key derived from that passkey through the WebAuthn PRF extension. Afterward, the pill offers Enter saved password, which asks for Face ID and then sends the password. Nothing is typed until you tap, so a program printing a fake prompt can't get the password without your action. Passwords are saved per SSH username, so they work across cycled tunnels, and Forget removes one. Every page served from the same origin (robit-man.github.io, including other repositories' Pages sites) shares this browser storage and passkey, and could request the same Face ID unlock.

Phone dictation rewrites the terminal's hidden input field with each revised phrase. The page sends a revision as backspaces to the first changed character, then the new ending, so the terminal ends up with only the final text. A key press or leaving the terminal ends a dictation run, and typed keys are sent as before. Opening the page with `#input-log` shows a short event log at the top of the screen for diagnosing other keyboards. When the browser blocks clipboard reads, Paste shows a field that accepts the system paste gesture.

The connection dot opens a live 30-second traffic graph, per-session byte totals, connection age, and measured setup time. Keep the SSH connect and QR connect actions in that menu. The Share action in a pane header opens sharing for that terminal. It also lets either peer end an active share.

A one-use QR invite expires after two minutes. The Share tab displays the PIN separately, and the Connect tab scans locally with camera permission or accepts a pasted link. The scanning peer can offer its own terminal or request the inviter’s. The inviter confirms after PIN verification, before the screen or keyboard input is shared. A shared terminal keeps the originating terminal’s dimensions and starts from its visible screen. Keep pending invites in memory and stop the camera when it has found an invite or the Connect tab closes.

Use four individual PIN inputs with automatic advance, backward deletion into the previous cell, and Enter to verify. Approve each peer with independent View and Write buttons that start with View selected. The owner can invite up to six peers and end each share independently. View permission lets peers see terminal output and share color-coded pointers; write permission lets them send terminal input.

Use Tracker’s public NATS relay to route the encrypted exchange. The invite fragment pins the creator’s ephemeral ECDH public key. HKDF derives distinct traffic keys and a PIN-proof key. AES-GCM authenticates each frame and its sequence, and the receiving browser verifies an HMAC proof of the PIN. Three PIN attempts consume the invite. The shared session has its own browser-to-browser channel and carries neither the Quick Tunnel link nor its authentication token.
