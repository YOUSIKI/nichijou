{...}: {
  home.file.".ssh/config".text = ''
    Include ~/.ssh/local
    Include ~/.orbstack/ssh/config

    Host mai
      HostName mai.siki.moe
      User yousiki
      Port 22

    Host satoshi
      HostName satoshi.siki.moe
      User yousiki
      Port 23

    Host hakase
      HostName hakase.siki.moe
      User yousiki
      Port 22

    Host satoshi-cf
      HostName satoshi-ssh.siki.moe
      User yousiki
      Port 22
      ProxyCommand cloudflared access ssh --hostname %h

    Host hakase-cf
      HostName hakase-ssh.siki.moe
      User yousiki
      Port 22
      ProxyCommand cloudflared access ssh --hostname %h
  '';
}
