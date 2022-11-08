# MIT License
# 
# Copyright (c) 2022 The Homeport Team
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

FROM registry.access.redhat.com/ubi9-minimal:latest
RUN \
  microdnf update \
    --assumeyes \
    --nodocs && \
  microdnf install \
    --assumeyes \
    --nodocs \
    --noplugins \
    jq \
    tar \
    gzip && \
  microdnf clean all && \
  rm -rf /var/cache/yum

RUN GHCLI_VERSION="$(curl --silent --fail --location https://api.github.com/repos/cli/cli/releases | jq --raw-output '.[0].tag_name')" && \
  curl --fail --silent --location https://github.com/cli/cli/releases/download/${GHCLI_VERSION}/gh_${GHCLI_VERSION//v/}_linux_amd64.tar.gz | tar -xzf - -C /tmp "gh_${GHCLI_VERSION//v/}_linux_amd64/bin/gh" && \
  mv "/tmp/gh_${GHCLI_VERSION//v/}_linux_amd64/bin/gh" /usr/local/bin && \
  rm -rf "/tmp/gh_${GHCLI_VERSION//v/}_linux_amd64"

COPY scripts/check scripts/out scripts/in /opt/resource/
