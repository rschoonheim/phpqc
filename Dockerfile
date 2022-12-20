FROM ghcr.io/rschoonheim/phpqc:release

COPY --chown=qualityContainer:qualityContainer phpqc /home/qualityContainer/scripts
RUN echo "alias phpqc=/home/qualityContainer/scripts/phpqc" >> ~/.bashrc
CMD ["phpqc"]