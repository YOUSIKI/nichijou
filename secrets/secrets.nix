let
  hakase = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJJIxfWYaoGqw02b2U04OtaaPgIVFH7m2zyFwfRWAQl/";
  mai = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEkivfZvuZ4p5JDQoTXUnzbdov8SwBQY2G1cpLN+iSHR";
  hosts = [hakase mai];

  yousiki_hakase = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFn+pRkC6G81PSmJOw8j8Y9i8Gt2OZiQ73ZpQV4UIZbg";
  yousiki_mai = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEbLXeZhWvhlPYddoukkFZY1EQjOWt8SEdH2oq4z3fu7";
  yousiki_sakamoto = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP4es4WjPLH/SI/s5PnRNHGjE7E6f3O1nZolKT1fZ6Pb";
  users = [yousiki_hakase yousiki_mai yousiki_sakamoto];

  all = hosts ++ users;
in {
  "clash-config.yaml.age".publicKeys = all;
  "satoshi-credentials.age".publicKeys = all;
  "lab-mck-credentials.age".publicKeys = all;
  "lab-yyp-credentials.age".publicKeys = all;
}
