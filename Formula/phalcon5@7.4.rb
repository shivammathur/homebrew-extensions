# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT74 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.3.0.tgz"
  sha256 "0de5b87215177d1e3ea30dd5d71d89e128ee012b7ae1ae5bef6275a76659905b"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5310d4eadf7a2c1e84f0469c5c9444bc9b67dca71b45258b196f4a64447e3967"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "f671d9f93201ce46086fe0a9186d1c62721988dffea2311453e92bcfeb6b9d52"
    sha256 cellar: :any_skip_relocation, ventura:        "ade2a71e6deb5c0941ea29dfff7c625c8f85e41f931780e922136a8a2e24566a"
    sha256 cellar: :any_skip_relocation, monterey:       "f7c2af4c61fa134efc3b18b162fdd3f46524c803808f6217375c117b47d26425"
    sha256 cellar: :any_skip_relocation, big_sur:        "a3a6d0ac404fd0ebab5d2a28f4b2c67b82f4f1696703625a97f011e4461e870a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6a43ae26058fa25c31ff103f7cbb179205aa19295d6c12df0fe321f824dbbf3e"
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
