# Garmin Race Walking App

## Start developing
A more detailed guide can be found on [our confluence page](https://rewcsgarmin.atlassian.net/wiki/spaces/GRWA/pages/2555918/Developer+s+Getting+Started+Guide)

### Environment Set-up
1. Set up the project in [Visual Studio Code](https://code.visualstudio.com/)
    - [Clone](https://docs.gitlab.com/ee/gitlab-basics/start-using-git.html#clone-a-repository) the [repository]()
    - Open The workspace
        - File -> Open Workspace from File ... -> open "garmin-race-walking-app.code-workspace"
    - Install workspace recommended extensions
2. Download and install the [Garmin Connect IQ SDK](https://developer.garmin.com/connect-iq/overview/)
    - Set the SDK version to 6.3.1
    - Run the `Monkey C: Verify Installation` command to ensure the development environment is correctly setup
        - Command short-cut on windows: `control`+`shift`+`p`
        - Command short-cut on windows: `command`+`shift`+`p`
3. Setup the simulator: [Detailed Guide](https://developer.garmin.com/connect-iq/core-topics/bluetooth-low-energy/)
    - Required hardware: [Nordic NRF52-DK](https://www.nordicsemi.com/Products/Development-hardware/nrf52-dk)
    - Flash the board: [A Detailed Guide](https://developer.nordicsemi.com/nRF_Connect_SDK/doc/latest/nrf/device_guides/working_with_nrf/nrf52/gs.html)
        - Use the Garmin provided [firmware](https://developer.garmin.com/downloads/connect-iq/connectivity_2.0.1_115k2_with_s132_5.0.zip)
    - Add BLE com port into the simulator

### Making Changes
- dev is the default plan, created all feature branches from dev.
- Development process:
    - Request to merge feature branch into dev branch
    - Maintainers merge dev branch into stg branch for testing
    - Merge stg branch into main branch for deploying

#### Before making changes:
- Pull first to make sure dev is up to date! `git pull`
- From dev: Create new branch `git checkout -b <new-branch-name>`
#### When ready to push changes:
- Commit changes `git commit -m "<commit name>"`
- Push changes as a new upstream branch 
    - `git push --set-upstream origin/<branch-name>`
    - git gives you this command to copy paste if you `git push`
#### When ready to merge 
- create a Merge Request in gitlab
    - Include information about the changes and a video or screen shot of it working

#### Testing Changes
- Launch app in simulator
    - Run app from launch options
- Running on the watch
    - Build image: `CMD/CTRL + Shift + P` -> `MonkeyC: Build for Device`
        - select the './RwecsConnect/bin` dir as the build directory
        - Select debug version to capture detailed logs and stack trace
        - Add the .prg and debug.xml to the watches app folder

