# Helmの書き方


```bash
helm create [helm-project]
```

```bash
helm install . --name=server
```

例えばこんな感じになる。

```bash
$ helm ls
NAME            REVISION        UPDATED                         STATUS          CHART                   NAMESPACE
server          5               Wed Jan 01 10:00:00 2018        DEPLOYED        chart-0.1.0             dev   
```

そのとき、NAMEは一意である。chartは`Chart.yaml`に記載された名前が表示されるため、Chart側から判別できる。
NAMEで判別しやすいようにchartと同じ名前をつけようとすると、serviceの名前が`server-sever`とか繰り返しになってしまうので、
NAMEは、そのhelmのrole的なことを書いておくといいかも知れない（別名とか）。

```bash
helm delete --purge [name]
```

## Debug

```bash
$ helm install . --debug --dry-run
```

## Persistent Volume

```bash
$ kubectl get pv
```

`storageClassname`に値があると、既存のものVolumeをBoundしようとする。
書いていない場合、新規にリクエストしに行く。

```yaml
kind: PersistentVolumeClaim
spec:
  # 新規で作成する場合
  storageClassName: ""
  # 既存のものがある場合
  storageClassName: "hello"
```

## securityContext

Deploymentにおいて、pods内のコンテナが、persistentVolumeに対してアクセスできるように`securityContext`を設定する必要がある場合がある。

- [Configure a Security Context for a Pod or Container](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)

これは、pods内のcontainerがPersitent Volumeにアクセスするために

```yaml
spec:
  template:
    spec:
      securityContext:
        fsGroup: 1001
```

### gcePersistentVolume

自らgceのpersistentVolumeを作成する場合

```bash
gcloud compute disks list

# Disk名 tf-node-red、容量2GB、HDDの作成
gcloud compute disks create [DISK NAME] --size 2 --type pd-standard
```

[Create a PersistentVolume](https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/#create-a-persistentvolume)

```yaml
# pv.yaml
kind: PersistentVolume
apiVersion: v1
metadata:
  name: my-pv-volume
  labels:
    type: local
  annotations:
    pv.beta.kubernetes.io/gid: 1000
spec:
  storageClassName: "[STORAGE CLASS]"
  capacity:
    storage: 8Gi
  accessModes:
    - ReadWriteOnce
  gcePersistentDisk:
    fsType: "ext4"
    pdName: "[DISK NAME]"
```

```bash
$ kubectl apply -f pv.yaml
```

コレを実行すると、storageClassNameが`[STORAGE CLASS]`のPersistentVolumeが作成されるため、
これをPersisntetVolumeClaimのstorageClassNameに記述し、リンクさせる。






