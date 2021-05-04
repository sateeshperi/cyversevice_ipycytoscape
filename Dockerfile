FROM cyversevice/jupyterlab-datascience:latest

USER root 

WORKDIR /usr/local/src

# install conda packages
COPY ./environment.yml /usr/local/src 
RUN conda update -n base -c defaults conda
RUN conda env update -n base -f environment.yml && \
    conda clean --all

# install iRODS plugin
RUN conda install -c conda-forge nodejs -y
RUN pip install jupyterlab_irods==3.0.*

RUN jupyter serverextension enable --py jupyterlab_irods
RUN jupyter labextension install ijab

USER jovyan
EXPOSE 8888

# copy node and edge table
COPY "./edges_table.csv" "/home/jovyan"
COPY "./nodes_table_all_labelled.csv" "/home/jovyan"

WORKDIR /home/jovyan
