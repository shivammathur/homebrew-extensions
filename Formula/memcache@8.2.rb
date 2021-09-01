# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcache Extension
class MemcacheAT82 < AbstractPhpExtension
  init
  desc "Memcache PHP extension"
  homepage "https://github.com/websupport-sk/pecl-memcache"
  url "https://pecl.php.net/get/memcache-8.0.tgz"
  sha256 "defe33e6f7831d82b7283b95e14a531070531acbf21278f3f0d7050505cf3395"
  head "https://github.com/websupport-sk/pecl-memcache.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "e8e11185aa45b690be41e26c62c48cedcee762e64bb5eb5338210cc1dcd77937"
    sha256 cellar: :any_skip_relocation, big_sur:       "ef70099f953578fcd957b067cf3477e1b622546b4c6953ea51eec7725fe80efd"
    sha256 cellar: :any_skip_relocation, catalina:      "09fa86b07dd8e8a4fa8043b4f359111c70341ea9eff2b5c7120414ce146124c2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "295a5f50113b23fe7edf41a73c8e37529edb7640901f3fcc3fb76f9d28e6f684"
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
