[Unit]
Description=etcd data dir
Before=etcd-member.service

[Service]
Type=oneshot
RemainAfterExit=true
ExecStartPre=/usr/bin/mkdir -p ${etcd_data_dir}
ExecStart=/usr/bin/chown etcd:etcd ${etcd_data_dir}

[Install]
WantedBy=default.target
