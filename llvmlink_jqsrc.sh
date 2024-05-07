#!/bin/bash

# Step 1: Compile each source file to LLVM IR
for file in cjq/jq/src/*.c; do
    filename=$(basename -- "$file")
    filename="${filename%.*}"  # Extract filename without extension
    clang -S -funwind-tables -O1 -emit-llvm -o "cjq/jq/src/$filename.ll" "$file"
done

# Step 2: Link LLVM IR files together
llvm-link -S -o jq_src_combined.ll cjq/jq/src/*.ll
