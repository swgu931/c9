# setup environment for machine learing examples

# Base Image
FROM jupyter/base-notebook:latest

# Maintainer
LABEL maintainer "SW"

# Configure environment
ENV CONDA_DIR=/opt/conda \
    NB_USER=jupyter
    
# Install Jupyter Notebook and Hub
RUN conda install --quiet --yes \
    'numpy=1.16.*' \
    'scipy=1.3.*' \
    'sympy=1.4*' \
    'matplotlib=3.1.*' 
RUN conda clean -tipsy 
RUN fix-permissions $CONDA_DIR

# Install Sample Notebook
RUN mkdir -p /home/$NB_USER/c9-src
COPY *.ipynb /home/$NB_USER/c9-src
WORKDIR $HOME/$NB_USER

ENTRYPOINT ["tini", "-g", "--"]
CMD ["start-notebook.sh"]
