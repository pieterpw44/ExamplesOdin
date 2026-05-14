package main

import rl "vendor:raylib"

main :: proc() {
	// Constants for window size.Direct port of the raylib examples basic window
	WINDOWWIDTH : i32 : 800
	WINDOWHEIGHT : i32 : 450

	// Create the game window
	rl.InitWindow(WINDOWWIDTH, WINDOWHEIGHT, "raylib [core] example - basic window")

	// Set the game framerate cap at 60fps
	rl.SetTargetFPS(60)

	// Main game loop
	for !rl.WindowShouldClose() {  // There is no 'while' loop in Odin
		// Update
		// ---------------------------------------------------------------------------
		// TODO: Update your variables here
		// --------------------------------------------------------------------------

		// Draw
		// ----------------------------------------------------------------------------
		rl.BeginDrawing()
			rl.ClearBackground(rl.RAYWHITE)
			rl.DrawText("Congrats! You created your first window!", 190, 200, 20, rl.LIGHTGRAY)
		rl.EndDrawing()
	}

	rl.CloseWindow()
}
