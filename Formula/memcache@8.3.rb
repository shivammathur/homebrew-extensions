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
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "7f5795fda3d67f2cae3f5aba3a2494a37f41bf3ca64685cbdea1dc1d3f0bc755"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "df78635eee57c7a040c594b850e3bd206f900c63badef47276ccb04c2639e7cf"
    sha256 cellar: :any_skip_relocation, ventura:        "31a5cc77fa49e0cdd3b1812c2b709fb644501fe363af2c84ceeef1a9bac37cbc"
    sha256 cellar: :any_skip_relocation, monterey:       "8073cbff78c27cbd3cf10f67b7c59706c1f2a77f9a4aeb391aaac5efc1c2a2c6"
    sha256 cellar: :any_skip_relocation, big_sur:        "f85575ddbca5656c8066c19dacfb5b9c92dc0e8998920ab296b58b4406eb971d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "702b40ef44296d740e9d11a65676c36594eef62187dab839d3b01704dedc63a4"
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
