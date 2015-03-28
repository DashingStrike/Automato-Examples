--
-- Example/test of UI functions
--   See ui_utils.inc for details/better examples
--

dofile("screen_reader_common.inc");
dofile("ui_utils.inc");

dropdown_values = {"Apple", "Banana", "Crack"};
dropdown_cur_value = 1;

function doit()
	local scale = 1.0;
	local z = 0.0; -- Only matters if there is overlapping elements on screen

	-- promptNumber() in ui_utils.inc is a good example of an EditBox and buttons and text
	local value = promptNumber("Enter a number!", 777);

	local from_clipboard = "Clipboard text pasted here";
	
	-- Display the value read from the edit box
	while not lsButtonText(lsScreenX - 110, lsScreenY - 30, z, 100, 0xFFFFFFff, "Done") do
		-- Put these everywhere to make sure we don't lock up with no easy way to escape!
		checkBreak();

		lsPrintWrapped(10, 10, z, lsScreenX - 20, scale, scale, 0x7F00FFff, "You entered '" .. value .. "'");
		
		dropdown_cur_value = lsDropdown("UITestDropDown", 10, 50, z, 100, dropdown_cur_value, dropdown_values);

		if lsButtonText(10, 100, z, 100, 0xFFFFFFff, "Paste") then
			from_clipboard = lsClipboardGet();
		end
		if from_clipboard then
			local w = lsScreenX - 120;
			lsScrollAreaBegin("clipboard_display", 115, 100, z, w, lsScreenY - 100 - 40);
			local sub_scale = 0.7;
			w = w - 24; -- make room for the scroll bar
			local h = lsPrintWrapped(0, 0, z, w, sub_scale, sub_scale, 0x808080ff, from_clipboard);
			lsScrollAreaEnd(h);
		end

		if lsButtonText(10, 130, z, 100, 0xFFFFFFff, "Copy \"hi\"") then
			lsClipboardSet("hi");
		end

		if lsButtonText(10, 160, z, 100, 0xFFFFFFff, "Play sound") then
			lsPlaySound("test.wav");
		end

		lsDoFrame();
		
		lsSleep(10); -- Sleep just so we don't eat up all the CPU for no reason
	end
	
end
