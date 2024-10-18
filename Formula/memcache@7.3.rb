# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcache Extension
class MemcacheAT73 < AbstractPhpExtension
  init
  desc "Memcache PHP extension"
  homepage "https://github.com/websupport-sk/pecl-memcache"
  url "https://pecl.php.net/get/memcache-4.0.5.2.tgz"
  sha256 "7b7667813baea003671f174bbec849e43ff235a8ea4ab7e36c3a0380c2a9ed63"
  head "https://github.com/websupport-sk/pecl-memcache.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "1ec3fb26bf95ec5f6124cb70380466c336095a816fab498581b3d5a824b616a9"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "1e39d9b2face840e6cc2f1f840b05f329642fd0517bb23ed88dedf3ace1fe532"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "739671b51d3555fbd4293e9fe04c67498111bc5e4a44103a933235bdeb9383b9"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "ec185b645c3c5b5197784cadd6e10796b47a1d7fc3300cf71652746c9afec79e"
    sha256 cellar: :any_skip_relocation, ventura:        "bc84a3c6e261a4c4e3c65800827bee1b71f0ebe05d7068e30f5284ad751743ad"
    sha256 cellar: :any_skip_relocation, big_sur:        "4ea2ed416c4e7986948946d69e06d7dcace83b6262224716cee78e55dcc22e5e"
    sha256 cellar: :any_skip_relocation, catalina:       "9cd96f363b7748e9616c12caa85247c1faff4502aa9eb20e1c364c1e7bd70737"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "456a04eaf5ce8e5ca29f0422af1093606dc32edf94bc27476a65d7f57f8046f4"
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
