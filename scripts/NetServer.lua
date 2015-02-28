--
-- Example/test of network server function
-- To connect to this, use libGlov's "NetTest ChatClient localhost 3007"
--

dofile("common.inc");


function doit()
	local scale = 1.0;
	local z = 0.0; -- Only matters if there is overlapping elements on screen

	lsServerListen();
	
	-- Display the value read from the edit box
	while not lsButtonText(lsScreenX - 110, lsScreenY - 30, z, 100, 0xFFFFFFff, "Done") do
		-- Put these everywhere to make sure we don't lock up with no easy way to escape!
		checkBreak();

		local y = 10;
		local event = lsServerGetNextEvent(1000) -- Wait up to 1000ms for the first event, 0 thereafter
		while event do
			lsPrint(10, y, z, scale, scale, 0xFFFFFFff, 'type=' .. event.type);
			y = y + 24;
			lsPrint(10, y, z, scale, scale, 0xFFFFFFff, 'cmd=' .. (event.cmd or 'nil'));
			y = y + 24;
			lsPrint(10, y, z, scale, scale, 0xFFFFFFff, 'data=' .. (event.data or 'nil'));
			y = y + 24;
			lsPrint(10, y, z, scale, scale, 0xFFFFFFff, 'client=' .. event.client);
			y = y + 24;
			lsPrint(10, y, z, scale, scale, 0xFFFFFFff, 'ip=' .. event.ip);
			y = y + 24;
			if event.type == "data" then
				-- Echo to all!
				lsServerSend(-1, event.cmd, event.data);
			end
			event = lsServerGetNextEvent(0);
		end

		lsDoFrame();
		lsSleep(10); -- Sleep just so we don't eat up all the CPU for no reason
	end
	
end
