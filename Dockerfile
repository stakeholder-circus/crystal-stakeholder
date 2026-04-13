FROM crystallang/crystal:1.18.2 AS build
WORKDIR /app
COPY shard.yml ./
COPY src ./src
COPY spec ./spec
RUN crystal tool format --check src spec
RUN crystal spec
RUN crystal build src/crystal_stakeholder.cr --release --no-debug -o /opt/crystal-stakeholder

FROM crystallang/crystal:1.18.2 AS runtime
COPY --from=build /opt/crystal-stakeholder /usr/local/bin/crystal-stakeholder
ENTRYPOINT ["crystal-stakeholder"]
