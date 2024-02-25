# ָ��Ŀ��Ŀ¼
$targetDirectory = Read-Host "��������Ƶ·��"

# ָ�������Ƶ�ļ�����
$outputmp4 = Read-Host "������ϲ�����Ƶ���ƺͺ�׺��"

# ��ȡĿ��Ŀ¼�����е� .mp4 �ļ�
$mp4Files = Get-ChildItem -Path $targetDirectory -Filter *.mp4

# ָ������� txt �ļ�·��
$outputFile = "output.txt"
Write-Host "��Ƶ��������ļ���$outputFile"

# ����ÿ�� .mp4 �ļ�������ʽ���������д�� txt �ļ�
foreach ($file in $mp4Files) {
    $formattedName = "file '$targetDirectory\$($file.Name)'"
    Add-Content -Path $outputFile -Value $formattedName
}

# ������
Write-Host "�ļ��б��ѱ��浽 $outputFile"

# �����Ƶ����
Write-Host "�ϲ���Ƶ������"
Get-Content -Path $outputFile

# ��ʼ�ϲ���Ƶ
Write-Host "��ʼ�ϲ���Ƶ..."
ffmpeg.exe -f concat -safe 0 -i $outputFile -c copy -y $outputmp4

# ��ͣ 3 ��
Start-Sleep -Seconds 3

# ����ļ��Ƿ����
if (Test-Path $outputFile) {
    # ɾ���ļ�
    Remove-Item -Path $outputFile -Force
    Write-Host "output.txt�ļ���ɾ����ɡ�"
} else {
    Write-Host "output.txt�ļ������ڣ�����ɾ����"
}
