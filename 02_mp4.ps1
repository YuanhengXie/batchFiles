# 设置FFmpeg的路径，确保FFmpeg已安装并在系统路径中
$ffmpegPath = "ffmpeg"

# 设置输入文件夹和输出文件名
$inputFolder = Read-Host "请输入视频路径"
$outputFileName = Read-Host "请输入合并后视频名称和后缀名"

# 获取文件夹中所有mp4文件
$mp4Files = Get-ChildItem -Path $inputFolder -Filter *.mp4

# 用于存储ts文件的数组
$tsFiles = @()

# 遍历每个mp4文件，进行转换
foreach ($mp4File in $mp4Files) {
    # 构建输出的ts文件名
    $tsFileName = [System.IO.Path]::ChangeExtension($mp4File.Name, ".ts")

    # 构建完整的FFmpeg命令
    # $ffmpegCommand = "$ffmpegPath -i `"$inputFolder\$mp4File`" -vcodec copy -acodec copy -vbsf h264_mp4toannexb `"$tsFileName`""
	$ffmpegCommand = "$ffmpegPath -i `"$inputFolder\$mp4File`" -vcodec copy -acodec copy `"$tsFileName`""

    # 执行FFmpeg命令
    Invoke-Expression $ffmpegCommand

    # 将生成的ts文件添加到数组
    $tsFiles += $tsFileName
}

# 构建合并ts文件的命令
$concatenationCommand = "$ffmpegPath -i `"concat:" + ($tsFiles -join "|") + "`" -acodec copy -vcodec copy -absf aac_adtstoasc `"$outputFileName`""

# 执行合并命令
Invoke-Expression $concatenationCommand

# 删除生成的ts文件
Remove-Item $tsFiles

Write-Host "转换和合并完成."
