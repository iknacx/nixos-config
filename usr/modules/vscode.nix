{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    extensions = (with pkgs.vscode-extensions; [
      bbenoist.Nix
      matklad.rust-analyzer
      haskell.haskell
      justusadam.language-haskell
      ms-vscode.cpptools
      ms-python.python
    ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "language-x86-64-assembly";
        publisher = "13xforever";
        version = "3.0.0";
        sha256 = "0lxg58hgdl4d96yjgrcy2dbacxsc3wz4navz23xaxcx1bgl1i2y0";
      }
    ];
  };
}