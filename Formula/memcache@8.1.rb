# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcache Extension
class MemcacheAT81 < AbstractPhpExtension
  init
  desc "Memcache PHP extension"
  homepage "https://github.com/websupport-sk/pecl-memcache"
  url "https://pecl.php.net/get/memcache-8.2.tgz"
  sha256 "b3f0640eacdeb9046c6c86a1546d7fb8a4e9f219e5d9a36a287e59b2dd8208e5"
  head "https://github.com/websupport-sk/pecl-memcache.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "7134dac59448d61e71ed8e8c44d46acb36f748be5bc6a3c879cd88245a23d637"
    sha256 cellar: :any_skip_relocation, ventura:       "59ab1a4bb7469402c4a35e3d70b360839d992d3ae52a94d383275ef9ecf2d8f1"
    sha256 cellar: :any_skip_relocation, big_sur:       "e023a8cda60ad48c7c59f568c69aa76e3ea9d6f6d04c2f76a9064f7dc63fb0b6"
    sha256 cellar: :any_skip_relocation, catalina:      "501e8b4d780a4019597925108e804d670e7aa5ad5172e552b2017046995761ed"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ed42afb5c167e9c173899e0ab462a63d28dedf1cf653e1932502b9af27e68779"
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
