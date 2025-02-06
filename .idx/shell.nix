{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.jdk17
    pkgs.unzip
    pkgs.flutter
  ];

  shellHook = ''
    echo "Flutter development environment ready!"
    flutter --version
  '';
}
nix-shell