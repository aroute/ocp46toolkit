# ocp46toolkit
## Dockerfile with CLIs for OpenShift 4.6

This is mainly for installing Cloud Paks on IBM Cloud OpenShift clusters.

1. From the default project. Launch the pod.

```
oc new-app --name=ocp46toolkit aroute/ocp46toolkit
```

2. Access terminal.

```
oc rsh/pod <name of the pod>
```

3. Install Cloud Pak CLI in your home directory. Don't forget to pload your `repo.yaml` file.

```
$ tar xzvf /tmp/cpd-cli.tar.gz -C .
```
