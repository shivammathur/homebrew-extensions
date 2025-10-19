# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcache Extension
class MemcacheAT70 < AbstractPhpExtension
  init
  desc "Memcache PHP extension"
  homepage "https://github.com/websupport-sk/pecl-memcache"
  url "https://pecl.php.net/get/memcache-4.0.5.2.tgz"
  sha256 "7b7667813baea003671f174bbec849e43ff235a8ea4ab7e36c3a0380c2a9ed63"
  head "https://github.com/websupport-sk/pecl-memcache.git", branch: "main"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "4884ee2a245854137991cc35a058c96c464674a1f5f2cb8b7530839df123db7b"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "601a297d88d76c730479cc86644c43b9683bcf4ffb1e4ed6d34b511b7e960668"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a595a0c49003e5e8f8e0df9b99f49df046e7ff1a06604f90cb26365c9523ff83"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "83fa3d467bf1da7661c38acb307872c33a5224bb8ffb4865341a7f485b406512"
    sha256 cellar: :any,                 sonoma:         "a6e34dd2a78fc764460051b58a5998783a6f31177e165e4409d6fe2ede450d07"
    sha256 cellar: :any_skip_relocation, ventura:        "257ca93a5a940b7ec6fbd528462076acfd8c7995fa9b3f7b1983af6dcdabc832"
    sha256 cellar: :any_skip_relocation, big_sur:        "9d532ac5a58e4b5841ce66c2c241b5aa7d6efcf1668f96a694e084751ce07bfb"
    sha256 cellar: :any_skip_relocation, catalina:       "be807879f7b332829e6e4a7c1c995f30b9e6867b2853638cd0e7818a140eefe4"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "3958f592901430e456a3c2fb950dc5fac1dc03391a1ef625f8d0533749387262"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cde95ce57b5b4063af5c6a0a13710d84a07a2c4f387c87f91d3852d96eb7c355"
  end

  depends_on "zlib"

  def install
    args = %W[
      --enable-memcache
      --with-zlib-dir=#{Formula["zlib"].opt_prefix}
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
