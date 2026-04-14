{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/25.11";
  };
  outputs = 
  { nixpkgs, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in
  {
    devShells.${system}.default = pkgs.mkShellNoCC{
      packages = [
        pkgs.yosys
        pkgs.yosys-ghdl
        pkgs.nextpnr
        pkgs.icestorm
        pkgs.openfpgaloader
      ];
    };
  };
}
