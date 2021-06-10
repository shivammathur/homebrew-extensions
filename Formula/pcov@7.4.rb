# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT74 < AbstractPhpExtension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.9.tar.gz"
  sha256 "c4c2a1de8e546c00eab8bd2a666028c25d16b8d76829e43280b742ae60e78f85"
  head "https://github.com/krakjoe/pcov.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "cec867cd083630436128112956d7f356bb2c1d97815b518a3cbb1c6585f4e956"
    sha256 cellar: :any_skip_relocation, big_sur:       "6c518a2cb0fcf4016f01c62e4487f858b1578322c298a7273208089f2f0395d6"
    sha256 cellar: :any_skip_relocation, catalina:      "688a2fc74d1c8b9e822439be8689063c956894c5c852d8958f0c28e5a4a3452e"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
