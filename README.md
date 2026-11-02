# pornhub-tv

An unofficial, open-source client that brings Pornhub to Amazon Fire TV devices.

## Installation

1. On your Fire TV, go to App store and install the **Downloader** app
2. Open Downloader and enter the code `83929`
3. Follow the on-screen instructions to download and install the application.

## Development

### Prerequisitoes

- [just](https://just.systems/man/en/packages.html)
- [podman](https://podman.io/docs/installation)
- [podman-compose](https://github.com/containers/podman-compose#installation)

### Environment setup

1. Make sure your computer and Fire TV are connected to the same Wi-Fi network
2. Select **Settings** > **My Fire TV** > **About** and Repeatedly press the Enter button  
  on your remote until a notification confirms that Developer Options have been enabled
4. Navigate to **Settings** > **My Fire TV** > **Developer Options**, select **ADB Debugging**, press  
   the Enter button on your remote, a prompt will appear asking: **"Allow wireless debugging  
   on this network?"**, check the box **"Always allow on this network"**, select **Allow** and press  
   the Enter button on your remote
6. Select **Settings** > **My Fire TV** > **About** > **Network** and find your Fire TV's IP Address
7. On your computer, open a terminal in the project root directory and run:
    ```bash
    just up
    just connect <firetv-ip-address>
    ```
8. A prompt will appear on your Fire TV asking: **"Allow USB debugging?"**. Check the box  
   **"Always allow from this computer"**, select **Allow** and press the Enter button on your remote
9. Return to the terminal and run:
    ```bash
    just run
   ```

### Running

1. Open a terminal in the project root directory and run:
    ```bash
    just up
    just connect <firetv-ip-address>
    just start
    ```
2. Open the TVApp
