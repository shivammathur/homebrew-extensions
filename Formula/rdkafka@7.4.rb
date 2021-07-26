# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT74 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-5.0.0.tgz"
  sha256 "432fbaae43dcce177115b0e172ece65132cc3d45d86741da85e0c1864878157b"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256                               arm64_big_sur: "8a59408e99cfd0b9c792c56f2add2cd17ae4af142f13c8e351a067808d860701"
    sha256                               big_sur:       "ffda785d9c29f1e322895f9f55b3d1af0eb1994c465f08cfe6ebc801d91664bd"
    sha256                               catalina:      "cc587517ec9aec45d1671f3e0bc5e11dd6fafbeb5e59ec34f7f580734fd2b451"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5a741d09d06aa2cf39340c033c76375283d5ccfb0894a41a3db0bd4595147662"
  end

  depends_on "librdkafka"

  def install
    Dir.chdir "rdkafka-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-rdkafka=#{Formula["librdkafka"].opt_prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
