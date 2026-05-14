package main

import rl "vendor:raylib"

main :: proc() {
	WINDOWWIDTH :: 800
	WINDOWHEIGHT :: 450

	rl.InitWindow(i32(WINDOWWIDTH), i32(WINDOWHEIGHT), "raylib [core] input keys example")
	defer rl.CloseWindow()

	rl.SetTargetFPS(60)

	ballPosition: rl.Vector2 = {f32(WINDOWWIDTH / 2), f32(WINDOWHEIGHT / 2)}

	for !rl.WindowShouldClose() {
		if (rl.IsKeyDown(.RIGHT)) do ballPosition.x += 2.0
		if (rl.IsKeyDown(.LEFT)) do ballPosition.x -= 2.0
		if (rl.IsKeyDown(.UP)) do ballPosition.y -= 2.0
		if (rl.IsKeyDown(.DOWN)) do ballPosition.y += 2.0

		rl.BeginDrawing()
			rl.ClearBackground(rl.RAYWHITE)
			rl.DrawText("move ball with the arrow keys", 10, 10, 20, rl.DARKGRAY)
			rl.DrawCircleV(ballPosition, 50, rl.MAROON)
		rl.EndDrawing()
	}
}
