## Development

### Prerequisites

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
6. Select **Settings** > **My Fire TV** > **About** > **Network** to find your Fire TV's IP Address
7. Open a terminal in the project root directory and run:
    ```bash
    just up
    just connect <firetv-ip-address>
    ```
8. A prompt will appear on your Fire TV asking: **"Allow USB debugging?"**. Check the box  
   **"Always allow from this computer"**, select **Allow** and press the Enter button on your remote

### Running

1. Open a terminal in the project root directory and run:
    ```bash
    just up
    just connect <firetv-ip-address>
    just start
    ```
2. Open a second terminal in the project root directory and run:
    ```bash
    just run
    ```
