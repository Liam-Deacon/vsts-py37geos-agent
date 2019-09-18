FROM microsoft/vsts-agent:ubuntu-16.04

# Install Python3.7
RUN add-apt-repository ppa:deadsnakes/ppa \
  && apt-get update -y \
  && apt-get install -y python3.7 python3.7-dev python3.7-venv git build-essential \
  && ln -sf `which python3.7` /usr/bin/python3 \
  && curl https://bootstrap.pypa.io/get-pip.py | python3 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /etc/apt/sources.list.d/*

# Install dotnet core for coverage reporting
RUN wget -q https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
  && dpkg -i packages-microsoft-prod.deb \
  && apt-get update \
  && apt-get install -y dotnet-runtime-2.2 \
  && rm -rf /var/lib/apt/lists/*

#  && conda install -y pyproj>=2.2 shapely cartopy descartes lxml numpy scipy matplotlib pandas \
#  && rm -rf $CONDA/pkgs/*"
# install key python libraries
#RUN /bin/bash -c "source $CONDA/bin/activate \ 
#  && pip install geopandas contextily pint folium IPython beautifulsoup4 requests astropy NavPy geopy"
# install key python packages
RUN pip install --no-cache-dir pbr docutils sphinx setuptools
#RUN /bin/bash -c "source $CONDA/bin/activate \
#  && pip install sphinx-autodoc-napoleon-typehints javasphinx sphinx-fortran \
#sphinx-git sphinx-markdown-builder \
#sphinxcontrib-autojs sphinxcontrib-packages sphinxcontrib-needs sphinxcontrib-jupyter sphinx-autodoc-annotation \
#sphinxcontrib-issuetracker sphinxcontrib-domaintools sphinxcontrib-adadomain \
#sphinxcontrib-makedomain sphinxcontrib-matlabdomain sphinx-paramlinks sphinxcontrib-plantuml \
#sphinxcontrib-requirements sphinxcontrib-email stdeb sphinxpapyrus-docxbuilder"
# install key python testing libraries
#RUN /bin/bash -c "source $CONDA/bin/activate \
#  && pip install mypy autopep8 pydocstyle \
#pytest pytest-cov pytest-asyncio pytest-pylint \
#mypy radon>=2.4.0 flake8 pylint asynctest \
#nose autopep8 gitpython nbconvert jupyter_client pbr" 
# install key documentation libraries
#RUN apt-get update && \
#  apt-get install -y librsvg2-bin latexmk tex-common tex-gyre fonts-freefont-otf texlive-xetex texlive-fonts-recommended graphviz dvipng librsvg2-bin && \
#  rm -rf /var/lib/apt/lists/*

# Install other key utilities
RUN apt-get update && \
  apt-get install -y make && \
  rm -rf /var/lib/apt/lists/*

RUN apt-get update \
  && apt install -y libgeos-dev libproj-dev \
  && rm -rf /var/lib/apt/lists/*

RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ xenial multiverse" >> /etc/apt/sources.list \
  && apt-get update -y \
  && apt-get install -y proj-bin \
  && rm -rf /var/lib/apt/lists* 

RUN pip install --no-cache-dir numpy scipy pandas geopandas 'pyproj>=2.2.0' cartopy

# Clean system
RUN apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /etc/apt/sources.list.d/* \
 && mkdir -p /var/lib/apt/lists/ \
 && mkdir -p /etc/apt/sources.list.d/

#RUN ln -sf `which pip3.7` /usr/bin/pip3 \
#  && ln -sf `which pip3.7` /usr/bin/pip

#RUN chown -R 1001:1001 $CONDA

#ENV PATH $CONDA/condabin/:$CONDA/bin/:$PATH
CMD /bin/bash 
