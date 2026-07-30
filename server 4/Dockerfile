FROM python 
WORKDIR /app
COPY req.txt
RUN pip  install -r req.txt
COPY . .
EXPOSE 5004
CMD ["python","server4.py"]
