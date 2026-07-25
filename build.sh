project_name="run-bomby-run"
version="0.2.0"
rm -r ./out
mkdir ./out
mkdir ./out/web
mkdir ./out/linux
mkdir ./out/win32

godot --export-release "Web" out/web/index.html
godot --export-release "Linux" out/linux/$project_name.x86_64
godot --export-release "Windows Desktop" out/win32/$project_name.exe

cp ./LICENSE ./docs/liscences.txt ./out/linux/
cp ./LICENSE ./docs/liscences.txt ./out/web/
cp ./LICENSE ./docs/liscences.txt ./out/win32/

butler push ./out/web/   gtea/$project_name:web   --userversion $version
butler push ./out/linux/ gtea/$project_name:linux --userversion $version
butler push ./out/win32/ gtea/$project_name:win32 --userversion $version
