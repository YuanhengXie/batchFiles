# 指定目标目录
$targetDirectory = Read-Host "请输入视频路径"

# 指定输出视频文件名称
$outputmp4 = Read-Host "请输入合并后视频名称和后缀名"

# 获取目标目录中所有的 .mp4 文件
$mp4Files = Get-ChildItem -Path $targetDirectory -Filter *.mp4

# 指定输出的 txt 文件路径
$outputFile = "output.txt"
Write-Host "视频名单存放文件：$outputFile"

# 遍历每个 .mp4 文件并将格式化后的名称写入 txt 文件
foreach ($file in $mp4Files) {
    $formattedName = "file '$targetDirectory\$($file.Name)'"
    Add-Content -Path $outputFile -Value $formattedName
}

# 输出结果
Write-Host "文件列表已保存到 $outputFile"

# 输出视频名单
Write-Host "合并视频名单："
Get-Content -Path $outputFile

# 开始合并视频
Write-Host "开始合并视频..."
ffmpeg.exe -f concat -safe 0 -i $outputFile -c copy -y $outputmp4

# 暂停 3 秒
Start-Sleep -Seconds 3

# 检查文件是否存在
if (Test-Path $outputFile) {
    # 删除文件
    Remove-Item -Path $outputFile -Force
    Write-Host "output.txt文件已删除完成。"
} else {
    Write-Host "output.txt文件不存在，无需删除。"
}
