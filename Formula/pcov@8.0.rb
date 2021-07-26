# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT80 < AbstractPhpExtension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.9.tar.gz"
  sha256 "c4c2a1de8e546c00eab8bd2a666028c25d16b8d76829e43280b742ae60e78f85"
  head "https://github.com/krakjoe/pcov.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "bb8086546bb9793d7aef721e524eff3d83a0b9931a52ef0234a5f739f0cad8f8"
    sha256 cellar: :any_skip_relocation, big_sur:       "89728582de3d234a07ae171f026192febb17b059b627f55a33b49de5218fd21e"
    sha256 cellar: :any_skip_relocation, catalina:      "f5c95d5a34cbeeae2cea6aa5fc5c4b5e5a398e9c07ebab0f90de68e19d6b4c39"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8b340dab4859e8174546fea45a16f2dcc8d485d6a875e01dcd0702e8d97d5b26"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
