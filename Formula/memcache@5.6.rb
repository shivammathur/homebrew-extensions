# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcache Extension
class MemcacheAT56 < AbstractPhpExtension
  init
  desc "Memcache PHP extension"
  homepage "https://github.com/websupport-sk/pecl-memcache"
  url "https://pecl.php.net/get/memcache-3.0.8.tgz"
  sha256 "2cae5b423ffbfd33a259829849f6000d4db018debe3e29ecf3056f06642e8311"
  head "https://github.com/websupport-sk/pecl-memcache.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "3d74547906bfd7da2f66a17c043417e31662b277ed33340b0a88018f269e18d9"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "62603658e7f3ec636ffb3eead60e6299a234d9f189d6c9853bd21dca78e9be6b"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "84ac4b3beafe6513e2d90b239ecce858b01857db44c120e0c6fd5dcd746ec29c"
    sha256 cellar: :any_skip_relocation, ventura:        "e3576b0de124c66f724ce948fadf4012eeaf86ed32f47c5f59a2d5f0721977cf"
    sha256 cellar: :any_skip_relocation, monterey:       "ec643649d9a3c59d9491e10fb45d356de4408f3bb9e5913c2e24df745c8de92e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "44e8d77a591b71576970caa76319d86eb52606e68b6ceebd621db3523a9a3b61"
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
