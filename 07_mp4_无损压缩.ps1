# 询问用户输入目录a的路径
$sourcePath = Read-Host "请输入源视频目录的路径"

# 检查目录是否存在
if (-Not (Test-Path $sourcePath)) {
    Write-Host "目录 $sourcePath 不存在，请检查路径后重试。" -ForegroundColor Red
    exit
}

# 创建temp目录
$tempPath = Join-Path $sourcePath "temp"
if (-Not (Test-Path $tempPath)) {
    New-Item -ItemType Directory -Path $tempPath
    Write-Host "创建temp目录: $tempPath" -ForegroundColor Green
} else {
    Write-Host "temp目录已存在: $tempPath" -ForegroundColor Yellow
}

# 递归筛选出大于10GB的mp4文件
$mp4Files = Get-ChildItem -Path $sourcePath -Recurse -Filter *.mp4 | Where-Object { $_.Length -gt 10GB }

if ($mp4Files.Count -eq 0) {
    Write-Host "没有找到大于10GB的mp4文件。" -ForegroundColor Yellow
    exit
}

# 对筛选出的文件进行无损压缩
foreach ($file in $mp4Files) {
    $sourceFile = $file.FullName
    $destinationFile = Join-Path $tempPath $file.Name
    
    Write-Host "正在压缩: $sourceFile"
    
    # 使用ffmpeg进行压缩
    $ffmpegCommand = "ffmpeg -i `"$sourceFile`" -c:v h264_nvenc -b:v 2000k -bufsize 2000k -preset medium -c:a copy -movflags +faststart `"$destinationFile`""
    
    # 执行ffmpeg命令
    Invoke-Expression $ffmpegCommand
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "压缩完成: $destinationFile" -ForegroundColor Green
    } else {
        Write-Host "压缩失败: $sourceFile" -ForegroundColor Red
    }
}

Write-Host "所有任务已完成。" -ForegroundColor Green
