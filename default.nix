{ stdenv, pkgs, fetchFromGitHub, python3Packages }:
let
  python = python3Packages.python;
in
python3Packages.buildPythonPackage rec {
  pname = "matrix-registration";
  version = "0.7.0";

  src = fetchFromGitHub {
    owner = "ZerataX";
    repo = "matrix-registration";
    rev = "b6fdaab6071a72c8ab32d2bc8816a94c2e32ddaa";
    sha256 = "0xdrg50mjml58ym04mhq82v2fbszslpziqpxy0k1c34spr0aily9";
  };

  doCheck = false;
  propagatedBuildInputs = [
    pkgs.libsndfile
    python3Packages.appdirs
    python3Packages.flask
    python3Packages.flask-cors
    python3Packages.flask-httpauth
    python3Packages.flask-limiter
    python3Packages.flask_sqlalchemy
    python3Packages.python-dateutil
    python3Packages.pytest
    python3Packages.pyyaml
    python3Packages.requests
    python3Packages.waitress
    python3Packages.wtforms
    python3Packages.setuptools
  ];

  meta = with stdenv.lib; {
    homepage = https://github.com/ZerataX/matrix-registration/;
    description = "a token based matrix registration api";
  };

}
