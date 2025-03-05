# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcache Extension
class MemcacheAT82 < AbstractPhpExtension
  init
  desc "Memcache PHP extension"
  homepage "https://github.com/websupport-sk/pecl-memcache"
  url "https://pecl.php.net/get/memcache-8.2.tgz"
  sha256 "b3f0640eacdeb9046c6c86a1546d7fb8a4e9f219e5d9a36a287e59b2dd8208e5"
  head "https://github.com/websupport-sk/pecl-memcache.git"
  license "PHP-3.0"

  livecheck do
    url "https://pecl.php.net/rest/r/memcache/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "033d7ef50931f510ad6396740031d21222b411d257fb73f54216a6dc51bcc5ac"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "f54cb2ace908644a8010b1ecc63d351a40c1fc5fac872d22d11513c9f84d96e7"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b9de9e68b168c812ea09d38112c0f677e3e294abb89ed0b09ed4124aadd5a13d"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "380063e228ef7f9d7e57d3bb5deeb1c6f33dfa81d087a7bd8efe9a38d11682f4"
    sha256 cellar: :any_skip_relocation, ventura:        "9672ce71d7a23fbb2bbd72ce4d48bd5f2eaacbc48049663a76ac1cada8e4da03"
    sha256 cellar: :any_skip_relocation, monterey:       "63bf2c48ce0de19591ac24eb6d10057e5bd05101a12a103300c59550ca3fa048"
    sha256 cellar: :any_skip_relocation, big_sur:        "8730adcd0c325ad0d0a829cc2b94f1f7bd48ccc7ed78acce35c5915372488033"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "12461dff9d7ed4bef6d78678d1557a3000171f4b4b13c74b1bbaf2904fc89aa2"
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
