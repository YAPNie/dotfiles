# github-download

## Create a fine-grained token for a single repository with read-only access to everything

> Authentication/Account security/Managing your personal access tokens
> You can use a personal access token in place of a password when authenticating to GitHub in the command line or with the API.
> [GitHub Docs](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens)

1. Go to Settings: Click your profile picture in the top right corner of GitHub and select Settings.
2. Open Developer Settings: Scroll down the left sidebar and click Developer settings.
3. Select Fine-grained Tokens: Click Personal access tokens -> Fine-grained tokens.
4. Generate New Token: Click the Generate new token button.
5. Set Basics: Enter a Token name, set the Expiration date, and select your Resource owner (your account).
6. Select Repository: In the Repository access section, choose Only select repositories and select your specific repository from the dropdown.
7. Grant Read-Only Access:

   - Scroll down to Permissions -> Repository permissions.
   - Change Contents to Read-only (this automatically sets Metadata to Read-only).
   - Change Releases to Read-only.

8. Generate and Copy: Scroll to the bottom, click Generate token, and immediately copy the token (you won't see it again).

## Clone the repository using your Fine-grained Token in Windows

1. Open the Terminal: Press Win + X and select either Terminal, PowerShell, or Command Prompt.
2. Navigate to Target Folder: Use the cd command to go to the folder where you want to download the repository.

```cmd
cd C:\Users\YourUsername\Projects
```

3. Run the Clone Command: Execute the following command, replacing the placeholders with your actual token, username, and repository name:
   

```cmd
git clone https://github.com
```
  
(Note: For fine-grained tokens, you do not need to include your username before the @ symbol; just paste the token itself, like https://github.com...)

```cmd
$ git clone https://github.com/USERNAME/REPO.git
Username: YOUR-USERNAME
Password: YOUR-PERSONAL-ACCESS-TOKEN
```

## Download a release in Windows

1. Open PowerShell: Press Win + R, type powershell, and hit Enter.
2. Set Your Variables: Run this block to set your GitHub details (replace placeholders with your actual data):

```powershell
$TOKEN = "your_fine_grained_token"
$OWNER = "github_username_or_org"
$REPO  = "repository_name"
```

3. Find the Latest Pre-release: Run this command to fetch all releases and filter for the most recent pre-release:

```powershell
$headers = @{ "Authorization" = "Bearer $TOKEN"; "Accept" = "application/vnd.github+json" }
$releases = Invoke-RestMethod -Uri "https://github.com" -Headers $headers
$latestPreRelease = $releases | Where-Object { $_.prerelease -eq $true } | Select-Object -First 1
```

4. Get the Asset URL: Extract the download URL for the specific artifact you need (e.g., an .exe, .zip, or .msi file attached to that release):

```powershell
# This picks the very first attached file. Change index [0] if there are multiple assets.
$asset = $latestPreRelease.assets[0] 
$downloadUrl = $asset.url
$fileName = $asset.name
```

5. Download the File: Run the final command to securely download the artifact to your current directory:

```powershell
$downloadHeaders = $headers + @{ "Accept" = "application/octet-stream" }
Invoke-WebRequest -Uri $downloadUrl -Headers $downloadHeaders -OutFile $fileName
```
