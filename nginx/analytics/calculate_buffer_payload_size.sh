
awk '($9 ~ /200/) { i++;sum+=$10;max=$10>max?$10:max; } END { printf("Maximum: %d\nAverage: %d\n",max,i?sum/i:0); }' /var/log/nginx/access.log