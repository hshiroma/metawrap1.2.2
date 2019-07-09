FROM continuumio/miniconda3:4.6.14
ENV VERSION 1.2.2
MAINTAINER siromah
RUN conda config --add channels defaults && \
    conda config --add channels conda-forge && \
    conda config --add channels bioconda && \
    conda config --add channels ursky && \
    conda install -y -c ursky metawrap-mg && \
    conda install --only-deps -c ursky metawrap-mg && conda clean -a && \
    git clone https://github.com/bxlab/metaWRAP.git && \
    mkdir /CheckM
RUN echo -e "cat << EOF\n/CheckM\nEOF\n" | checkm data setRoot
RUN wget -O /CheckM/checkm_data_2015_01_16.tar.gz https://data.ace.uq.edu.au/public/CheckM_databases/checkm_data_2015_01_16.tar.gz && \
    tar -xvf /CheckM/*.tar.gz -C /CheckM && \
    rm /CheckM/*.gz
RUN conda create -n prokka_env -c conda-forge -c bioconda prokka && \
    conda create -n trna_se_env -c bioconda trnascan-se && \
    conda create -n seqkit_env -c bioconda seqkit  && \
    conda create -n drep_env -c bioconda drep
ENV PATH=${PATH}:/metaWRAP/bin
