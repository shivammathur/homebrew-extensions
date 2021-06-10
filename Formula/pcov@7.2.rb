# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT72 < AbstractPhpExtension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.9.tar.gz"
  sha256 "c4c2a1de8e546c00eab8bd2a666028c25d16b8d76829e43280b742ae60e78f85"
  head "https://github.com/krakjoe/pcov.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "b30193b51659827b997d1b8a1bbca66bd717f7a69b5a1e267cf0c71904c60464"
    sha256 cellar: :any_skip_relocation, big_sur:       "5365a598029f772e9b3db61fe1ec484559c1ced9e82bf473ffb098fcc4f49b5f"
    sha256 cellar: :any_skip_relocation, catalina:      "a97c6ebe28d50359a9552f989352ca345d7261e643fe729648a9b81fcf8f2aa8"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
