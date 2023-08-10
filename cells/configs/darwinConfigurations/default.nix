{
  inputs,
  cell,
  ...
}: {
  sakamoto = import ./sakamoto {inherit inputs cell;};
}
