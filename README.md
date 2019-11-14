<h1>GIF Maker by Petmshall</h1>

This script is used to convert videos to animated GIFs using FFMPEG on Linux.
<br/><br/>
<strong>Syntax:</strong>
bash gifmaker.sh input output quality [resolution] [framerate]
<br/><br/>
<strong>Quality options:</strong>
<p>
<b>0 / lowest:</b> 80p 10fps (Not recommended at all)
<br/>
<b>1 / lower:</b> 120p 10fps (Very fast to convert)
<br/>
<b>2 / low:</b> 240p 15fps (Recommended for internet use)
<br/>
<b>3 / medium:</b> 360p 15fps (Best balance of quality vs file size and speed)
<br/>
<b>4 / high:</b> 480p 20fps (More resources but still acceptable)
<br/>
<b>5 / highest:</b> 720p 25fps (Not recommended)
<br/>
<b>custom:</b> Use for custom parameters
</p>
<h2>Examples</h2>
Here is a generic example of this script being used:
<br/>
<code>bash gifmaker.sh input.mp4 output.gif medium</code>
<br/>
Notice that you can also specify a number as a quality option. This command does the exact same thing as the last.
<br/>
<code>bash gifmaker.sh input.mp4 output.gif 3</code>
<br/><br/>
The End. That's all there is to it!
