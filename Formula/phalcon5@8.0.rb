# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT80 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.8.0.tgz"
  sha256 "d80b137763b790854c36555600a23b1aa054747efd0f29d8e1a0f0c5fa77f476"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "a7b12e987ad0d59c9c5e2c2f391522bf57e6dd5c6ee3d3cc05789cd5e73273cd"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "0561887492c090e250e5fb1587395ca4ff296d5785d74666b7fa4e165410696b"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "6b020c84d7b198bb64e8811261e6e8589d8f8a7cd842d02c520406c35a46b91d"
    sha256 cellar: :any_skip_relocation, ventura:        "b3877353ff28f7f54126a23c850f5d5ef3788eee51ac59c4752667eb5aa44f98"
    sha256 cellar: :any_skip_relocation, monterey:       "8bd61b4debb1ef82512b3d7e4e43a9bd008662afda4794df13be2dac392dc8c6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "63438f9c770e85af817b75640af566b5be1a6c17f50b797ab1059a4ae8876831"
  end

  depends_on "pcre"

  def install
    Dir.chdir "phalcon-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
