
FROM centos:centos7
COPY requirements.txt requirements.txt
RUN mkdir /python_api && yum -y install python3 pip3 && pip3 install -r requirements.txt
COPY python-api.py /python_api/python-api.py
EXPOSE "5290/tcp"
WORKDIR /python_api
CMD ["python3", "/python_api/python-api.py"]
