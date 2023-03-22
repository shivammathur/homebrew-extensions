# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT73 < AbstractPhpExtension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/swoole/swoole-src/archive/v5.0.2.tar.gz"
  sha256 "14d442d5e945fe67a3e912d332175b2386a50c38a674c4559d2d0211db23362e"
  head "https://github.com/krakjoe/pcov.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "0c496bc6fe2dae9253be806e234fecc79c7882ae70bcce144bf20cea3ae28ea2"
    sha256 cellar: :any_skip_relocation, big_sur:       "536047f5127437b79f8923c2e2cf9d3ac8fd1dc319b461e8e5ac044a0e26865d"
    sha256 cellar: :any_skip_relocation, catalina:      "6297e4979866f7e1a74466e03cff2d458f5d8de31804ef6fd5f64e306fcced63"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "753fc3caab36b4ef9f246086c414a4947c4c6c4fe919869e4172eb27ab13f806"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
