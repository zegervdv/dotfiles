FROM ubuntu:20.04 as builder

ENV DEBIAN_FRONTEND="noninteractive" TZ="Europe/Brussels"

RUN apt update -y \
 && apt upgrade -y \
 && apt install -y git \
                   wget \
                   build-essential \
                   ninja-build \
                   gettext \
                   libtool \
                   libtool-bin \
                   autoconf \
                   automake \
                   cmake \
                   g++ \
                   pkg-config \
                   unzip \
                   curl \
                   doxygen

WORKDIR /build

RUN git clone https://github.com/neovim/neovim.git \
 && cd neovim \
 && make CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX=/apps/nvim \
 && make install


FROM ubuntu:20.04

RUN apt update \
 && apt install -y unzip curl git

WORKDIR /config
RUN echo '[data]\n\
      email="none"\n\
      name="none"\n\
      signingkey="none"\n\
      font_size="11.0"' > /config/chezmoi.toml
RUN sh -c "$(curl -fsLS git.io/chezmoi)" -- init --config "/config/chezmoi.toml" --one-shot zegervdv

COPY scripts/install.sh /install.sh
RUN sh /install.sh

COPY --from=builder /apps /apps

RUN /apps/nvim/bin/nvim --headless +qall
RUN /apps/nvim/bin/nvim --headless --noplugin +'lua vim.defer_fn(function () vim.cmd [[PackerSync]] end, 0)' +'autocmd User PackerComplete qall'

ENTRYPOINT ["/apps/nvim/bin/nvim"]
