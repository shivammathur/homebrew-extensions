# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT72 < AbstractPhp72Extension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.8.tar.gz"
  sha256 "f67a1c1aabe798e5bb85d0ea8c7b1d27b226b066d12460da8d78b48bfc6f455e"
  head "https://github.com/krakjoe/pcov.git"
  license "PHP-3.01"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "b30193b51659827b997d1b8a1bbca66bd717f7a69b5a1e267cf0c71904c60464"
    sha256 cellar: :any_skip_relocation, big_sur:       "5365a598029f772e9b3db61fe1ec484559c1ced9e82bf473ffb098fcc4f49b5f"
    sha256 cellar: :any_skip_relocation, catalina:      "a97c6ebe28d50359a9552f989352ca345d7261e643fe729648a9b81fcf8f2aa8"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
