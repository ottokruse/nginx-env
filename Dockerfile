FROM nginx:alpine
ADD run.sh .
CMD ["./run.sh"]
