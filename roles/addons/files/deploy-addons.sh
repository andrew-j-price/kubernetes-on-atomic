#!/bin/bash
kubectl create -f /etc/kubernetes/manifests/kube-system.yaml
kubectl create -f /etc/kubernetes/manifests/kube-dns.yaml
kubectl create -f /etc/kubernetes/manifests/dashboard.yaml
kubectl create -f /etc/kubernetes/manifests/busybox.yaml
kubectl describe namespace kube-system
