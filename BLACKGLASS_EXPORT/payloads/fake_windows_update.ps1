# Fake Update - Full screen fake Windows update UI
Add-Type -AssemblyName PresentationFramework
$code = '
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        WindowStyle="None" WindowState="Maximized" Background="DarkBlue" Topmost="True">
  <Grid><TextBlock Text="Installing Windows Updates 100%" 
                   Foreground="White" VerticalAlignment="Center" 
                   HorizontalAlignment="Center" FontSize="42"/></Grid>
</Window>'
[Windows.Markup.XamlReader]::Load((New-Object System.Xml.XmlTextReader([System.IO.StringReader]::new($code)))).ShowDialog()
