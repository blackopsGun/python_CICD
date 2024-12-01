FROM python:3.9-slim-buster

WORKDIR /ks_python

COPY . /ks_python

RUN pip install -r requirements.txt

EXPOSE 5000

CMD ["python", "app.py"]
