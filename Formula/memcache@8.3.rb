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
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d345789340e493b61a83cb4dad80424aad14079e40e91f06f6b1e214545ce556"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "b29e2227355e7c5e4c748d2b08d0b49061fffa8cb4b805da6adedab13869da00"
    sha256 cellar: :any_skip_relocation, ventura:        "15e836bad900b6180d74ac4fce6282e72fc46dec90a86307ddb41d90fc05c637"
    sha256 cellar: :any_skip_relocation, monterey:       "fc4ab7aafd0edcf6fc3426d26512dd1203aa23bbad8cab09574d7dd74de5e5fd"
    sha256 cellar: :any_skip_relocation, big_sur:        "8ef0830475e20c1e376d7fb68409d0a693fc74750eb99dee32390f138715b5e4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1c4e92d507dd78de9a8715e8889c9f60c05af3358a304438a7d5da67c171f61c"
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
