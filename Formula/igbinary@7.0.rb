# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT70 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.6.tar.gz"
  sha256 "87cf65d8a003a3f972c0da08f9aec65b2bf3cb0dc8ac8b8cbd9524d581661250"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "c34e454f372a00ef61be7859b0f0428baccaabe24686c5d8873bb608c5bb77c6"
    sha256 cellar: :any_skip_relocation, big_sur:       "0813e446741342c6011f52299bbe85d289af70075b6d2e956e56b0a9e6161798"
    sha256 cellar: :any_skip_relocation, catalina:      "5dd965aa96fe28a3e594a054a49fdec7a23f6931eacd21ddd97bb81d85767bfc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7318b09c907116406e37e13a2e2117531c55ef15bb1c834cdc50d19913389fc9"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
