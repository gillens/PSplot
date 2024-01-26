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
    # packages that need a specific version are pulled in with pip
  ]);
in

pkgs.mkShell {
  buildInputs = [
    pkgs.python310
    pythonEnv
    pkgs.qt5.full
  ];

  shellHook = ''
    # Create a virtual environment
    python3 -m venv venv

    # Activate the virtual environment
    source venv/bin/activate

    # Install packages from requirements.txt
    pip install -r requirements.txt
  '';
}

