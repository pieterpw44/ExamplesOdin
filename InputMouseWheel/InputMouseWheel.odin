package main

import rl "vendor:raylib"

main :: proc() {
	SCRWIDTH: i32 : 800
	SCRHEIGHT: i32 : 450

	rl.InitWindow(SCRWIDTH, SCRHEIGHT, "Raylib core [ - Input Mouse Wheel]")
	defer rl.CloseWindow()

	boxPositionY: i32 = SCRHEIGHT / 2 - 40
	scrollSpeed: i32 = 4

	rl.SetTargetFPS(60)

	for !rl.WindowShouldClose() {
		boxPositionY -= cast(i32)(rl.GetMouseWheelMove()) * scrollSpeed
		rl.BeginDrawing()
		rl.ClearBackground(rl.RAYWHITE)
		rl.DrawRectangle(SCRWIDTH / 2, cast(i32)boxPositionY, 80, 80, rl.MAROON)
		rl.DrawText("Use mouse wheel to move the cube up and down!", 10, 10, 20, rl.GRAY)
		rl.DrawText(rl.TextFormat("Box position Y: %03i", boxPositionY), 10, 40, 20, rl.LIGHTGRAY)
		rl.EndDrawing()
	}
}

