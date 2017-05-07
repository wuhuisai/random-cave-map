//** 生成洞穴的规则
// 参数：数组、种类、循环次数
// 种类1 如果1圈砖大于5，就是砖
// 种类2 如果1圈砖大于5 或者 两圈小于2，就是砖
//** @Cricket 
var array, n, w, h, count, array2;

//接收参数
array = argument0;
type = argument1;
n = argument2;
w = array_height_2d(array);
h = array_length_2d(array, 0);

//循环规则
for(var m=0; m<n; m++)
for(var i=0; i<w; i++)
{
	for(var j=0; j<h; j++)
	{
		count1 = scr_check_neigh_wall(array, i, j, 1);
		if(type==1)
		{
			if(count1>=5)
				array2[i, j] = 1;
			else
				array2[i, j] = 0;
		}
		else
		{
			count2 = scr_check_neigh_wall(array, i, j, 2);
			if(count1>=5 || count2<=2)
				array2[i, j] = 1;
			else
				array2[i, j] = 0;
		}
	}
}

return array2;
