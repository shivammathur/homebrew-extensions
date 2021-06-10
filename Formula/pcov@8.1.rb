# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT81 < AbstractPhpExtension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.9.tar.gz"
  sha256 "c4c2a1de8e546c00eab8bd2a666028c25d16b8d76829e43280b742ae60e78f85"
  head "https://github.com/krakjoe/pcov.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "8bd77e59455ec57566d027c917a8d86e524303fb55ad002f7cb0643a6a76288a"
    sha256 cellar: :any_skip_relocation, big_sur:       "2ec33ed2b1e1a5d0b140432143266835c48e1001a0536fe0512236bebf125c12"
    sha256 cellar: :any_skip_relocation, catalina:      "1945d5eeaa9391c4af02f8ab1e87ec1849edb8967e0ed4345d56721545f26b0d"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
