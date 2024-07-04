{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  description = "Development shell flake";
  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system: {
    devShell = let 
      pkgs = nixpkgs.legacyPackages.${system};
    in 
      pkgs.mkShell {
        packages = with pkgs; [
          nodejs_20
          nodePackages.npm
          nodePackages.svelte-language-server
          nodePackages.typescript-language-server
          nodePackages.typescript
        ];
      };
  });
}
