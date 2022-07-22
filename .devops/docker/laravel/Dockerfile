FROM puncoz/laravel:7.4

LABEL maintainer="Puncoz Nepal"

###########################################################################
# Non-root user:
###########################################################################

# Add a non-root user to prevent files being created with root permissions on host machine.
ARG PUID=1000
ENV PUID ${PUID}
ARG PGID=1000
ENV PGID ${PGID}
ARG DOCKER_USER=laravel

RUN groupadd --force -g ${PGID} ${DOCKER_USER}
RUN useradd -ms /bin/bash --no-user-group -g ${PGID} -u ${PUID} ${DOCKER_USER}

###########################################################################
# User Aliases
###########################################################################
USER ${DOCKER_USER}

COPY ./aliases.sh /home/${DOCKER_USER}/aliases.sh

RUN echo "" >> ~/.bashrc && \
    echo "# Load Custom Aliases" >> ~/.bashrc && \
    echo "source ~/aliases.sh" >> ~/.bashrc && \
    echo "" >> ~/.bashrc

CMD ["/bin/sh", "-l"]

#
#--------------------------------------------------------------------------
# Final Touch
#--------------------------------------------------------------------------
#

USER root

ENV CODE_ROOT="/var/www/html"
WORKDIR ${CODE_ROOT}

COPY ./entrypoint.sh /entrypoint.sh
COPY ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY ./laravel.ini /usr/local/etc/php/conf.d/99-laravel.ini

RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 9000
