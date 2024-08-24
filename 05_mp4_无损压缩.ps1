# ѯ���û�����Ŀ¼a��·��
$sourcePath = Read-Host "������Դ��ƵĿ¼��·��"

# ���Ŀ¼�Ƿ����
if (-Not (Test-Path $sourcePath)) {
    Write-Host "Ŀ¼ $sourcePath �����ڣ�����·�������ԡ�" -ForegroundColor Red
    exit
}

# ����tempĿ¼
$tempPath = Join-Path $sourcePath "temp"
if (-Not (Test-Path $tempPath)) {
    New-Item -ItemType Directory -Path $tempPath
    Write-Host "����tempĿ¼: $tempPath" -ForegroundColor Green
} else {
    Write-Host "tempĿ¼�Ѵ���: $tempPath" -ForegroundColor Yellow
}

# �ݹ�ɸѡ������10GB��mp4�ļ�
$mp4Files = Get-ChildItem -Path $sourcePath -Recurse -Filter *.mp4 | Where-Object { $_.Length -gt 10GB }

if ($mp4Files.Count -eq 0) {
    Write-Host "û���ҵ�����10GB��mp4�ļ���" -ForegroundColor Yellow
    exit
}

# ��ɸѡ�����ļ���������ѹ��
foreach ($file in $mp4Files) {
    $sourceFile = $file.FullName
    $destinationFile = Join-Path $tempPath $file.Name
    
    Write-Host "����ѹ��: $sourceFile"
    
    # ʹ��ffmpeg����ѹ��
    $ffmpegCommand = "ffmpeg -i `"$sourceFile`" -c:v h264_nvenc -b:v 2000k -bufsize 2000k -preset medium -c:a copy -movflags +faststart `"$destinationFile`""
    
    # ִ��ffmpeg����
    Invoke-Expression $ffmpegCommand
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "ѹ�����: $destinationFile" -ForegroundColor Green
    } else {
        Write-Host "ѹ��ʧ��: $sourceFile" -ForegroundColor Red
    }
}

Write-Host "������������ɡ�" -ForegroundColor Green
