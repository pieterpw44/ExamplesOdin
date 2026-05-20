package main

import "core:math"
import rl "vendor:raylib"

main :: proc() {
	// Conctants used in the program
	SCRWIDTH: i32 : 800
	SCRHEIGHT: i32 : 450
	MAX_BUILDINGS: i32 : 100

	// Create the window and close at end of scope
	rl.InitWindow(SCRWIDTH, SCRHEIGHT, "Raylib [core] 2d camera")
	defer rl.CloseWindow()

	// Create the example objects
	player: rl.Rectangle = {400, 280, 40, 40}
	buildings: [MAX_BUILDINGS]rl.Rectangle
	buildColors: [MAX_BUILDINGS]rl.Color

	// The spacing between the buildings, initially 0
	spacing: i32

	for i in 0 ..< MAX_BUILDINGS {
		buildings[i].width = cast(f32)rl.GetRandomValue(50, 200)
		buildings[i].height = cast(f32)rl.GetRandomValue(100, 800)
		buildings[i].y = cast(f32)SCRHEIGHT - cast(f32)130.0 - buildings[i].height
		buildings[i].x = cast(f32)-6000.0 + cast(f32)spacing

		spacing += cast(i32)buildings[i].width

		buildColors[i] = {
			cast(u8)rl.GetRandomValue(200, 240),
			cast(u8)rl.GetRandomValue(200, 240),
			cast(u8)rl.GetRandomValue(200, 250),
			255,
		}
	}

	// Camera stuff
	camera: rl.Camera2D
	camera.target = (rl.Vector2){player.x + 20.0, player.y + 20.0}
	camera.offset = (rl.Vector2){(f32)(SCRWIDTH / 2.0), (f32)(SCRHEIGHT / 2.0)}
	camera.rotation = 0
	camera.zoom = 1.0

	rl.SetTargetFPS(60)

	for !rl.WindowShouldClose() {
		if rl.IsKeyDown(.RIGHT) do player.x += 2
		else if rl.IsKeyDown(.LEFT) do player.x -= 2
		camera.target = (rl.Vector2){player.x + 20, player.y + 20}

		if rl.IsKeyDown(.A) do camera.rotation -= 1
		else if rl.IsKeyDown(.S) do camera.rotation += 1

		if camera.rotation > 40 do camera.rotation = 40
		else if camera.rotation < -40 do camera.rotation = -40

		// Camera zoom controls
		// uses log scaling to provide consistent zoom speed
		camera.zoom = math.exp_f32(
			math.logb_f32(camera.zoom) + (f32)(rl.GetMouseWheelMove() * 0.1),
		)

		if camera.zoom > 3.0 do camera.zoom = 3.0
		else if camera.zoom < 0.1 do camera.zoom = 0.1

		if rl.IsKeyPressed(.R) {
			camera.zoom = 1.0
			camera.rotation = 0.0
		}

		rl.BeginDrawing()
		rl.ClearBackground(rl.RAYWHITE)

		rl.BeginMode2D(camera)
		rl.DrawRectangle(-6000, 320, 13000, 8000, rl.DARKGRAY)
		for i in 0 ..< MAX_BUILDINGS do rl.DrawRectangleRec(buildings[i], buildColors[i])
		rl.DrawRectangleRec(player, rl.RED)

		rl.DrawLine(
			cast(i32)camera.target.x,
			-SCRHEIGHT * 10,
			cast(i32)camera.target.x,
			SCRHEIGHT * 10,
			rl.GREEN,
		)

		rl.DrawLine(
			-SCRWIDTH * 10,
			cast(i32)camera.target.y,
			SCRWIDTH * 10,
			cast(i32)camera.target.y,
			rl.GREEN,
		)
		rl.EndMode2D()

		rl.DrawText("SCREEN AREA:", 640, 10, 20, rl.RED)

		// Draws an outline around the window
		rl.DrawRectangle(0, 0, SCRWIDTH, 5, rl.RED)
		rl.DrawRectangle(0, 5, 5, SCRHEIGHT - 10, rl.RED)
		rl.DrawRectangle(SCRWIDTH - 5, 5, 5, SCRHEIGHT - 10, rl.RED)
		rl.DrawRectangle(0, SCRHEIGHT - 5, SCRWIDTH, 5, rl.RED)

		rl.DrawRectangle(10, 10, 250, 113, rl.Fade(rl.SKYBLUE, 0.5))
		rl.DrawRectangleLines(10, 10, 250, 113, rl.BLUE)

		rl.DrawText("Free 2D camera controls:", 20, 20, 10, rl.BLACK)
		rl.DrawText("- Right/Left to move the player", 40, 40, 10, rl.DARKGRAY)
		rl.DrawText("- Mouse wheel  to zoom in-out", 40, 60, 10, rl.DARKGRAY)
		rl.DrawText("- A / S to Rotate", 40, 80, 10, rl.DARKGRAY)
		rl.DrawText("- R to reset Zoom and Rotation", 40, 100, 10, rl.DARKGRAY)
		rl.EndDrawing()
	}
}

