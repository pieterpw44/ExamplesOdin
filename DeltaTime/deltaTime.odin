package main

/*************************************************************************************************************************
*
* raylib [core] example - delta time
*
* Example complexity rating: 1/4
*
* Example originally created by raylib 5.5, last time updated with raylib 6.0
*
* Example contributed by Robin (@RobinsAviary) and reviewed by Ramon Santamaria (@raysan5)
*
* Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
* BSD-like license that allows static linking with closed source sorftware
*
* Copyright (c) 2025 Robin (@RobinsAviary)
*
* Odin conversion by blackmamba72, 2026
*
* All original copyright and license restrictions applies and belongs to the orignal creator
*
************************************************************************************************************************/

import rl "vendor:raylib"

main :: proc() {
	// Constants for the window size
	WINDOWWIDTH : i32 : 800
	WINDOWHEIGHT: i32 : 450

	// Create the window
	rl.InitWindow(WINDOWWIDTH, WINDOWHEIGHT, "raylib [core] example - delta time")
	defer rl.CloseWindow() // use defer to close the window at the end of the scope

	// variable to change the fps
	currentFps: i32 =  60;

	// Store the position for both the circles
	deltaCircle: rl.Vector2 = {0, f32(WINDOWHEIGHT / 3.0)}
	frameCircle: rl.Vector2 = {0, f32(WINDOWHEIGHT) * (2.0 / 3.0)}

	// The speed applied to both the circles
	SPEED : f32 :  10.0
	CIRCLERADIUS : f32 : 32.0

	// Set the FPS cap
	rl.SetTargetFPS(currentFps)

	for !rl.WindowShouldClose() {
		mouseWheel := rl.GetMouseWheelMove()
		if mouseWheel != 0 {
			currentFps += i32(mouseWheel)
			if currentFps < 0 do currentFps = 0
			rl.SetTargetFPS(currentFps)
		}

		// GetFrameTime() returns the time it took to draw the last frame, in seconds (usually called delta time)
		// Uses delta time to make the circle look like its moving at a "consistent" speed regardless of the frame rate

		// Multiply by 6.0 (arbitrary number) in order to make the speed
		// visually closer to the other circle (at 60fps),
		deltaCircle.x += rl.GetFrameTime() * 6.0 * SPEED

		// This circle can move faster or slower visually depending on the FPS
		frameCircle.x += 0.1 * SPEED

		// If either circle is off the screen, reset it back to the start
		if deltaCircle.x > f32(WINDOWWIDTH) do deltaCircle.x = 0
		if frameCircle.x > f32(WINDOWWIDTH) do frameCircle.x = 0

		// Reset both circles positions
		if rl.IsKeyPressed(.R) {
			deltaCircle.x = 0
			frameCircle.x = 0
		}

		rl.BeginDrawing()
			rl.ClearBackground(rl.RAYWHITE)

			// Draw both circles to the screen
			rl.DrawCircleV(deltaCircle, CIRCLERADIUS, rl.RED)
			rl.DrawCircleV(frameCircle, CIRCLERADIUS, rl.BLUE)

			// Draw the help text
			// Determine what help text to display depending on the current FPS target
			fpsText: cstring 
			if currentFps <= 0 {
				fpsText = rl.TextFormat("FPS: unlimited (%i)", rl.GetFPS())
			} else {
				fpsText = rl.TextFormat("FPS: %i (target: %i)", rl.GetFPS(), currentFps)
			}

			rl.DrawText(fpsText, 10, 10, 20, rl.DARKGRAY)
			rl.DrawText(rl.TextFormat("Frame time: %02.02f ms", rl.GetFrameTime()), 10, 30, 20, rl.DARKGRAY)
			rl.DrawText("Use the scroll wheel to change the fps limit, r to reset", 10, 50, 20, rl.DARKGRAY)

			rl.DrawText("FUNC: x += GetFrameTime() * SPEED", 10, 90, 20, rl.RED)
			rl.DrawText("FUNC: x += SPEED", 10, 240, 20, rl.BLUE)
		rl.EndDrawing()
	}
}
