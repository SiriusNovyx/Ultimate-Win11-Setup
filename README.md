<h1 align="center">⚠️ UNDER CONSTRUCTION ⚠️</h1>
<h3 align="center">✨ My Windows 11 Setup ✨</h3>

<p align="center">
A complete guide to my Windows 11 customization – from the YASB bar to all the little tweaks that make it clean, aesthetic, and productive.
</p>

---

## 🖼️ Screenshot
![My Desktop Screenshot](screenshot.png)  _I will add this later, dw._

---

## 📑 Table of Contents

| 📚 Entry | ✨ App |
|---------------------|------------|
| Status Bar          | [YASB](#yasb) |
| Window Manager      | [GlazeWM](#glazewm) |
| App Launcher        | [Flow Launcher](#flowlauncher) |
| Taskbar             | [Windhawk](#windhawk) |
| Text Editor         | [VSCode](#vscode) |
| Terminal            | [Windows Terminal](#windows-terminal) |
| Browser             | [Brave](#brave) |
| System Fetch        | [Fastfetch](#Fastfetch) |   
| Shell Prompt        | [Oh My Posh](#ohmyposh) |
| Audio Visualizer    | [Cava](#cava) |
| Music Player        | [Spotify](#spotify) | 
| Note Taking         | [Notesnook](#notesnook) |
| Screen Recording    | [OBS Studio](#obsstudio) |
| File Explorer Mod   | [ExplorerBlurMica](#ExplorerBlurMica) |
| Other Tools         | [Extras](#extras) |

Other

| 📚 Entry | ✨ App |
|---------------------|------------|
| Colorscheme         | [Catppuccin Mocha](https://catppuccin.com) |
| Font                | [JetBrainsMono Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip) |


---

# ⚡ Details

## 📏 YASB
> [!NOTE] 
> Some stuff in my config might not work if you just copy and paste it. Be sure to app your api for the weather widget to work and your wallpaper folder location for the wallpapers widget

A highly configurable Windows status bar written in Python. 

**⚙️ Installation:**  
You can follow the steps below, or jump to the [**setup video**](https://www.youtube.com/watch?v=your-video-id).
- Install [**YASB**]([(https://github.com/amnweb/yasb)])   
- Copy the config files from [**here**](https://github.com/SiriusNovyx/Ultimate-Win11-Setup/tree/main/YASB).
- Remove the codes from **your** YASB config and paste the one you just copied.
- Restart **YASB** for the changes to take effect.

---

## 🪟 GlazeWM + YASB
> [!NOTE] 
> If your using my config then Zebar won't work as I use GlazeWM with YASB. I recommend adding those 2 lines of code back which I had deleted if you wanna use Zebar

GlazeWM lets you easily organize windows and adjust their layout on the fly by using keyboard-driven commands.  

**⚙️ Installation:**  
You can follow the steps below, or jump to the [**setup video**](https://youtu.be/b57zFm3nVxA).
- Install [**GlazeWM**](https://github.com/glzr-io/glazewm)   
- Copy the config file from [**here**](https://github.com/SiriusNovyx/Ultimate-Win11-Setup/tree/main/GlazeWM).
- Remove the codes from **your** GlazeWM config and paste the one you just copied.
- Restart **GlazeWM** for the changes to take effect.

---

## 🦅 Windhawk
> [!NOTE] 
> Right now I have just listed the advance section codes for the mods I use. If your using the taskbar config of mine then it would remove the start menu and network icon. To add them back follow [**this**](https://github.com/ramensoftware/windows-11-taskbar-styling-guide)

Windhawk aims to make it easier to customize Windows programs.

**⚙️ Installation:**  
You can follow the steps below, or jump to the [**setup video**](https://youtu.be/b57zFm3nVxA) if you wanna know more about the taskbar.
- Install [**Windhawk**](https://windhawk.net/)   
- Copy the config file from [**here**](https://github.com/SiriusNovyx/Ultimate-Win11-Setup/tree/main/Windhawk).
- Remove the codes from the advance section in **your** Windhawk mod and paste the one you just copied.
- Click **Save settings** for the changes to take effect.

---

## 🔍 Flow Launcher

Quick File Search & App Launcher for Windows

**⚙️ Installation:**  
You can follow the steps below,
- Install [**Flow Launcher**](https://www.flowlauncher.com/).
- Download the theme file from [**here**](https://github.com/SiriusNovyx/Ultimate-Win11-Setup/tree/main/Flow%20Launcher).
- Open Flow Launcher's Settings window, select **Appearance** on the sidebar, and click the "Open Theme Folder" button at the bottom.
- Move your theme file downloaded in Step 1 to this directory, and restart Flow Launcher.
- Again in Flow Launcher's Settings window, select **Appearance** on the sidebar, and select your Catppuccin flavor from the list of themes.
Installation guide was taken from [**here**](https://github.com/catppuccin/flow-launcher). Thanks :)

---

## 📁 ExplorerBlurMica
> [!NOTE] 
> A few people had said that they are getting bugs and crashes by using this, so I recommend to now use it and follow the windhawk method **here** (video will be added soon)

Add background Blur effect or Acrylic or Mica effect to explorer for win10 and win11

**⚙️ Installation:**  
You can follow the steps below, or jump to the [**setup video**](https://youtu.be/gpGeCZXXsbs).
- Install [**ExplorerBlurMica**](https://github.com/Maplespe/ExplorerBlurMica/releases)   
- Copy the config file from [**here**](https://github.com/SiriusNovyx/Ultimate-Win11-Setup/tree/main/File%20Explorer).
- For the next part, I'm using the default stuff so just follow the installation from [**here**](https://github.com/Maplespe/ExplorerBlurMica?tab=readme-ov-file#install) 

---

## 👾 Terminal + Fastfetch

> [!NOTE] 
> If you want a 1:1 replica of my setup, I recommend following the [**Setup Video**](https://youtu.be/z3NpVq-y6jU). If you only want the Fastfetch aesthetic, simply drop the config into your existing Fastfetch directory. If you already have an existing PowerShell profile, merge the contents rather than overwriting what you already have.

> [!IMPORTANT]
> **Font Requirement**: To render all icons properly without broken boxes or missing glyphs, install and select a Nerd Font in Windows Terminal (e.g., [**JetBrainsMono Nerd Font**](https://www.nerdfonts.com/font-downloads)).

> [!TIP]
> * **Script Execution Error**: If you see `"execution of scripts is disabled on this system"`, open PowerShell as Administrator and run: 
>   ```powershell
>   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
>   ```
> * **1-Command Tool Installer**: Once you've loaded this profile, you can simply type `install-tools` to automatically install Fastfetch and Zoxide, or type `check-tools` to view your setup status.
> * **Manual Tool Installation**: You can also install the recommended packages manually via WinGet:
>   ```powershell
>   winget install Fastfetch-cli.Fastfetch ajeetdsouza.zoxide
>   ```
> * **ASCII Art Not Showing?** Ensure the source path in `config.jsonc` points to `"~/.config/fastfetch/ascii.txt"` rather than a doubled `C:/Users/...` path. ([**Credits**](https://github.com/SiriusNovyx/Ultimate-Win11-Setup/issues/1#issue-3498937609)).
> * **Add Fastfetch to CMD**: Want Fastfetch on Command Prompt too? Check out this [**guide / issue**](https://github.com/SiriusNovyx/Ultimate-Win11-Setup/issues/9#issue-3958846174) (Big thanks to [**Augtive85YT**](https://github.com/Augtive85YT)!).

---

Fastfetch is a modern, high-performance `neofetch`-like system information tool written in C, built for speed and deep visual customization.

### ⚙️ Installation & Setup

Follow the steps below, or follow along with the [**Setup Video**](https://youtu.be/z3NpVq-y6jU).

1. **Install Prerequisites**:
   * Install [**Fastfetch**](https://github.com/fastfetch-cli/fastfetch/releases) and [**Zoxide**](https://github.com/ajeetdsouza/zoxide) (`winget install Fastfetch-cli.Fastfetch ajeetdsouza.zoxide`).
   * Ensure [**Windows Terminal**](https://apps.microsoft.com/detail/9n0dx20hk701) and [**JetBrainsMono Nerd Font**](https://www.nerdfonts.com/font-downloads) are installed.

2. **Download Configurations**:
   * [**Windows Terminal (`settings.json`)**](https://github.com/SiriusNovyx/Ultimate-Win11-Setup/tree/main/Terminal)
   * [**PowerShell Profile (`Microsoft.PowerShell_profile.ps1`)**](https://github.com/SiriusNovyx/Ultimate-Win11-Setup/tree/main/PowerShell)
   * [**Fastfetch Configuration & ASCII Art**](https://github.com/SiriusNovyx/Ultimate-Win11-Setup/tree/main/Fastfetch)

3. **Deploy the Configs**:
   * **Windows Terminal**: Open Windows Terminal Settings (`Ctrl + ,`), click the bottom-left gear icon to **Open JSON file**, and replace or merge its contents with the downloaded `settings.json`.
   * **PowerShell Profile**: In PowerShell, type `notepad $PROFILE`. If prompted to create the file, click **Yes**, and paste the profile code.
   * **Fastfetch Config**:
     * Navigate to `%USERPROFILE%` (e.g., `C:\Users\<YourUsername>`).
     * Create a `.config` folder if it doesn't already exist, and create a `fastfetch` subfolder inside:
       ```
       %USERPROFILE%\.config\fastfetch\
       ```
     * Place your `config.jsonc` and `ascii.txt` into that directory.

4. **Verify Paths**:
   * Open `config.jsonc` and ensure the logo source path reads:
     ```jsonc
     "source": "~/.config/fastfetch/ascii.txt"
     ```
   * Restart Windows Terminal and you're all set!

---

## 📝 VSCode
> [!NOTE] 
> This is just the base settings of my VSCode. Your(s) might look different than mine because I use many extensions along side that. I will try keeping my **Extensions** list up-to-date.

Visual Studio Code (VS Code) is a free, open-source code editor by Microsoft for building and debugging modern web and cloud applications.

**⚙️ Installation:**  
You can follow the steps below, or jump to the [setup video](https://www.youtube.com/watch?v=your-video-id). (Video will be added soon)
- Install [**VSCode**](https://code.visualstudio.com/).
- Copy the config file:  
  `VSCode/Settings/settings.json → %APPDATA%\Code\User\settings.json`.  
- Restart **VSCode** for the changes to take effect.

**🔧 Extensions:**
- [Catppuccin for VSCode](https://marketplace.visualstudio.com/items?itemName=Catppuccin.catppuccin-vsc) - 🦌 Soothing pastel theme for VSCode.
- [Catppuccin Icons for VSCode](https://marketplace.visualstudio.com/items?itemName=Catppuccin.catppuccin-vsc-icons) - 🦊 Soothing pastel icon theme for VSCode.
- [VSCode Pets](https://marketplace.visualstudio.com/items?itemName=tonybaloney.vscode-pets) - Puts a pet in your code editor to boost productivity. 

---

## 🪟 AppName
> [!NOTE] 
> This setup is compatible with the latest version of **AppName**.

A short description about what the app/config does and why you’re using it.  
(Example: Minimal tiling window manager setup with custom keybindings and themes.)

**⚙️ Installation:**  
You can follow the steps below, or jump to the [setup video](https://www.youtube.com/watch?v=your-video-id).
- Install [**AppName**](https://appname-website.com/download)   
- Copy the config file:  
  `windots/.config/appname/config.file → %USERPROFILE%\.config\appname\config.file`  
- Restart **AppName** for the changes to take effect

---

### Arc Browser
Browser for work + aesthetic flow.  
**Features:**
- Minimal UI  
- Vertical tabs  
- Productivity features  

---

### Extras
Other little tools & tweaks I use.  
- [Wallpaper Engine](#)  
- [AutoHotKey Scripts](#)  
- [RoundedTB](#)  

---

