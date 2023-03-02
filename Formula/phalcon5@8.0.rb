# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT80 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.2.1.tgz"
  sha256 "5ce7d9be892c8ded97f8ac6009a7e3ca2f95550c615f6735a34d5d7c8b736d74"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "53d1bb63380cb8f2e20fdef5bc8ecd62b039dba8c81f755fa2e08dc31239c251"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "cfb3fe9b1e8fd07568de021a052792def719851f5e83fc062c88cdd51e365b83"
    sha256 cellar: :any_skip_relocation, monterey:       "e70c673991c46e5b398bf4a9eeaf115718d309fdafba2e65a8626bb76489a218"
    sha256 cellar: :any_skip_relocation, big_sur:        "a5d98289caa9b2d0a56ee90f35c5ce8ec48a5e532793f99d2be68069e5a5e662"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bd19b4a289dfdb75eddfad253f7f096bf43dbb1bd683bb186dd0a73c17d7ef70"
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
