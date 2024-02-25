# ����FFmpeg��·����ȷ��FFmpeg�Ѱ�װ����ϵͳ·����
$ffmpegPath = "ffmpeg"

# ���������ļ��к�����ļ���
$inputFolder = Read-Host "��������Ƶ·��"
$outputFileName = Read-Host "������ϲ�����Ƶ���ƺͺ�׺��"

# ��ȡ�ļ���������mp4�ļ�
$mp4Files = Get-ChildItem -Path $inputFolder -Filter *.mp4

# ���ڴ洢ts�ļ�������
$tsFiles = @()

# ����ÿ��mp4�ļ�������ת��
foreach ($mp4File in $mp4Files) {
    # ���������ts�ļ���
    $tsFileName = [System.IO.Path]::ChangeExtension($mp4File.Name, ".ts")

    # ����������FFmpeg����
    # $ffmpegCommand = "$ffmpegPath -i `"$inputFolder\$mp4File`" -vcodec copy -acodec copy -vbsf h264_mp4toannexb `"$tsFileName`""
	$ffmpegCommand = "$ffmpegPath -i `"$inputFolder\$mp4File`" -vcodec copy -acodec copy `"$tsFileName`""

    # ִ��FFmpeg����
    Invoke-Expression $ffmpegCommand

    # �����ɵ�ts�ļ���ӵ�����
    $tsFiles += $tsFileName
}

# �����ϲ�ts�ļ�������
$concatenationCommand = "$ffmpegPath -i `"concat:" + ($tsFiles -join "|") + "`" -acodec copy -vcodec copy -absf aac_adtstoasc `"$outputFileName`""

# ִ�кϲ�����
Invoke-Expression $concatenationCommand

# ɾ�����ɵ�ts�ļ�
Remove-Item $tsFiles

Write-Host "ת���ͺϲ����."
