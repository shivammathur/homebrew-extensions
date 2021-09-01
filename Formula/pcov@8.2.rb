# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT82 < AbstractPhpExtension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.9.tar.gz"
  sha256 "c4c2a1de8e546c00eab8bd2a666028c25d16b8d76829e43280b742ae60e78f85"
  head "https://github.com/krakjoe/pcov.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "276e0293831cd0c97254fc9319c5ac405742fd6b479824822a3abbed4170cc36"
    sha256 cellar: :any_skip_relocation, big_sur:       "e20ff5286d7913217914fbb5ea3b2c145ab4ac1a70b6ee316ee96d1600d923d7"
    sha256 cellar: :any_skip_relocation, catalina:      "4fe487838d59171fc92efe66c71b2a76704901563912abddb4bebaf3919ca189"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7a4344bbcacbd12a392d295fb70e27b205b56868af3bd2231b07e275fc32df8a"
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
