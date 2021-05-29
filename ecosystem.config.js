module.exports = {
  apps: [
    {
      "exec_interpreter": "bash",
      name: 'code-wae-app',
      script: 'flutter',
      args: 'run -d web-server --web-port 3000 --web-hostname=0.0.0.0 --pid-file /usr/local/bin/flutter.pid'
    }
  ]
};