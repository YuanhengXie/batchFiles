# bat
bat批处理脚本记录

脚本01：  
&nbsp;&nbsp;&nbsp;&nbsp;直接合成视频。 

脚本02：  
&nbsp;&nbsp;&nbsp;&nbsp;只能在当前目录中先转换为ts格式文件再合成视频。 

脚本03：  
&nbsp;&nbsp;&nbsp;&nbsp;只能提取当前目录中的mp4的音频，无法提取子目录中的。  

脚本04：  
&nbsp;&nbsp;&nbsp;&nbsp;递归提取包括子目录中的mp4的音频。  

脚本05：  
&nbsp;&nbsp;&nbsp;&nbsp;递归转换（包括子目录）为ts格式文件再合成视频。  

脚本06：  
&nbsp;&nbsp;&nbsp;&nbsp;转换当前目录内筛出的flv视频为mp4视频。  

脚本07:  
&nbsp;&nbsp;&nbsp;&nbsp;无损压缩10GB以上的mp4视频，可自定义压缩命令中的码率（当前为2000k），命令中使用N卡加速（可自定义，修改h264_nvenc为其他即可），脚本将压缩后的视频自动保存到当前目录中的temp目录（temp目录自动创建）。
