# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcache Extension
class MemcacheAT83 < AbstractPhpExtension
  init
  desc "Memcache PHP extension"
  homepage "https://github.com/websupport-sk/pecl-memcache"
  url "https://pecl.php.net/get/memcache-8.2.tgz"
  sha256 "b3f0640eacdeb9046c6c86a1546d7fb8a4e9f219e5d9a36a287e59b2dd8208e5"
  head "https://github.com/websupport-sk/pecl-memcache.git", branch: "NON_BLOCKING_IO_php8"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "f750f87809e2ec2eb2382c9e43a2f34e410dd4b05490f17d765d3bb73b5bd849"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "c73492f27c8c5028d74374b11ab9aca790ca1c4184a949dd3456215a0b976f6b"
    sha256 cellar: :any_skip_relocation, ventura:        "41670a0d90ef0e1544ee803fd487c1fb1512ec78adf29a7bb676d3163b761817"
    sha256 cellar: :any_skip_relocation, monterey:       "b9871697cc0ff8066b52fc943f786090ee5b6e76d44d8f21a8852476e9ea0c8c"
    sha256 cellar: :any_skip_relocation, big_sur:        "5564dc1a2c7abc3b83c803a6158f5dbe924831e12db25869449215434b34bb8e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0442bb6690c685da177d652b3477ecf17944035986e0b1339656c7183cb0e27e"
  end

  depends_on "zlib"

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
