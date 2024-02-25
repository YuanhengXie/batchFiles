# 设置FFmpeg的路径，确保FFmpeg已安装并在系统路径中
$ffmpegPath = "ffmpeg"

# 设置输入文件夹和输出文件名
$inputFolder = Read-Host "请输入【视频】存放路径"
$outputFolder = Read-Host "请输入【音频】保存路径"

# 获取文件夹中所有mp4文件
$mp4Files = Get-ChildItem -Path $inputFolder -Filter *.mp4

# 遍历每个mp4文件，进行转换
foreach ($mp4File in $mp4Files) {
    # 构建输出的mp3文件名
    $mp3FileName = [System.IO.Path]::ChangeExtension($mp4File.Name, ".mp3")

    # 构建完整的FFmpeg命令
    $ffmpegCommand = "$ffmpegPath -i `"$inputFolder\$mp4File`" -f mp3 -vn `"$outputFolder\$mp3FileName`""

    # 执行FFmpeg命令
    Invoke-Expression $ffmpegCommand
	
	Write-Host "已提取音频：$outputFolder\$mp3FileName"
}

Write-Host "音频提取完成."