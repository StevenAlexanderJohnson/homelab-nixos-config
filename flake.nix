{
	description = "NixOS Home Server";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";
	};

	outputs = { self, nixpkgs, ... }@inputs:
  let
    nodes = [
      "node1"
      "node2"
      "node3"
    ];
		importHardware = node: ./. + "/hardware/${node}.nix";
	in {
	    nixosConfigurations = builtins.listToAttrs (map (name: {
      inherit name;
			value = nixpkgs.lib.nixosSystem {
				specialArgs = {
					meta = { hostname = name; };
				};
				system = "x86_64-linux";
				modules = [
					# Modules
					(importHardware name)
					./configuration.nix
				];
			};
		}) nodes);
	};
}
