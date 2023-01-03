local dap = require("dap")

dap.adapters.netcoredbg = {
	type = "executable",
	--command = "/root/dap/netcoredbg/netcoredbg",
	command = "netcoredbg",
	args = { "--interpreter=vscode" },
}
