# TTY

TTY is a browser SSH terminal for [Cloudflare Quick Tunnel Tray](https://github.com/robit-man/cloudflared-quick-tunnel-tray). Open the [hosted TTY](https://robit-man.github.io/tty/) and choose **Install** to download the tray for your host computer.

Start **Browser Terminal** in tray version 2.0 or later, then copy its full link and paste it into TTY. The versioned link contains a secret after `#tty=v2.`. Treat it like a password and share it through a trusted channel. If you upgrade from an older tray, cycle the tunnel and copy a new link.

TTY and the tray authenticate each other with the link secret using Noise NNpsk0. A fresh handshake encrypts every connection, including reconnects and forks. Cloudflare carries encrypted frames and sees connection metadata such as the hostname, timing, and sizes. Use a TTY page you trust. The tray decrypts the stream on the host and uses OpenSSH with host-key verification to reach the local SSH server.

Serve `index.html` over HTTPS for a standalone TTY. The standalone page links directly to release downloads. To serve the installers from your own host alongside TTY, run `bash scripts/stage-site.sh site` with an authenticated GitHub CLI and publish the resulting directory. GitHub Pages uses this script and refreshes the installers daily.
