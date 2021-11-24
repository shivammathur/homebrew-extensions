# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT74 < AbstractPhpExtension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.10.tar.gz"
  sha256 "1fd2748f2db4dbbf5f6ac1691b6bd528d23522e0fcdeeda63cbb9de2a0e8d445"
  head "https://github.com/krakjoe/pcov.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "d1ae982a75a3a4cd4fb8e4b062677f432b82cf5c2d66807d5f279cc297cd2a85"
    sha256 cellar: :any_skip_relocation, big_sur:       "4a20389fac6e3f7d2f879d7ccc466035632d47ff6b3ec15d62db83ccd381e22e"
    sha256 cellar: :any_skip_relocation, catalina:      "ab56924861f381614c6f158f8e7a9850951ea21cbbb73caaecf747e2d65f9808"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ef438382cec3ce9369c84c4e1c340297d82734bc6337cbfee409ff368d3bdc5d"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
