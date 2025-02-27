FROM docker.binarios.intranet.bb.com.br/bb/dev/dev-nodejs:22.4.1

# Define metadados da imagem
ARG build_date
ARG vcs_ref
ARG VERSAO=1.8.3
ARG BOM_PATH="/docker/web"

LABEL \
    br.com.bb.image.app.sigla="web" \
    br.com.bb.image.app.provider="" \
    br.com.bb.image.app.arch="x86_64" \
    br.com.bb.image.app.maintainer="Banco do Brasil S.A. / DITEC <ditec@bb.com.br>" \
    br.com.bb.image.app.version="$VERSAO" \
    br.com.bb.image.description="" \
    org.label-schema.maintainer="Banco do Brasil S.A. / DITEC <ditec@bb.com.br>" \
    org.label-schema.vendor="Banco do Brasil" \
    org.label-schema.url="https://fontes.intranet.bb.com.br/web/web-search-api/web-search-api" \
    org.label-schema.name="" \
    org.label-schema.license="COPYRIGHT" \
    org.label-schema.version="$VERSAO" \
    org.label-schema.vcs-url="https://fontes.intranet.bb.com.br/web/web-search-api/web-search-api" \
    org.label-schema.vcs-ref="$vcs_ref" \
    org.label-schema.build-date="$build_date" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.dockerfile="${BOM_PATH}/Dockerfile"

# Copia arquivos para o caminho do Bill of Materials (BOM)
COPY README.md CHANGELOG.md LICENSE Dockerfile ${BOM_PATH}/

# Define variáveis de ambiente
ENV VERSAO=$VERSAO

# Configura o fuso horário (executado como root)
ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Define o diretório de trabalho
WORKDIR /src

# Define o ambiente como produção
ENV NODE_ENV production

# Copia os arquivos do projeto
COPY . .

# Instala dependências (executado como root)
RUN npm config set strict-ssl false && \
    npm config set registry https://binarios.intranet.bb.com.br/artifactory/api/npm/npm/ && \
    npm install --only=production && \
    npm cache clean --force

# Cria um usuário não privilegiado e define como padrão
RUN addgroup -S nodegroup && adduser -S nodeuser -G nodegroup

# Altera a propriedade dos arquivos para o usuário não privilegiado
RUN chown -R nodeuser:nodegroup /src

# Define o usuário não privilegiado
USER 1001:1001

# Expõe a porta 3000
EXPOSE 3000

# Comando para iniciar a aplicação
CMD ["npm", "start"]
