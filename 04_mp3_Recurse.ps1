# 设置FFmpeg的路径，确保FFmpeg已安装并在系统路径中
$ffmpegPath = "ffmpeg"

# 定义输入和输出文件夹
$inputFolder = Read-Host "请输入【视频】存放路径"
$outputFolder = Read-Host "请输入【音频】保存路径"

# 获取输入文件夹中的所有 .mp4 文件
$mp4Files = Get-ChildItem -Path $inputFolder -Filter *.mp4 -File -Recurse

# 遍历每个 .mp4 文件并提取为 .mp3 文件
foreach ($mp4File in $mp4Files) {
    # 构建输出 MP3 文件名
    $mp3FileName = $mp4File.BaseName + ".mp3"

    # 构建完整的输入和输出路径
    $inputFilePath = $mp4File.FullName
    $outputFilePath = Join-Path -Path $outputFolder -ChildPath $mp3FileName

    # 构建 ffmpeg 命令并执行
    $ffmpegCommand = "ffmpeg -threads 6 -i `"$inputFilePath`" -f mp3 -vn `"$outputFilePath`""
    Invoke-Expression $ffmpegCommand
	
	Write-Host "`n已提取音频：$outputFilePath`n`n`n"
}

Write-Host "音频提取完成.`n"