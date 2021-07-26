# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcache Extension
class MemcacheAT70 < AbstractPhpExtension
  init
  desc "Memcache PHP extension"
  homepage "https://github.com/websupport-sk/pecl-memcache"
  url "https://pecl.php.net/get/memcache-4.0.5.2.tgz"
  sha256 "7b7667813baea003671f174bbec849e43ff235a8ea4ab7e36c3a0380c2a9ed63"
  head "https://github.com/websupport-sk/pecl-memcache.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "83fa3d467bf1da7661c38acb307872c33a5224bb8ffb4865341a7f485b406512"
    sha256 cellar: :any_skip_relocation, big_sur:       "9d532ac5a58e4b5841ce66c2c241b5aa7d6efcf1668f96a694e084751ce07bfb"
    sha256 cellar: :any_skip_relocation, catalina:      "be807879f7b332829e6e4a7c1c995f30b9e6867b2853638cd0e7818a140eefe4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cde95ce57b5b4063af5c6a0a13710d84a07a2c4f387c87f91d3852d96eb7c355"
  end

  def install
    args = %W[
      --enable-memcache
      --with-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    Dir.chdir "memcache-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
