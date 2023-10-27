From python:3.8

# environment variable 
ENV DockerHOME=/home/app/api

# directory to work
RUN mkdir -p $DockerHOME  

# where your code lives  
WORKDIR $DockerHOME 

# environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1  
ENV PYTHONIOENCODING UTF-8

# update dependencias of python 
RUN pip install --upgrade pip

# install libraries

RUN apt-get update && apt-get install -y -q --no-install-recommends
RUN apt-get install -y build-essential
RUN apt-get install -y libpq-dev
RUN apt --fix-broken install
COPY . $DockerHOME
RUN pip install torch --index-url https://download.pytorch.org/whl/cpu
RUN pip install openai
RUN pip install llama-index
RUN pip install pypdf
RUN pip install llama-cpp-python
RUN pip install sentence_transformers
RUN pip install flask
RUN pip install flask_cors
RUN pip install jsonschema
RUN pip install flask-jwt-extended
RUN pip install psycopg2
RUN pip install langdetect
ARG port=5000
EXPOSE $port:$port
CMD ["flask", "--app", "gptmodel.py", "run","--host=0.0.0.0","--port=5000"]