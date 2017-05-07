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
