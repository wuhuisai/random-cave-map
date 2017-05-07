//** 创建随机地图，这里可忽略
// 参数：数组
//** @Cricket 

var array, w, h;

//接收参数
array = argument0;
w = array_height_2d(array);
h = array_length_2d(array, 0);

//销毁
with(obj_wall)
	instance_destroy(id)
	
//循环生成
for(var i=0; i<w; i++)
{
	for(var j=0; j<h; j++)
	{
		if(array[i, j]==1)
			instance_create_depth(i*8, j*8, 0, obj_wall);
	}
}

