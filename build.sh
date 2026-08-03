project_name="run-bomby-run"
version="0.3.0"

export_flag=false
run_flag=false

while getopts "ehr" option; do
  case $option in
    e)
      export_flag=true
    ;;
    h)
      echo -e "\033[1musage:\033[0m\n    ./build.sh [options]\n"
      echo -e "\033[1mOptions\033[0m"
      echo "    -e     Export to Itch.io"
      echo "    -h     Display this help message."
      echo -e "    -r     Runs\n"
      exit 0
    ;;
    r)
      run_flag=true
    ;;
  esac
done

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

if $export_flag; then
  butler push ./out/web/   gtea/$project_name:web   --userversion $version
  butler push ./out/linux/ gtea/$project_name:linux --userversion $version
  butler push ./out/win32/ gtea/$project_name:win32 --userversion $version
fi

if $run_flag; then
  ./out/linux/$project_name.x86_64
fi
