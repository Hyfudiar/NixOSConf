{ stdenv, lib, fetchurl, autoPatchelfHook, libgcc }:

stdenv.mkDerivation rec {
    pname = "soundthread";
    version = "0.4";

    src = fetchurl {
        url = "https://github.com/j-p-higgins/SoundThread/releases/download/v0.4.0-beta/SoundThread_v0-4-0-beta_linux_x86_64.tar.gz";
        sha256 = "sha256-aJlpMVXElBMWuvVGsPe0BufeAWPjKoFcxOhlrMkbHwk=";
    };

    nativeBuildInputs = [
        autoPatchelfHook
        libgcc
        stdenv.cc.cc.lib
    ];

    dontBuild = true;
    # buildInputs = [tar];

    desktopItems = [
      (makeDesktopItem {
        name = "soundthread";
        exec = "soundthread";
        icon = "/home/hyfudiar/.local/share/icons/hicolor/256x256/apps/soundthread.png";
        desktopName = "SoundThread";
        genericName = "SoundThread";
        comment = meta.description;
        categories = [
          "Audio"
        ];
      })
    ];

    unpackPhase = ''
        tar -xf $src
    '';

    installPhase = ''
        cd SoundThread_v0-4-0-beta_linux_x86_64/
        mv SoundThread.x86_64 $pname
        tar -xf cdprogs_linux.tar.gz
        mkdir -p $out/bin
        cp -r * $out/bin/
        chmod +x $out/bin/${pname}
    '';

    meta = with lib; {
        description = "Node based GUI for The Composers Desktop Project";
        homepage = "https://github.com/j-p-higgins/SoundThread";
        license = licenses.mit;
        platforms = platforms.linux;
    };

}
