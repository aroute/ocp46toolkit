FROM ubuntu:latest

MAINTAINER Arif <arifroute@outlook.com>

ENV SUMMARY="Official Ubuntu Docker image using OpenShift specific guidelines." \
    DESCRIPTION="Ubuntu is a Debian-based Linux operating system based on free software."

### Atomic/OpenShift Labels - https://github.com/projectatomic/ContainerApplicationGenericLabels
LABEL summary="${SUMMARY}" \
      description="${DESCRIPTION}" \
### Required labels above - recommended below
      url="https://github.com/aroute" \
      help="For more information visit https://github.com/aroute/ocp46toolkit" \
      run='docker run -itd --name ocp46toolkit aroute/ocp46toolkit bash' \
      io.k8s.description="${DESCRIPTION}" \
      io.k8s.display-name="${SUMMARY}" \
      io.openshift.expose-services="" \
      io.openshift.tags="ubuntu,starter-arbitrary-uid,starter,arbitrary,uid"

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y && apt-get install -y vim gettext iputils-ping mlocate git curl openssl zip unzip openjdk-8-jdk && apt-get clean all -y \
&& updatedb \
&& curl -sL https://ibm.biz/idt-installer | bash \
&& curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 \
&& chmod 700 get_helm.sh \
&& bash ./get_helm.sh \
&& curl -sLo /tmp/oc.tar.gz https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/oc/4.6/linux/oc.tar.gz \
&& tar xzvf /tmp/oc.tar.gz -C /usr/local/bin/ \
&& rm -rf /tmp/oc.tar.gz \
&& curl -sLo /tmp/cpd-cli.tar.gz https://github.com/IBM/cpd-cli/releases/download/v3.5.4/cpd-cli-linux-EE-3.5.4.tgz \
# && tar xzvf /tmp/cpd-cli.tar.gz -C . \
# && rm -rf /tmp/cpd-cli.tar.gz \
&& rm -rf /var/lib/apt/lists/*

### Setup user for build execution and application runtime
ARG user=demo
ARG group=demo
ARG uid=1001
ARG gid=1001
ARG HOME=/home/demo
ENV HOME $HOME
RUN groupadd -g ${gid} ${group} \
  && useradd -u ${uid} -g ${gid} -m -s /bin/bash ${user} \
  && chown -R ${uid}:${gid} $HOME
USER ${user}
WORKDIR ${HOME}
ENTRYPOINT ["/bin/bash", "-ce", "tail -f /dev/null"]

# Ref: https://github.com/jefferyb/openshift-ubuntu
