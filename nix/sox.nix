{ config, lib, stdenv, fetchurl, CoreAudio, cmake
, enableAlsa ? true, alsaLib ? null
, enableLibao ? true, libao ? null
, enableLame ? true, lame ? null
, enableLibmad ? true, libmad ? null
, enableLibogg ? true, libogg ? null, libvorbis ? null
, enableFLAC ? true, flac ? null
, enablePNG ? true, libpng ? null
, enableLibsndfile ? true, libsndfile ? null
# amrnb and amrwb are unfree, disabled by default
, enableAMR ? false, amrnb ? null, amrwb ? null
, enableLibpulseaudio ? true, libpulseaudio ? null
}:

with stdenv.lib;

stdenv.mkDerivation rec {
  name = "sox-14.4.2";

  src = ./.;

  buildInputs =
    [ cmake ] ++
    optional (enableAlsa && stdenv.isLinux) alsaLib ++
    optional enableLibao libao ++
    optional enableLame lame ++
    optional enableLibmad libmad ++
    optionals enableLibogg [ libogg libvorbis ] ++
    optional enableFLAC flac ++
    optional enablePNG libpng ++
    optional enableLibsndfile libsndfile ++
    optionals enableAMR [ amrnb amrwb ] ++
    optional enableLibpulseaudio libpulseaudio ++
    optional (stdenv.isDarwin) CoreAudio;

  meta = {
    description = "Sample Rate Converter for audio";
    homepage = http://sox.sourceforge.net/;
    maintainers = [ lib.maintainers.marcweber ];
    license = if enableAMR then lib.licenses.unfree else lib.licenses.gpl2Plus;
    platforms = lib.platforms.linux ++ lib.platforms.darwin;
  };
}
