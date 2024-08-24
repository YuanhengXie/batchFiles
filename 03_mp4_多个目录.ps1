# 设置FFmpeg的路径，确保FFmpeg已安装并在系统路径中
$ffmpegPath = "ffmpeg"

# 设置根目录路径
# $rootDirectory = "C:\Users\xieyu\Desktop\缩略图-贝拉\待上传\mp3\Temp"
$rootDirectory = Read-Host "请输入子目录的路径"

# 获取根目录下的所有子目录
$subDirectories = Get-ChildItem -Path $rootDirectory -Directory

# 循环遍历每个子目录
foreach ($subDirectory in $subDirectories) {
	# 用于存储ts文件的数组
	$tsFiles = @()
	
    # 输出子目录名
    Write-Host "子目录: $($subDirectory.Name)"
    
    # 获取子目录下的所有mp4文件
    $mp4Files = Get-ChildItem -Path $subDirectory.FullName -Filter *.mp4 -File
    
    # 遍历每个mp4文件，进行转换
    foreach ($mp4File in $mp4Files) {
        Write-Host "  MP4文件: $($mp4File.Name)"
        # 构建输出的ts文件名
        $tsFileName = [System.IO.Path]::ChangeExtension($mp4File.Name, ".ts")

        # 构建完整的FFmpeg命令
        $ffmpegCommand = "$ffmpegPath -i `"$($subDirectory.FullName)\$mp4File`" -vcodec copy -acodec copy `"$tsFileName`""

        # 执行FFmpeg命令
        Invoke-Expression $ffmpegCommand

        # 将生成的ts文件添加到数组
        $tsFiles += $tsFileName
    }

    # 构建合并ts文件的命令
	$concatenationCommand = "$ffmpegPath -i `"concat:" + ($tsFiles -join "|") + "`" -acodec copy -vcodec copy `"【ASMR】$($subDirectory.Name) 2200 贝拉小姐姐 巅峰音质直播间～.mp4`""

    # 执行合并命令
    Invoke-Expression $concatenationCommand

    # 删除生成的ts文件
    Remove-Item $tsFiles

    Write-Host "转换和合并完成."
}

