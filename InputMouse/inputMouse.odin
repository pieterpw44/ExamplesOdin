package main

import rl "vendor:raylib"

main :: proc() {
	WINDOWWIDTH :: 800
	WINDOWHEIGHT :: 450

	rl.InitWindow(i32(WINDOWWIDTH), i32(WINDOWHEIGHT), "raylib [core] input mouse example")
	defer rl.CloseWindow()

	ballPosition: rl.Vector2 = {f32(-100.0), f32(-100.0)}
	ballColour: rl.Color = rl.DARKBLUE

	rl.SetTargetFPS(60)

	for !rl.WindowShouldClose() {
		if rl.IsKeyPressed(.H) {
			if rl.IsCursorHidden() {
				rl.ShowCursor()
			} else {
				rl.HideCursor()
			}
		}

		ballPosition = rl.GetMousePosition()

		if rl.IsMouseButtonPressed(.LEFT) do ballColour = rl.MAROON
		else if rl.IsMouseButtonPressed(.MIDDLE) do ballColour = rl.LIME
		else if rl.IsMouseButtonPressed(.RIGHT) do ballColour = rl.DARKBLUE
		else if rl.IsMouseButtonPressed(.SIDE) do ballColour = rl.PURPLE
		else if rl.IsMouseButtonPressed(.EXTRA) do ballColour = rl.YELLOW
		else if rl.IsMouseButtonPressed(.FORWARD) do ballColour = rl.ORANGE
		else if rl.IsMouseButtonPressed(.BACK) do ballColour = rl.BEIGE

		rl.BeginDrawing()
			rl.ClearBackground(rl.RAYWHITE)
			rl.DrawCircleV(ballPosition, 40, ballColour)
			rl.DrawText("move ball with the mouse and click the mouse button to change colour", 10, 10, 20, rl.DARKGRAY)
			rl.DrawText("Press 'H' to toggle cursor visibility", 10 ,30, 20, rl.DARKGRAY)

			if rl.IsCursorHidden() {
				rl.DrawText("CURSOR HIDDEN", 20, 60, 20, rl.RED) 
			} else {
				rl.DrawText("CURSOR VISIBLE", 20, 60, 20, rl.LIME)
			}
		rl.EndDrawing()
	}
}
