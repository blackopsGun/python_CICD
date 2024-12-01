from flask import Flask
app=Flask(_name_)

@app.route("/")
def hello_world():
  return "Hello From Git+Docker+Jenkins+K8s"
