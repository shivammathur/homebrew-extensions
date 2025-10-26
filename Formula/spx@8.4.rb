# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SpxAT84 < AbstractPhpExtension
  init
  desc "SPX is a simple & straight-forward PHP profiler"
  homepage "https://github.com/NoiseByNorthwest/php-spx"
  url "https://github.com/NoiseByNorthwest/php-spx/archive/refs/tags/v0.4.22.tar.gz"
  sha256 "6f89addd100d3d71168c094612eb8e1c06fd8062da6ee4d9df5b31bdfc4de160"
  head "https://github.com/NoiseByNorthwest/php-spx.git", branch: "master"
  license "GPL-3.0-or-later"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "0c358d90e67bfab65c4b15d57defa344333a5b9371592673cfa2e26498d65a58"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d40da7d57df6f29cc5e4e0faceacc7c4cbd552d120cd3b76f97122472b6e1cca"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b6642c5c775328ad54fa45bc5c7fedd6621137238a0f8a8f52747b39414d1686"
    sha256 cellar: :any_skip_relocation, sonoma:        "57f5fbf3ede4493352a4bb77fbab042d8675e3526d4de4658e5ac67f6a5d0425"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "dd6cd637a0cc09a3d19c138faa2c8b4e0ca23447453653d47b6a8789abcd1645"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "44ca81d065e0c444fece7c2466a216b56acea5d0002b2b144226d4c7fe7fcea9"
  end

  depends_on "zlib"

  def install
    args = %W[
      --enable-spx
      --with-zlib-dir=#{Formula["zlib"].opt_prefix}
    ]
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
