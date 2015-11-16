--[[ A solution contains projects, and defines the available configurations

http://industriousone.com/premake/user-guide

example: http://opende.svn.sourceforge.net/viewvc/opende/trunk/build/premake4.lua?revision=1708&view=markup

http://bitbucket.org/anders/lightweight/src/tip/premake4.lua

]]
solution "rc-unitd"
	configurations { "Debug", "Release" }
	objdir "./obj"

-- rc-unit executable
project "rc-unitd"
	kind "ConsoleApp"
	language "C++"
	targetdir "../src/rc-unitd"
	files { "../src/rc-unitd/**.h", "../src/rc-unitd/**.cpp" }
	
	includedirs { "../src",
				  "../lib/lopack/src",
				  "../lib/tinyobject/src",
				  "../lib/cpphelpers/tclap" }
	libdirs { "../lib/lopack/src/lopack",
			  "../lib/tinyobject/src/tinyobject" }
	links { "lopack", "tinyobject" }

	configuration "linux"
		buildoptions { "`pkg-config --cflags sdl2`", "`pkg-config --cflags liblo`", "`pkg-config --cflags tinyxml2`", "-DHAVE_CONFIG_H" }
		linkoptions { "`pkg-config --libs sdl2`", "`pkg-config --libs liblo`", "`pkg-config --libs tinyxml2`" }

	configuration 'macosx'
		-- Homebrew & Macports
		includedirs { "/usr/local/include", "/usr/local/include/SDL2", "/opt/local/include", "/opt/local/include/SDL2" }
		libdirs { "/usr/local/lib", "/opt/local/lib" }
		links { "lo", "tinyxml2", "pthread", "SDL2" }
		buildoptions { "-DHAVE_CONFIG_H"}
		linkoptions { "-Wl,-framework,Cocoa", "-Wl,-framework,OpenGL",
					  "-Wl,-framework,ApplicationServices",
					  "-Wl,-framework,Carbon", "-Wl,-framework,AudioToolbox",
					  "-Wl,-framework,AudioUnit", "-Wl,-framework,IOKit" }

	configuration "Debug"
		defines { "DEBUG" }
		flags { "Symbols" }

	configuration "Release"
		defines { "NDEBUG" }
		flags { "Optimize" }
		
-- lsjs executable
project "lsjs"
	kind "ConsoleApp"
	language "C++"
	targetdir "../src/lsjs"
	files { "../src/lsjs/**.h", "../src/lsjs/**.cpp" }

	includedirs { "../src",
				  "../lib/cpphelpers" }

	configuration "linux"
		buildoptions { "`pkg-config --cflags sdl2`", "-DHAVE_CONFIG_H" }
		linkoptions { "`pkg-config --libs sdl2`" }

	configuration 'macosx'
		-- Homebrew & Macports
		includedirs { "/usr/local/include", "/usr/local/include/SDL2", "/opt/local/include", "/usr/local/include/SDL2" }
		libdirs { "/usr/local/lib", "/opt/local/lib" }
		links { "SDL2" }
		buildoptions { "-DHAVE_CONFIG_H" }
		linkoptions { "-Wl,-framework,Cocoa", "-Wl,-framework,OpenGL",
					  "-Wl,-framework,ApplicationServices",
					  "-Wl,-framework,Carbon", "-Wl,-framework,AudioToolbox",
					  "-Wl,-framework,AudioUnit", "-Wl,-framework,IOKit" }

	configuration "Debug"
		defines { "DEBUG" }
		flags { "Symbols" }

	configuration "Release"
		defines { "NDEBUG" }
		flags { "Optimize" }
		
-- rc-unit-notifier executable
project "rc-unit-notifier"
	kind "ConsoleApp"
	language "C++"
	targetdir "../src/rc-unit-notifier"
	files { "../src/rc-unit-notifier/**.h", "../src/rc-unit-notifier/**.cpp" }
	
	includedirs { "../src",
				  "../lib/cpphelpers",
				  "../lib/lopack/src" }
	libdirs { "../lib/lopack/src/lopack" }
	links { "lopack" }

	configuration "linux"
		buildoptions { "`pkg-config --cflags sdl2`", "-DHAVE_CONFIG_H" }
		linkoptions { "`pkg-config --libs sdl2`" }

	configuration 'macosx'
		-- Homebrew
		includedirs { "/usr/local/include", "/usr/local/include/SDL2", "/opt/local/include", "/opt/local/include/SDL2" }
		libdirs { "/usr/local/lib", "/opt/local/lib" }
		links { "lo", "pthread", "SDL2" }
		buildoptions { "-DHAVE_CONFIG_H" }
		linkoptions { "-Wl,-framework,Cocoa", "-Wl,-framework,OpenGL",
					  "-Wl,-framework,ApplicationServices",
					  "-Wl,-framework,Carbon", "-Wl,-framework,AudioToolbox",
					  "-Wl,-framework,AudioUnit", "-Wl,-framework,IOKit" }

	configuration "Debug"
		defines { "DEBUG" }
		flags { "Symbols" }

	configuration "Release"
		defines { "NDEBUG" }
		flags { "Optimize" }
