# TTY interface

## Direction

The terminal fills a black viewport. The connection form opens in a modal. The upper-right plus and connection dot remain visible during use. The session rail has a thin divider, with extra width and a close button on the selected tab. A centered plus entry opens the connection modal. The caret stays on the left while the rail slides in or out. The terminal fills the available width with the rail collapsed. The keyboard controls appear next to the on-screen keyboard when the terminal has focus.

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

Keep each tab’s connection and scrollback independent. A connection error stays in the form and allows a retry. Closing a tab asks for confirmation. Pressing a mobile modifier applies it to the next key. Send the token in the WebSocket hello and clear the form’s link when the modal closes. Remember the SSH username locally.

Drag a tab or pane header to dock its terminal. The preview dims the workspace and highlights the destination. A single pane can split in either direction. Nested panes split perpendicular to their parent. Pane headers appear when a split is visible. Minimizing a pane keeps its session available from the sidebar. Resize panes with the divider.
