[![Docker Build](https://img.shields.io/docker/build/inwinstack/nfsmb-docker.svg)](https://hub.docker.com/r/inwinstack/nfsmb-docker/)
# NFS & SAMBA Docker Tool-kit

## Build Tool-kit 工具指令
NFS&SAMBA Docker Tool-kit 目錄下的 docker-ctl 提供以下功能，自動化build/run/stop/exec操作指令。
- 建立 CcentOS7 的 NFS 與 SAMBA Docker Image
- 刪除 Docker Image
- 啟動 Container   依照Container內要開啟的Service類型映射對應的端口。
- 停止 Container   停止並刪除 Container
- 執行 Container 內的指令或程式


docker-ctl 指令參數:
```
build 
run [ nfs | smb | nfsmb ] [ <host-dir-path>:<container-dir-path>:<permission> ]
stop [ nfs | smb | nfsmb ]
exec <command and arguments>
status
```

Took-kit 所建立的 Docker Image 會包進下列3個指令，提供NFS/SAMBA的基本設定與服務啟動/關閉。
- server-run   啟動與關閉 NFS/SAMBA 服務
    - 參數: [ status | restart | stop ] (無帶入參數時為啟動服務)
    - 範例1: ./server-run status
- config-nfs   設定 /etc/exports
    - 參數: [ add | del ] <export-path> <export-options>
    - 範例1: ./config-nfs add /mnt (rw,async,norootsquash)
    - 範例2: ./config-nfs del /mnt
- config-smb   設定 /etc/samba/smb.conf (只提供匿名登入設定)
    - 參數: [ add | del ] <share-name> <share-path>
    - 範例1: ./config-smb add myshare1 /mnt
    - 範例2: ./config-smb del myshare1
