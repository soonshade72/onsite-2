from flask import Flask,jsonify,request
import socket
app=Flask(__name__)
total=0
unique=set()
identity= socket.gethostname()
@app.route("/")
def home():
    global total,unique 
    ip=request.remote_addr
    total+=1
    unique.add(ip)
    return jsonify({
        "server_identity":identity,
        "total_requests": total,
        "unique_users":len(unique)
    })
if __name__=="__main__":
    app.run(host="0.0.0.0",port=5004)
