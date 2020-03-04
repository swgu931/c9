# setup environment for machine learing examples

# Base Image
FROM jupyter/base-notebook:latest

# Maintainer
LABEL maintainer "SW"

# Configure environment
ENV CONDA_DIR=/opt/conda \
    NB_USER=jovyan
    
# Install Jupyter Notebook and Hub
RUN conda install --quiet --yes \
    'numpy=1.16.*' \
    'scipy=1.3.*' \
    'sympy=1.4*' \
    'matplotlib=3.1.*' 
RUN conda clean -tipsy 
RUN fix-permissions $CONDA_DIR 

# Install Sample Notebook
RUN fix-permissions /home/
RUN mkdir /home/$NB_USER/c9-src && fix-permissions /home/$NB_USER/c9-src

USER $NB_USER

RUN fix-permissions /home/$NB_USER/c9-src/
COPY *.ipynb /home/$NB_USER/c9-src/
WORKDIR $HOME

ENTRYPOINT ["tini", "-g", "--"]
CMD ["start-notebook.sh"]
