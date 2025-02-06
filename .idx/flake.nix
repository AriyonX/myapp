{
  description = "Flutter development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs = { self, nixpkgs }: {
    devShells.default = nixpkgs.legacyPackages.x86_64-linux.mkShell {
      buildInputs = [
        nixpkgs.jdk17
        nixpkgs.unzip
        nixpkgs.flutter
      ];
    };
  };
}
