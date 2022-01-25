{
  description = "baycomp";

  # 2022-01-24
  inputs.nixpkgs.url =
    "github:NixOS/nixpkgs/8ca77a63599ed951d6a2d244c1d62092776a3fe1";
  inputs.src = {
    url = "github:janezd/baycomp";
    flake = false;
  };

  outputs = { self, nixpkgs, src }:
    with import nixpkgs { system = "x86_64-linux"; };
    let python = python39;
    in rec {

      defaultPackage.x86_64-linux = python.pkgs.buildPythonPackage rec {
        pname = "baycomp";
        version = "unstable";

        inherit src;

        doCheck = false;

        propagatedBuildInputs = with python.pkgs; [ matplotlib numpy scipy ];

        meta = with lib; {
          homepage = "https://github.com/janezd/baycomp";
          description = "A library for Bayesian comparison of classifiers";
          license = licenses.mit;
        };
      };
    };
}
