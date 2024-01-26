{ pkgs ? import <nixpkgs> {} }:

let
  pythonEnv = pkgs.python310.withPackages (ps: with ps; [
    joblib
    ipython
    numpy
    pyserial
    pyqt5
    pyqtdatavisualization
    pyqtgraph
    matplotlib
    pandas
    (scikit-learn.overridePythonAttrs (oldAttrs: rec {
      version = "1.2.2";
      pname = "scikit_learn";
      format = "wheel";

      src = pkgs.fetchPypi {
        inherit pname version format;
        dist = "cp310";
        abi = "cp310";
        python = "cp310";
        platform = "manylinux_2_17_x86_64.manylinux2014_x86_64";
        sha256 = "LiZCuqCtHo+BiJF0I91zmUvyVCn4iT3b4RW+PKMYNYQ=";
      };

      doCheck = false;
    }))
  ]);
in

pkgs.mkShell {
  buildInputs = [
    pythonEnv
    pkgs.qt5.full
  ];
}

