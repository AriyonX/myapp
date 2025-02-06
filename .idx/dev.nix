{ pkgs ? import <nixpkgs> {} }:

{
  channel = "stable-24.05";
  
  packages = [
    pkgs.jdk17
    pkgs.unzip
    pkgs.flutter  # Ensure Flutter is included
  ];

  idx = {
    extensions = [ ];  # Keep empty if no extensions are needed

    previews = {
      web = {
        command = [
          "flutter"
          "run"
          "--machine"
          "-d"
          "web-server"
          "--web-hostname=0.0.0.0"
          "--web-port=$PORT"
        ];
        manager = "flutter";
      };

      android = {
        command = [
          "flutter"
          "run"
          "--machine"
          "-d"
          "android"
          "-d"
          "localhost:5555"
        ];
        manager = "flutter";
      };
    };
  };
}
