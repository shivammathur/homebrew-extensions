# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcache Extension
class MemcacheAT80 < AbstractPhpExtension
  init
  desc "Memcache PHP extension"
  homepage "https://github.com/websupport-sk/pecl-memcache"
  url "https://pecl.php.net/get/memcache-8.2.tgz"
  sha256 "b3f0640eacdeb9046c6c86a1546d7fb8a4e9f219e5d9a36a287e59b2dd8208e5"
  head "https://github.com/websupport-sk/pecl-memcache.git"
  license "PHP-3.0"

  livecheck do
    url "https://pecl.php.net/rest/r/memcache/allreleases.xml"
    regex(/<v>(\d+\.\d+(?:\.\d+)?(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "9b31d4f0a0ae00e6766b71671829f15cf2c7617d967bc0cb6f87d426bd88317c"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "0b059fa2b72c32bf2802be2b8ca4b47b411e014e31bfa5d051cd1eb9382c031a"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "46bc77609a9cb4b82594873930a008fd7c316778381a723701a54f1cdf9932f1"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "c3c4e4bf2f47c9e685fc355ffae9f800a9c5970ffd3ba6122a48c1f5a7c62a61"
    sha256 cellar: :any_skip_relocation, ventura:        "d07b935da3819c352534d5c762473a7617375ca950fa7114bacf4d334c70377c"
    sha256 cellar: :any_skip_relocation, monterey:       "c2545632fcca168640e6c8f85cd8d198fd4842ef623cc48b7c8469708cd232c5"
    sha256 cellar: :any_skip_relocation, big_sur:        "0af8d969d513693ab72ff730e3c87a0e2abe22fab56d93ff918a561e3b44e804"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "c4d98a8d9399af1633cb78d6a05313d4c7bb3b2642a544d3ffffbdd7e6c3ccfb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "178d6f78ab5446f35bc4f20db4a764e6ce129161d70ca147d3dabc1915e9aec5"
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
