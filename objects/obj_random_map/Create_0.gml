//** @description Insert description here
// https://indienova.com/indie-game-development/procedural-content-generation-tile-based-random-cave-map/
//** @Cricket 随机洞穴


//定义数组大小
array_w = 100;
array_h = 100;


//生成随机地图二维数组
array = scr_create_map_array(array_w, array_h, 40, true);

//应用规则2
array = scr_map_array_ruler(array, 2, 4);
	
//应用规则1
array = scr_map_array_ruler(array, 1, 3);
	
//生成地图
scr_create_map_map(array);
