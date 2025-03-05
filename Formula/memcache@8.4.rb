# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcache Extension
class MemcacheAT84 < AbstractPhpExtension
  init
  desc "Memcache PHP extension"
  homepage "https://github.com/websupport-sk/pecl-memcache"
  url "https://pecl.php.net/get/memcache-8.2.tgz"
  sha256 "b3f0640eacdeb9046c6c86a1546d7fb8a4e9f219e5d9a36a287e59b2dd8208e5"
  head "https://github.com/websupport-sk/pecl-memcache.git", branch: "main"
  license "PHP-3.0"

  livecheck do
    url "https://pecl.php.net/rest/r/memcache/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_sequoia: "f0875131c1cd1c3245f4a47181caaf7a7beb7d822523f54040f78654d79ea88f"
    sha256 cellar: :any,                 arm64_sonoma:  "fd813f43c3935d01630481092ec92994d8de3b0c3e56f4539782f93f70366cd0"
    sha256 cellar: :any,                 arm64_ventura: "da193238a55c9b292355a66f5db0112760f324cc813603e2589760dcf81ff7d9"
    sha256 cellar: :any,                 ventura:       "e60cdaafd98ef6638d131ebd0d80fddeabce201031b12746099164cc5c28cc39"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "36a8851dff3e88ca55929f297ad63ac2e1cb5266b2366b6316d7c09441ff2dd8"
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
