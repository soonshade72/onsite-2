FROM python 
WORKDIR /app
COPY req.txt
RUN pip  install -r req.txt
COPY . .
EXPOSE 5001
CMD ["python","server1.py"]
