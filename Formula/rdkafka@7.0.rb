# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT70 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.2.tgz"
  sha256 "faaf617f1cae0e85430306e078197313fc65615c156ff16fc7fc3b92de301ef5"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "bc89831a16e0c38a3da90567a5bc90e6a01d1cb0590cef6895b680830a36c4df"
    sha256 cellar: :any,                 big_sur:       "ffc4360854a314e68f9b53549fe5b05a50dd5c4d4a82e0ffe9a006c9da131f9b"
    sha256 cellar: :any,                 catalina:      "191506cd0ff7b1aebec39542a7dd16c087be441923d7cf752aaa3db0d5c172a1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "30ecf8238277b49cb3aef26fcda5d9da359c8a23b45be94570bf36890810178c"
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
