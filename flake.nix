{
	description = "NixOS Home Server";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";
	};

	outputs = { self, nixpkgs, ... }@inputs: let
	nodes = [
		"node1"
		"node2"
		"node3"
	];
	in {
	    nixosConfigurations = builtins.listToAttrs (map (name: {
			name = name;
			value = nixpkgs.lib.nixosSystem {
				specialArgs = {
				meta = { hostname = name; };
			};
			system = "x86_64-linux";
			modules = [
				# Modules
				./hardware-configuration.nix
				./configuration.nix
			];
		};
	    }) nodes);
	  };
}
