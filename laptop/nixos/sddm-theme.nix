{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
	pname = "glyph-sddm";
	version = "1.0";
	src = fetchurl {
		url = "https://github.com/Boghul/glyphcyber-sddm";
		sha256 = "sha256-swYNGvU76nfFxdQvU4YBu7UsZZO+qvGH3VpUWW3lS8k=";
	};

	dontConfigure = true;
	dontBuild = true;

	installPhase = ''
		runHook preInstall

		mkdir -p $out/share/sddm/themes/glyph-sddm/
		tar -xvf $src --strip-components=1 -C $out/share/sddm/themes/glyph-sddm/
		substituteInPlace $out/share/sddm/themes/glyph/*.sddm --replace '@ROOT@' "$out/share/sddm/themes/glyph-sddm/"

		runHook postInstall
	'';
}
