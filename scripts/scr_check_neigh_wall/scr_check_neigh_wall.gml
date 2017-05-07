//** 获取二维数组元素周围墙个数
// 参数：数组、dx 、dy、l几圈
//** @Cricket 

var array, dx, dy, l, w, h, n = 0;

//接收参数
array = argument0;
dx = argument1;
dy = argument2;
l = argument3;
w = array_height_2d(array);
h = array_length_2d(array, 0);

//循环获取
for(var i=0; i<l*2+1; i++)
{
	for(var j=0; j<l*2+1; j++)
	{
		//超范围判断
		if(dx+i-l>=0 && dx+i-l<=w-1 && dy+j-l>=0 && dy+j-l<=h-1)
		{
			if(array[dx+i-l, dy+j-l]==1)
			{
				n++;
			}
		}
		else
			n++;
	}
}

return n;
