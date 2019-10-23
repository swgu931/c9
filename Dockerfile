# setup environment for machine learing examples

# Base Image
FROM jupyter/base-notebook:latest

# Maintainer
LABEL maintainer "SW"

# Configure environment
ENV CONDA_DIR=/opt/conda \
    NB_USER=Jupyter
    
# Install Jupyter Notebook and Hub
RUN conda install --quiet --yes \
    'numpy=1.13.*' \
    'scipy=0.19.*' \
    'sympy=1.1.*' \
    'matplotlib=2.1.*' \
    && conda clean -tipsy && \
    fix-permissions $CONDA_DIR

# Install Sample Notebook
COPY ./*.ipynb /home/$NB_USER/
