#random-cave-map

首先，我们要生成一幅随机地图，我们通过控制随机数的范围分布来实现它。一般情况下，我们采用小于 50% 的几率来生成墙，其余的就是地面。地面是可行走的，而墙则是可碰撞的。

<!--more-->

> 参考文章：  


[https://indienova.com/indie-game-development/procedural-content-generation-tile-based-random-cave-map/](https://indienova.com/indie-game-development/procedural-content-generation-tile-based-random-cave-map/ "https://indienova.com/indie-game-development/procedural-content-generation-tile-based-random-cave-map/")

> Demo下载：  


[点击下载：随机洞穴-Cricket.yyz](http://www.huisai.top/wp-content/uploads/2017/05/随机洞穴-Cricket.yyz "点击下载：随机洞穴-Cricket.yyz")

------------

>### 生成数组  

首先实现生成一个随机数组的函数：

```cpp  

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

```

上面的函数返回一个二维数组，里面存储着随机的地图数据，调用例子如下：  
生成一个40*40个元素，墙壁密度是40%，且用墙壁包围的地图数组。  

```cpp  

	//定义数组大小
	array_w = 40;
	array_h = 40;
	
	
	//生成随机地图二维数组
	array = scr_create_map_array(array_w, array_h, 40, true);

```

----------
>### 整理地图  

然后该整理地图，规则就是遍历数组，  
1. 如果元素一圈外有5个以上的墙壁，就把他设置为墙壁，具体作用就是会清理零星的墙壁，成堆的墙壁会更大。  
2. 如果元素两圈外有小于2个的墙壁，就把他设置为墙壁，具体的作用是会填充巨大的空白区域。  

```cpp  

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
	
```

----------
>### 获取周围墙壁个数  

要完成上面的函数，还需要一个子函数，就是获取元素周围的墙壁个数。  

```cpp  
	
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
	
```


----------
>### 测试代码  


```cpp  
	
	主要代码完毕，测试开始：
	
	//定义数组大小
	array_w = 40;
	array_h = 40;
	
	
	//生成随机地图二维数组
	array = scr_create_map_array(array_w, array_h, 40, true);
	
	//应用规则2
	array = scr_map_array_ruler(array, 2, 4);
		
	//应用规则1
	array = scr_map_array_ruler(array, 1, 3);
	
```

利用show_debug_message输出数据，期间测试了很多次，也有很多bug，例如：

1. 在整理数组时需要新建一个数组，不要直接改变传过来的数组
2. GMS2的for循环，循环变量不支持负数

数组没有问题还需要显示出来看看：

```cpp  
	
	
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
				instance_create_depth(i*16, j*16, 0, obj_wall);
		}
	}
	
	
```



动态测试代码：  

```cpp  
	
	if(keyboard_check_pressed(vk_space))
	{
		//应用规则1
		array = scr_map_array_ruler(array, 1, 1);
		
		//生成地图
		scr_create_map_map(array);
	}
	
	if(mouse_check_button_pressed(mb_left))
	{
		//应用规则2
		array = scr_map_array_ruler(array, 2, 1);
		
		//生成地图
		scr_create_map_map(array);
	}
	
	if(mouse_check_button_pressed(mb_right))
	{
		//生成随机地图二维数组
		array = scr_create_map_array(array_w, array_h, 40, true);
		
		//生成地图
		scr_create_map_map(array);
	}

	
```
<center>
[!http://www.huisai.top/wp-content/uploads/2017/05/随机地图动图.gif](http://www.huisai.top/wp-content/uploads/2017/05/随机地图动图.gif)
</center>

----------
