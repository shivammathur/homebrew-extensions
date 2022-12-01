# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT81 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.1.2.tgz"
  sha256 "750712956179f296d68d4d022e223955d1e534ea32672c2d7875f2611920a2b6"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "3b89bc2aecf80c1eb7c19299f60afbeac993c41a8721da35804028c2e10c288f"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "af4ea906a8a85bd3332aeac0802846a31154c2e5d2556968a40cfe9fbefbbeb0"
    sha256 cellar: :any_skip_relocation, monterey:       "ffebd8f5a4a9c3c4afac6de55dd1246d47416848197c7868e38f93a84f210e99"
    sha256 cellar: :any_skip_relocation, big_sur:        "e375eeb6a6d88b2ffe0d17dbec1ef789b96ae977e0d8cbb33924e392f4275078"
    sha256 cellar: :any_skip_relocation, catalina:       "c4ae2ea6e03242011bfa503da71304c186fa63d4929724ca026064f82d8c1505"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0af3b4cab15cd8c64d49a0bad456f9ec9be5e3d405983acf956d4c26757dd4e2"
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
