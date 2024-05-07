#!/bin/bash

# Step 1: Compile each source file to LLVM IR
for file in cjq/frontend/*.c; do
    filename=$(basename -- "$file")
    filename="${filename%.*}"  # Extract filename without extension
    clang -S -funwind-tables -O1 -emit-llvm -o "cjq/frontend/$filename.ll" "$file"
done

# Step 2: Link LLVM IR files together
llvm-link -S -o frontend_combined.ll cjq/frontend/*.ll
