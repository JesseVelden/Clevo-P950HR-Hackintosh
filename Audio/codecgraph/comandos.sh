#!/bin/bash
# Executar Comandos para Extrair Arquivos para Correção da AppleHDA
cd ~/Desktop/codecgraph

./codecgraph codec_dump.txt

cd ~/Desktop/codecgraph 

chmod +x ./convert_hex_to_dec.rb

./convert_hex_to_dec.rb codec_dump.txt.svg > ~/Desktop/codecgraph/codec_dump_dec.txt.svg

./convert_hex_to_dec.rb codec_dump.txt > ~/Desktop/codecgraph/codec_dump_dec.txt

cd ~/Desktop/codecgraph 

./Verbit codec_dump.txt> verbs.txt