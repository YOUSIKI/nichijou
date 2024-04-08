let
  hakase = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJJIxfWYaoGqw02b2U04OtaaPgIVFH7m2zyFwfRWAQl/";
  hosts = [hakase];

  yousiki_hakase = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFn+pRkC6G81PSmJOw8j8Y9i8Gt2OZiQ73ZpQV4UIZbg";
  users = [yousiki_hakase];
in {
  "nas-credentials.age".publicKeys = hosts ++ users;
  "clash-config.age".publicKeys = hosts ++ users;
}
