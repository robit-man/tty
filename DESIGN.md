# TTY interface

## Direction

The terminal fills a black viewport. The connection form opens in a modal. The upper-right plus and connection dot remain visible during use. Every session row and the centered plus entry share the same width. Session rows reveal their close action on hover, keyboard focus, or a touch-and-hold gesture. The caret stays on the left while the rail slides in or out. The terminal fills the available width with the rail collapsed. The keyboard controls appear next to the on-screen keyboard when the terminal has focus.

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
| Gap between form controls | 8 px |
| Modal fade and sidebar slide | 100 ms with reduced-motion support |

Use the system sans-serif for controls and the built-in monospace stack for terminal output.

## Interaction

Keep each tab’s connection and scrollback independent. A connection error stays in the form and allows a retry. Keep the connection form centered, and move it only as far as needed to stay usable above the on-screen keyboard. The Recents menu overlays the form and fills in a saved browser terminal link and username. Keep up to eight recent links in local browser storage and provide a clear action. Send the token in the WebSocket hello and clear the form’s link when the modal closes. SSH credentials stay in the terminal exchange.

Drag a tab or pane header to dock its terminal. Drag the upper-right plus to preview a new pane and choose its destination before opening the connection form. The preview dims the workspace and highlights the destination. A single pane can split in either direction. Nested panes split perpendicular to their parent. Every pane has a black header. Its label opens text-size controls for that session, and minimizing the pane keeps its session available from the sidebar. Dividers fade into view on hover and can be dragged to resize panes.

The connection dot opens a live 30-second traffic graph, per-session byte totals, connection age, and measured setup time. Keep the SSH connect and QR connect actions in that menu. The QR action in a pane header opens sharing for that terminal. It also lets either peer end an active share.

A one-use QR invite expires after two minutes. The Share tab displays the PIN separately, and the Connect tab scans locally with camera permission or accepts a pasted link. The scanning peer can offer its own terminal or request the inviter’s. The inviter confirms after PIN verification, before the screen or keyboard input is shared. A shared terminal keeps the originating terminal’s dimensions and starts from its visible screen. Keep pending invites in memory and stop the camera when it has found an invite or the Connect tab closes.

Use Tracker’s public NATS relay to route the encrypted exchange. The invite fragment pins the creator’s ephemeral ECDH public key. HKDF derives distinct traffic keys and a PIN-proof key. AES-GCM authenticates each frame and its sequence, and the receiving browser verifies an HMAC proof of the PIN. Three PIN attempts consume the invite. The shared session has its own browser-to-browser channel and carries neither the Quick Tunnel link nor its authentication token.
