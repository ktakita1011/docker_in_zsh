FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    git \
    zsh \
    sed \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
ENV SHELL /usr/bin/zsh
RUN zsh
#set default shell to zsh
RUN chsh -s /bin/zsh
#zprezto install
RUN git clone --recursive \
    https://github.com/sorin-ionescu/prezto.git \
    $HOME/.zprezto

SHELL ["/bin/zsh", "-c"]
RUN setopt EXTENDED_GLOB; \
    for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do \
      ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"; \
    done
RUN git clone --recurse https://github.com/belak/prezto-contrib $HOME/.zprezto/contrib
RUN sed -i "/'prompt'/c \\\ 'contrib-prompt' \\\\\n  'prompt'" /root/.zpreztorc
RUN sed -i "s/theme 'sorin'/theme 'spaceship'/g" /root/.zpreztorc

CMD ["/bin/zsh"]