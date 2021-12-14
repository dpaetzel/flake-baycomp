{
  description = "baycomp";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
  inputs.src = {
    url = "github:janezd/baycomp";
    flake = false;
  };

  outputs = { self, nixpkgs, src }: rec {

    defaultPackage.x86_64-linux = packages.x86_64-linux.baycomp;

    packages.x86_64-linux.baycomp =
      with import nixpkgs { system = "x86_64-linux"; };
      python3.pkgs.buildPythonPackage rec {
        pname = "baycomp";
        version = "unstable";

        inherit src;

        doCheck = false;

        propagatedBuildInputs = with python3.pkgs; [ matplotlib numpy scipy ];

        meta = with lib; {
          homepage = "https://github.com/janezd/baycomp";
          description = "A library for Bayesian comparison of classifiers";
          license = licenses.mit;
        };
      };
  };
}
