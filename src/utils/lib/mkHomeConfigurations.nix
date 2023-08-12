{
  inputs,
  cell,
  ...
}:
with builtins // inputs.nixpkgs.lib;
  userConfigurations: hostConfigurations:
    pipe
    (
      mapAttrsToList
      (user: userConfiguration: (
        mapAttrsToList
        (
          host: hostConfiguration: (
            nameValuePair
            "${user}@${host}"
            (recursiveUpdate
              userConfiguration
              hostConfiguration)
          )
        )
        hostConfigurations
      ))
      userConfigurations
    )
    [
      concatLists
      listToAttrs
    ]
