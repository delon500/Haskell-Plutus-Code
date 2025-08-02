set -euo pipefail

for n in $(seq -w 1 10); do
    touch "HC11T${n}.hs"
done