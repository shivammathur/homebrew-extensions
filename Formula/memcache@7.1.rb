# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcache Extension
class MemcacheAT71 < AbstractPhpExtension
  init
  desc "Memcache PHP extension"
  homepage "https://github.com/websupport-sk/pecl-memcache"
  url "https://pecl.php.net/get/memcache-4.0.5.2.tgz"
  sha256 "7b7667813baea003671f174bbec849e43ff235a8ea4ab7e36c3a0380c2a9ed63"
  head "https://github.com/websupport-sk/pecl-memcache.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "db606c421e241f0bb997f31ffa44f06da5fcc5e2715b2a9cb03cda0c18ee0f62"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "7b091b6f3ee45ee63d3345c19e2e0134ad96cc16142d620c98ace237d1e6f8f7"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "fde5f58842c296564b6a43b85570156b8c085a1cfb6901438d86fa154c8ce3b1"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "8120d09598b41eac7c3753a02f764ffb36c30c4820ee2b3c9186f119dd3ff7f2"
    sha256 cellar: :any_skip_relocation, ventura:        "23c9a01fdc1bd450c8ada53cabdf797d0e48646d13584d0cad41a40cefa7b139"
    sha256 cellar: :any_skip_relocation, big_sur:        "a555be28582c0f89821d5ea1c09b7570f738b5ddef643335ff6a4b7d845c2d6a"
    sha256 cellar: :any_skip_relocation, catalina:       "31d2d6f458e73f4f1584fc58789c28f752e3fa3c57512e97c4e3769f2fe1b5f5"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "a0ded02a2bc092282bf595972c76dec2714eea370b6ec5f1f5296f190f393822"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ffb82adfbb40c49a4630b10f14a36119ca5bc8703165d4af7aea858987b49532"
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
