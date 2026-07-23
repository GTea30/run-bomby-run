project_name="gmtk2026"
version="0.1.0"
mkdir ./out
mkdir ./out/web
mkdir ./out/linux
mkdir ./out/win32

godot --export-release "Web" out/web/index.html
godot --export-release "Linux" out/linux/$project_name.x86_64
godot --export-release "Windows Desktop" out/win32/$project_name.exe

butler push ./out/web/   gtea/$project_name:web   --userversion $version
butler push ./out/linux/ gtea/$project_name:linux --userversion $version
butler push ./out/win32/ gtea/$project_name:win32 --userversion $version
