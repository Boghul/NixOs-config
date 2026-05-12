{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
	pname = "arasaka-plymouth";
	version = "1.0";
	src = fetchurl {
		url = "https://gitlab.com/pSchwietzer/arasaka-plymouth/-/archive/main/arasaka-plymouth-main.tar.gz";
		sha256 = "sha256-swYNGvU76nfFxdQvU4YBu7UsZZO+qvGH3VpUWW3lS8k=";
	};

	dontConfigure = true;
	dontBuild = true;

	installPhase = ''
		runHook preInstall

		mkdir -p $out/share/plymouth/themes/arasaka/
		tar -xvf $src --strip-components=1 -C $out/share/plymouth/themes/arasaka/
		substituteInPlace $out/share/plymouth/themes/arasaka/*.plymouth --replace '@ROOT@' "$out/share/plymouth/themes/arasaka/"

		runHook postInstall
	'';
}
