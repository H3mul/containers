Simple container that compiles and serves netboot.xyz assets for a custom domain

| Container Port | Process  |
| - | - |
|  `80` |  Nginx server serving compiled netboot.xyz PXE assets |

| Build Argument | Description                                                                               |   Example
| -------------- | ----------------------------------------------------------------------------------------- | --- |
| `VERSION`      | [netboot.xyz release](https://github.com/netbootxyz/netboot.xyz/releases) tag |  2.0.67 |
| `BOOT_DOMAIN`  | domain you wish the PXE file to redirect to for assets |  boot.example.com |

## Usage:

Build the container with your custom domain (PXE assets are compiled at build time):

```
docker build -f Dockerfile --build-arg BOOT_DOMAIN=boot.example.com -t my-netboot-xyz
```

Serve the container from your boot domain, eg via docker swarm, kubernetes, reverse proxy, etc:

```
version: "3.9"
  services:
    netboot-xyz:
        image: my-netboot-xyz
        deploy:
            labels:
                traefik.enable: "true"
                traefik.http.services.netboot-xyz.loadbalancer.server.port: 80
                traefik.http.routers.netboot-xyz.rule: "Host(`boot.example.com`)"    
```

Now you can download the file https://boot.example.com/ipxe/netboot.xyz.kpxe (and/or `netboot.xyz.efi`) and serve it in your local DHCP-pointed TFTP server (eg dnsmasq), and the PXE machine will request further assets from the boot.example.com domain.
## Motivation:

TL;DR - netboot.xyz bakes the https://boot.netboot.xyz domain into its PXE files. We want to bake our own domain into custom compiled assets and serve them ourselves.

The easiest method of adding netboot.xyz PXE booting to your local network is to host the base [DHCP files](https://netboot.xyz/downloads/) in your [local DHCP+TFTP server](https://netboot.xyz/docs/booting/tftp) - eg `dnsmasq` in your OpenWrt router. In this case, the PXE-booted machine will retrieve further assets (menus, etc) from the boot.netboot.xyz domain. This is not true selfhosting.

You could serve ALL the netboot.xyz PXE [assets](https://github.com/netbootxyz/netboot.xyz/releases/latest) in your local router TFTP server (the PXE boot process requests assets from the TFTP server before reaching out to the baked domain via HTTP(S)) - but that's 17Mb, often too much for a router's storage.

You could also use a separate local TFTP server, and point to it from the router DHCP (eg using a [`next-server`](https://netboot.xyz/docs/booting/tftp) directive, or a [`dnsmasq.conf` entry](https://github.com/linuxserver/docker-netbootxyz#dd-wrt)). The caveat is that the TFTP server has to reside in the same network, due to the protocol's reliance on [ephemeral ports](https://en.wikipedia.org/wiki/Trivial_File_Transfer_Protocol#Details) for data communication. TFTP is a very difficult service to containerize for this reason ([#11](https://github.com/linuxserver/docker-netbootxyz/issues/11)). A simple implementation of the separate TFTP server solution is to use the [linuxserver docker image](https://github.com/linuxserver/docker-netbootxyz) which has a built in TFTP server, and run it with `network_mode: host`.

The best solution (IMHO) is to replicate the netboot.xyz method and selfhost custom PXE assets from our own HTTP(S) domain. This requires baking that domain into PXE assets, so that machines booting off of custom `netboot.xyz.kpxe` and `netboot.xyz.efi` files know which domain to request assets from.