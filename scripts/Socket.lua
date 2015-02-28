local http = require("socket.http");

function doit()
	local url = "http://www.dashingstrike.com/Automato/changelog.txt";
	local b, c, h = http.request(url);
	while true do
		if lsButtonText(0, 0, 2, lsScreenX, 0xFFFFFFFF, "Exit") then
		  break;
		end
		lsScrollAreaBegin("result", 0, 24, 0, lsScreenX, lsScreenY);
		local height = lsPrintWrapped(0, 0, 1, lsScreenX, 0.65, 0.65, 0xDDDDDDFF, 'GET ' .. url .. '\nStatus Code: ' .. c .. '\nBody:\n' .. b);
		lsScrollAreaEnd(height);
		lsDoFrame();
		lsSleep(15);
	end
end
