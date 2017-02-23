FROM centos:latest
MAINTAINER laofo <laofo521@gmail.com>

ENV RVM_PATH /home/rvm/
ENV HOME /root

RUN groupadd cmbuild && useradd -g cmbuild -s /bin/bash -c Admin cmbuild  &&  \
    mkdir -p /home/cmbuild && chown cmbuild:cmbuild -R /home/cmbuild && \
    echo "cmbuild:MhxzKhlsdfsdfsfd" | chpasswd && \
    echo "cmbuild   ALL=(ALL)       ALL" >> /etc/sudoers

#RUN yum update && \
#    yum -y upgrade && \
RUN    yum install -y build-essential \
	vim \
	curl \
	git \
	zip \
	unzip \
	tar \
	wget \
	libxml2 \
	libxslt \
	libiconv \
	gcc \
	gmake \
	make \
	nodejs \
	ruby \
	ruby-devel \
	ruby-io-console \
	ruby-irb \
	ruby-json \
	ruby-rake \
        rubygems && \ 
    yum clean all

ADD ./soft /opt/soft
RUN sh /opt/soft/setuptools-0.6c11-py2.7.egg
RUN cd /opt/soft && tar zvxf 9.0.1.tar.gz && \
    cd pip-9.0.1 && \
    python setup.py install && \
    pip install supervisor && \
    pip install meld3==0.6.7

RUN cp -r /opt/soft/supervisord.d /etc/supervisord.d && \
    mkdir /var/log/supervisor && \
    mkdir -p /var/log/supervisord && \
    touch /var/log/supervisord/supervisord.log && \
    cp /opt/soft/supervisord.conf /etc/supervisord.conf

RUN gem sources --add https://gems.ruby-china.org/ --remove https://rubygems.org/
RUN gem update --system
RUN gem clean && gem install bundler --no-rdoc --no-ri
RUN bundle config mirror.https://rubygems.org https://gems.ruby-china.org
RUN gem install json
RUN gem install rb-inotify
#RUN gem install jekyll --no-rdoc --no-ri

RUN gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN cd /root && curl -L https://get.rvm.io | bash -s stable
RUN /usr/local/rvm/bin/rvm install 2.2.2
RUN mkdir -p /root/.rvm/user
RUN echo "ruby_url=https://cache.ruby-china.org/pub/ruby" > ~/.rvm/user/db
#nokogiri needs ruby >2.1.0
RUN /bin/bash -l -c "rvm --default use 2.2.2 && \
	gem install execjs && \
	gem install therubyracer && \
	gem install nokogiri --no-rdoc --no-ri && \
	gem install jekyll --no-rdoc --no-ri && \
	gem install bundler"

ADD ./start.sh /root
VOLUME /root/jekyll
WORKDIR /root/jekyll

USER root
EXPOSE 22 4567
CMD ["supervisord","-n"]
