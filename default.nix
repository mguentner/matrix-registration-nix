{ stdenv, pkgs, fetchFromGitHub, python3Packages }:
with python3Packages;
buildPythonPackage rec {
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
    appdirs
    flask
    flask-cors
    flask-httpauth
    flask-limiter
    flask_sqlalchemy
    python-dateutil
    pytest
    pyyaml
    requests
    waitress
    wtforms
    setuptools
  ];

  meta = with stdenv.lib; {
    homepage = https://github.com/ZerataX/matrix-registration/;
    description = "a token based matrix registration api";
  };

}
