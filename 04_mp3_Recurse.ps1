# ����FFmpeg��·����ȷ��FFmpeg�Ѱ�װ����ϵͳ·����
$ffmpegPath = "ffmpeg"

# �������������ļ���
$inputFolder = Read-Host "�����롾��Ƶ�����·��"
$outputFolder = Read-Host "�����롾��Ƶ������·��"

# ��ȡ�����ļ����е����� .mp4 �ļ�
$mp4Files = Get-ChildItem -Path $inputFolder -Filter *.mp4 -File -Recurse

# ����ÿ�� .mp4 �ļ�����ȡΪ .mp3 �ļ�
foreach ($mp4File in $mp4Files) {
    # ������� MP3 �ļ���
    $mp3FileName = $mp4File.BaseName + ".mp3"

    # ������������������·��
    $inputFilePath = $mp4File.FullName
    $outputFilePath = Join-Path -Path $outputFolder -ChildPath $mp3FileName

    # ���� ffmpeg ���ִ��
    $ffmpegCommand = "ffmpeg -threads 6 -i `"$inputFilePath`" -f mp3 -vn `"$outputFilePath`""
    Invoke-Expression $ffmpegCommand
	
	Write-Host "`n����ȡ��Ƶ��$outputFilePath`n`n`n"
}

Write-Host "��Ƶ��ȡ���.`n"