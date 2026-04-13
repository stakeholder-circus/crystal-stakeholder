{
  description = "stakeholder-circus crystal-stakeholder local rewrite tranche";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-darwin" "x86_64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
      devShells = forAllSystems (system:
        let pkgs = import nixpkgs { inherit system; };
        in {
          default = pkgs.mkShell {
            packages = with pkgs; [ crystal git jq python312 ];
          };
        });
      apps = forAllSystems (system:
        let pkgs = import nixpkgs { inherit system; };
            mk = name: text: {
              type = "app";
              program = "${pkgs.writeShellScript name text}";
            };
        in {
          build = mk "build" ''crystal build src/crystal_stakeholder.cr -o bin/crystal-stakeholder'';
          test = mk "test" ''crystal spec'';
          check = mk "check" ''python3 scripts/validate_scaffold.py && crystal tool format --check src spec && crystal spec'';
          format = mk "format" ''crystal tool format src spec'';
        });
    };
}
