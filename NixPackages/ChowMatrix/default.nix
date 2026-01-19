{
  alsa-lib,
  at-spi2-core,
  cmake,
  curl,
  dbus,
  libepoxy,
  fetchFromGitHub,
  libglut,
  freetype,
  gcc-unwrapped,
  gtk3,
  lib,
  libGL,
  libXcursor,
  libXdmcp,
  libXext,
  libXinerama,
  libXrandr,
  libXtst,
  libdatrie,
  libjack2,
  libpsl,
  libselinux,
  libsepol,
  libsysprof-capture,
  libthai,
  libxkbcommon,
  pcre,
  pkg-config,
  python3,
  sqlite,
  stdenv,
  lv2,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "chow-matrix";
  version = "1.3.0";

  src = fetchFromGitHub {
    owner = "Chowdhury-DSP";
    repo = "ChowMatrix";
    tag = "v${finalAttrs.version}";
    fetchSubmodules = true;
    sha256 = "sha256-B4RrNZThNb6xcDvNQgyB3WwCCEKz7+Vf43kQJQHbepI=";
  };

  nativeBuildInputs = [
    pkg-config
    cmake
  ];

  buildInputs = [
    alsa-lib
    at-spi2-core
    curl
    dbus
    libepoxy
    libglut
    freetype
    gtk3
    libGL
    libXcursor
    libXdmcp
    libXext
    libXinerama
    libXrandr
    libXtst
    libdatrie
    libjack2
    libpsl
    libselinux
    libsepol
    libsysprof-capture
    libthai
    libxkbcommon
    pcre
    python3
    sqlite
    gcc-unwrapped
    lv2
  ];

  cmakeFlags = [
    "-DCMAKE_AR=${gcc-unwrapped}/bin/gcc-ar"
    "-DCMAKE_RANLIB=${gcc-unwrapped}/bin/gcc-ranlib"
    "-DCMAKE_NM=${gcc-unwrapped}/bin/gcc-nm"
  ];

  installPhase = ''
    mkdir -p $out/lib/lv2 $out/lib/vst3 $out/bin $out/share/doc/ChowMatrix/
    cd ChowMatrix_artefacts/Release
    cp libChowMatrix_SharedCode.a  $out/lib
    cp -r VST3/ChowMatrix.vst3 $out/lib/vst3
    cp -r LV2/ChowMatrix.lv2 $out/lib/lv2
    cp Standalone/ChowMatrix  $out/bin
  '';

  meta = {
    homepage = "https://github.com/Chowdhury-DSP/ChowMatrix";
    description = "Matrix delay effect";
    license = with lib.licenses; [ bsd3 ];
    mainProgram = "ChowMatrix";
    platforms = lib.platforms.linux;
  };
})
