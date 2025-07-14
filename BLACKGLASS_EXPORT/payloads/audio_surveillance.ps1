Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Speech

$speech = New-Object System.Speech.Recognition.SpeechRecognitionEngine
$grammar = New-Object System.Speech.Recognition.DictationGrammar
$speech.LoadGrammar($grammar)
$speech.SetInputToDefaultAudioDevice()

$writer = New-Object System.IO.StreamWriter("$env:TEMP\\audio_log.txt")

$speech.SpeechRecognized += {
    $writer.WriteLine($_.Result.Text)
    $writer.Flush()
}

$speech.RecognizeAsync([System.Speech.Recognition.RecognizeMode]::Multiple)
Start-Sleep -Seconds 60
$speech.RecognizeAsyncStop()
$writer.Close()
