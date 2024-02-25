# ����FFmpeg��·����ȷ��FFmpeg�Ѱ�װ����ϵͳ·����
$ffmpegPath = "ffmpeg"

# ���������ļ��к�����ļ���
$inputFolder = Read-Host "�����롾��Ƶ�����·��"
$outputFolder = Read-Host "�����롾��Ƶ������·��"

# ��ȡ�ļ���������mp4�ļ�
$mp4Files = Get-ChildItem -Path $inputFolder -Filter *.mp4

# ����ÿ��mp4�ļ�������ת��
foreach ($mp4File in $mp4Files) {
    # ���������mp3�ļ���
    $mp3FileName = [System.IO.Path]::ChangeExtension($mp4File.Name, ".mp3")

    # ����������FFmpeg����
    $ffmpegCommand = "$ffmpegPath -i `"$inputFolder\$mp4File`" -f mp3 -vn `"$outputFolder\$mp3FileName`""

    # ִ��FFmpeg����
    Invoke-Expression $ffmpegCommand
	
	Write-Host "����ȡ��Ƶ��$outputFolder\$mp3FileName"
}

Write-Host "��Ƶ��ȡ���."