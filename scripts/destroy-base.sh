#!/bin/bash
# może coś to zrobie z usuwaniao maszun whipe out vmek stworzonych 
source ../config.env
ssh lab "rm -f "${LAB_DIR}/scripts/debian-base.qcow2""
