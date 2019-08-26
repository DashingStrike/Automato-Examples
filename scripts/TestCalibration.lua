dofile("common.inc");

function doit()
	askForWindow("");
	while 1 do
		local mx, my;
		while 1 do 
			mx, my = srMousePos();
		  xy = srGetWindowSize();
			srReadScreen();
			srMakeImage("calibrate", mx - 8, my - 8, 16, 16);
			local image_scale = 4;
			local image_x = 5;
			local image_y = 280;
			srShowImageDebug("calibrate", image_x, image_y, 10, image_scale);
			lsDrawRect(image_x - 2, image_y - 2, image_x + image_scale * 16 + 2, image_y + image_scale * 16 + 2, 9, 0xFF0000ff);
			lsDrawRect(image_x + image_scale * 8, image_y + image_scale * 8, image_x + image_scale * 9, image_y + image_scale * 9, 11, 0xFFFFFF80);
			statusScreen("Move mouse over the upper-left pixel of the game window, pos should equal 0,0" ..
				"\n   Mouse pos = " .. mx .. "," .. my ..
				"\nMove mouse over the lower-right pixel of the game window, pos should equal the Window size minus 1" ..
				"\n  Window = " .. xy[0] .. "x" .. xy[1] ..
			  "\nPress Shift to have Automato position the mouse where it thinks it currently is (should not move)");
			if (lsShiftHeld()) then
				break;
			end
			lsSleep(10);
		end

	  statusScreen("Moving...");
  	srSetMousePos(mx, my);
		lsSleep(150);
	end
end
