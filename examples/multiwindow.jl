import GLFW

GLFW.Init()

windows = []
for i in 1:3
	name = "Window $i"
	window = GLFW.CreateWindow(640, 480, name)
	GLFW.SetMouseButtonCallback(window, (_, button, action, mods) -> begin
		if action == GLFW.PRESS
			println(name)
		end
	end)
	push!(windows, window)
end

glClear() = ccall(@eval(GLFW.GetProcAddress("glClear")), Void, (Cuint,), 0x00004000)

gc() # Force garbage collection so that improper reference management is more apparent via crashes

while !any(GLFW.WindowShouldClose, windows)
	for window in windows
		GLFW.MakeContextCurrent(window)
		glClear()
		GLFW.SwapBuffers(window)
	end
	GLFW.WaitEvents()
end

for window in windows
	GLFW.DestroyWindow(window)
end

GLFW.Terminate()
