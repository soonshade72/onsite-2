FROM python 
WORKDIR /app
COPY req.txt
RUN pip  install -r req.txt
COPY . .
EXPOSE 5003
CMD ["python","server3.py"]
