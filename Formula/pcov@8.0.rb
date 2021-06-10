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
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "d97d5ad6d9f427bc7c11659a25ec506aee1b2069d1028a97223f2a95d84644f9"
    sha256 cellar: :any_skip_relocation, big_sur:       "e34ec459d634f728ddc4137a4a068a03acf4065b66b6790170f81da1135f882d"
    sha256 cellar: :any_skip_relocation, catalina:      "f309420695d8d03421b3926294531c9e2d0b24dbd6661118a6e79d5a66d6ae54"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
