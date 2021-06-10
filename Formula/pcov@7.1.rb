# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT71 < AbstractPhpExtension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.9.tar.gz"
  sha256 "c4c2a1de8e546c00eab8bd2a666028c25d16b8d76829e43280b742ae60e78f85"
  head "https://github.com/krakjoe/pcov.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "439d42eb679a33177f66284ebda70880ea2e151d57b206bad77fbca97bb14430"
    sha256 cellar: :any_skip_relocation, big_sur:       "3882f433cc24cc35652778b207070774e6c639d85bf5f1538313e88bc27b1e26"
    sha256 cellar: :any_skip_relocation, catalina:      "990cc48070369bb22e45121f906f2f42452cb68f338878a70906f2d212522ca1"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
