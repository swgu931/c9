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
    'matplotlib=3.1.*' \
    'cvxpy'
RUN conda install --quiet --yes \
    pillow pandas seaborn scikit-learn toolz
    
RUN pip install --quiet opencv-python 
RUN pip install --quiet tensoflow==1.15.0
    
RUN conda clean -tipsy 
RUN fix-permissions $CONDA_DIR 

# Install Sample Notebook
RUN fix-permissions /home/
RUN mkdir /home/$NB_USER/c9-src && fix-permissions /home/$NB_USER/c9-src
RUN fix-permissions /home/$NB_USER/c9-src/

USER root
COPY *.ipynb /home/$NB_USER/c9-src/
WORKDIR /home/$NB_USER

ENTRYPOINT ["tini", "-g", "--"]
CMD ["start-notebook.sh"]
