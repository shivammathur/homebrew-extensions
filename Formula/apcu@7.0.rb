# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT70 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.21.tgz"
  sha256 "1033530448696ee7cadec85050f6df5135fb1330072ef2a74569392acfecfbc1"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "1da2b7fc3d3f4a5e5cb8052b71ff5de824341dc8898ee4950c1e6abc778c9ac3"
    sha256 cellar: :any_skip_relocation, big_sur:       "594ff5a2fcfab02007285e857712fe9b43663a91a15afdd956fb4cd2536ad641"
    sha256 cellar: :any_skip_relocation, catalina:      "610d2d5fda73c7be0b07dd919ae8fbc26d61d898e81b313b19549c0d97f66396"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3d55a10acc47e0d2fd8f485e98b5d590f2a9d1ed972b82c42139f65670915ee8"
  end

  def install
    Dir.chdir "apcu-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
