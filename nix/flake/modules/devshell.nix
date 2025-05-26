{ inputs, ... }:
{
  perSystem = { config, self', pkgs, lib, ... }: {
    devShells.default = pkgs.mkShell {
      name = "nix-template-shell";
      inputsFrom = [
        config.treefmt.build.devShell
        config.pre-commit.devShell # See ./nix/modules/pre-commit.nix
      ];
      packages = with pkgs; [
        just
        nixd # Nix language server
        nil
        lolcat
        lazygit
        gitflow

        # dotfiles programs
        inputs.dotfiles.packages.${system}.quick-results
        inputs.dotfiles.packages.${system}.upjust
        inputs.dotfiles.packages.${system}.cargo-update
      ];
      shellHook = ''
        echo "welcome to the rust development environment for the nix-template package" | ${pkgs.cowsay}/bin/cowsay | ${pkgs.lolcat}/bin/lolcat 2> /dev/null;
      '';
    };
  };
}
