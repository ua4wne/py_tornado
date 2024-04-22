FROM python:alpine3.18 AS build
RUN apk --no-cache add git
RUN git clone https://github.com/tornadoweb/tornado.git && cd tornado && python setup.py build && python setup.py install

WORKDIR /tornado
COPY tornado.py .

EXPOSE 8888/tcp
CMD ["python", "tornado.py"]


FROM python:alpine3.18 AS prod

WORKDIR /tornado

COPY --from=build tornado /tornado/

EXPOSE 8888/tcp
CMD ["python", "tornado.py"]
