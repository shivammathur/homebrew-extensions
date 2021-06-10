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
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "fa33162174a8e439675a3edfae362306fbc30334928e43b233a7c4f5b6a3b3b9"
    sha256 cellar: :any_skip_relocation, big_sur:       "6cfc4af29c11d404ee90f169785b46620e5aa4b641719f3e50dbb0d99e63b0fa"
    sha256 cellar: :any_skip_relocation, catalina:      "dbd400b6413e37eaa29166c889ee66dcf83f70a40efa8f5da0d6a261a4b3f11a"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
