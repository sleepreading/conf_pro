#!/usr/bin/env bash

ETCD_NAME=node-1
ETCD_DATA_DIR=/opt/etcd/data
LOCAL_IP=10.211.55.2

INITIAL_CLUSTER="node-1=http://10.211.55.2:2380,node-2=http://10.211.55.25:2380,node-3=http://10.211.55.26:2380"
INITIAL_CLUSTER_TOKEN=gcluster
INITIAL_CLUSTER_STATE=new

etcd --name ${ETCD_NAME} --data-dir ${ETCD_DATA_DIR} \
    --initial-advertise-peer-urls http://${LOCAL_IP}:2380 \
    --listen-peer-urls http://${LOCAL_IP}:2380 \
    --listen-client-urls http://${LOCAL_IP}:2379,http://127.0.0.1:2379 \
    --advertise-client-urls http://${LOCAL_IP}:2379 \
    --initial-cluster ${INITIAL_CLUSTER} \
    --initial-cluster-token ${INITIAL_CLUSTER_TOKEN} \
    --initial-cluster-state ${INITIAL_CLUSTER_STATE}