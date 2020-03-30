{
  systemd.services.matrix-registration = {
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    preStart = let
        daemonConfig = pkgs.writeText "config.yaml" (builtins.toJSON {
          server_location = "https://your.home.server.com";
          server_name = "Your Home Server";
          shared_secret = "abc";
          riot_instance = "https://riot.home.server.de";
          db = "db.sqlite3";
          port = 8092;
          rate_limit = ["100 per day" "10 per minute"];
          allow_cors = false;
          password = {
            min_length = 8;
          };
          logging = {
            disable_existing_loggersa = false;
            version = 1;
            root = {
              level = "DEBUG";
              handlers = ["console" "console1"];
            };
            formatters = {
                brief = {
                  format = "%(name)s - %(levelname)s - %(message)s";
                };
                precise = {
                  format = "%(asctime)s - %(name)s - %(levelname)s - %(message)s";
                };
            };
            handlers = {
              console = {
                class = "logging.StreamHandler";
                level = "INFO";
                formatter = "brief";
                stream = "ext://sys.stdout";
              };
              console1 = {
                class = "logging.StreamHandler";
                level = "INFO";
                formatter = "precise";
                stream = "ext://sys.stdout";
              };
            };
        };
      }); in
      ''
        [ -e /var/lib/matrix-registration/config.yaml ] && rm /var/lib/matrix-registration/config.yaml
        cp ${daemonConfig} /var/lib/matrix-registration/config.yaml
      '';
    serviceConfig = {
      User = "matrix-registration";
      Group = "matrix-registration";
      Type = "simple";
      Restart = "on-failure";
      RestartSec = 10;
      WorkingDirectory = "/var/lib/matrix-registration";
      ExecStart = "${matrix-registration}/bin/matrix_registration api";
    };
  };
}
