FROM python:3.6.8-alpine3.9

ENV APP_HOME /search_engine_crawler
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
COPY . $APP_HOME

RUN pip install -r ${APP_HOME}/requirements.txt

ENV MONGO mongodb
ENV MONGO_PORT 27017
ENV RMQ_HOST rabbitmq
ENV RMQ_QUEUE queue_name
ENV RMQ_USERNAME rmq_user
ENV RMQ_PASSWORD rmq_pass
ENV CHECK_INTERVAL 5
ENV EXCLUDE_URLS '.*github.com'

ENTRYPOINT ["python", "-u", "crawler/crawler.py", "https://vitkhab.github.io/search_engine_test_site/"]
