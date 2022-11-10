# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.0.1.tar.gz"
  sha256 "8db635960f25b8b986f5214b44941f499d61d037867e11e27da108c19dc855c3"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "ef0b7eb11a4e436bab15e74c7c175d5916a50e0aaf306919e251cac2bba9cecb"
    sha256 cellar: :any,                 arm64_big_sur:  "02c39c3ffbe85d9d21ab594db71cbf318fe2109978529ccfcf467d5f3c4b5a26"
    sha256 cellar: :any,                 monterey:       "982d78b4dd145cede7ae5c0996ff1fdeedbcb2ad2fd6b0a003d6e2eaa38a9610"
    sha256 cellar: :any,                 big_sur:        "422704e5fe1c32ad04cb8b690915f15e9343b3283bea98e7260b0c2fb4763cf9"
    sha256 cellar: :any,                 catalina:       "2abfec975ebfffcc2a288e3a38899375761bd2ecc49528238466e6758d9e1445"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "990f1359bfe2bcd244490050cb02fdfe5193e7d3446c6c5699fca2f99ec87ec1"
  end

  depends_on "brotli"

  uses_from_macos "zlib"

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
