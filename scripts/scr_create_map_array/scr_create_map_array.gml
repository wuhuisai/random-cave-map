//** 生成随机地图二维数组
// 参数：宽、高、墙的密度、是否边界
//** @Cricket 

var w, h, rand, array;

//接收参数
w = argument0;
h = argument1;
rand = argument2;
bian = argument3;

//设置随机种子
random_set_seed(current_time);

//循环初始化
for(var i=0; i<w; i++)
{
	for(var j=0; j<h; j++)
	{
		var r = irandom(99);
		if(r<rand)
			array[i, j] = 1;
		else
			array[i, j] = 0;
			
		if(bian)
		if(i==0 || j==0 || i==w-1 || j==h-1)
			array[i, j] = 1;
			
	}
}

return array;
