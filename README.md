Docker Container for the Game mode Troube in Terrorist Town of the game Garry's Mod.

To run your own server:

  - Modify Dockerfile and add your steam account id and authkey for garry's mod
  - Modify server.cfg and add your own server name and change value how you like them.
  - Build container and have fun.

The COLLECTIONID I already added is my own collection with addons for TTT. You are free to use that collection or create your own and add its ID in the Dockerfile.

Advise: it's useful to mount the /steam/gmod directory to the host. Wit hthat you don't need to download the server files everytime you recreate the container. Also this way the container starts much faster, but I don't know why, yet.
