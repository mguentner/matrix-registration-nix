{ stdenv, pkgs, fetchFromGitHub }:

let
  python = import ./requirements.nix { inherit pkgs; };
in

python.mkDerivation rec {
  pname = "matrix-registration";
  version = "0.5.5";

  src = fetchFromGitHub {
    owner = "ZerataX";
    repo = "matrix-registration";
    rev = "780e713b3355d42903d173be98dae245319f682a";
    sha256 = "16grd3gf00nnal65yqhhaycvymz0rybvsyxwz8had6g4lljcvb3q";
  };

  doCheck = false;
  propagatedBuildInputs = builtins.attrValues python.packages;

  meta = with stdenv.lib; {
    homepage = https://github.com/ZerataX/matrix-registration/;
    description = "a token based matrix registration api";
  };

}
