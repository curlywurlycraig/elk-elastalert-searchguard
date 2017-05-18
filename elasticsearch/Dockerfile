# https://github.com/elastic/elasticsearch-docker
FROM docker.elastic.co/elasticsearch/elasticsearch:5.2.2

COPY bin/ bin/

# Add your elasticsearch plugins setup here
# Example: RUN elasticsearch-plugin install analysis-icu
RUN elasticsearch-plugin install --batch com.floragunn:search-guard-5:5.2.2-11 \
	&& chmod +x \
		plugins/search-guard-5/tools/hash.sh \
		plugins/search-guard-5/tools/sgadmin.sh

RUN \
  mv /usr/share/elasticsearch/plugins/x-pack /usr/share/elasticsearch/plugins/.removing-x-pack && \
  mv /usr/share/elasticsearch/plugins/.removing-x-pack /usr/share/elasticsearch/plugins/x-pack && \
  /usr/share/elasticsearch/bin/elasticsearch-plugin remove x-pack