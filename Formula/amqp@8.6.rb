# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT86 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://github.com/php-amqp/php-amqp/archive/refs/tags/v2.2.0.tar.gz"
  sha256 "0fc9a23b54010a9ba475a1988d590b578942dbdf14c19508fd47dd09e852ab0f"
  head "https://github.com/php-amqp/php-amqp.git", branch: "latest"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/amqp/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_tahoe:   "e8eff67a845c5d717aca7dd6bf75110b3df72e1804838740006e4d53b58b1179"
    sha256 cellar: :any,                 arm64_sequoia: "cabf37e2efb67d228ef8d556a716d1743b32468ca1d32efc51bd831d86b4a0c3"
    sha256 cellar: :any,                 arm64_sonoma:  "15096011845efccaaa3f261adfa0dbadda6a31252572f3efb43f5289d9c835a2"
    sha256 cellar: :any,                 sonoma:        "d0d505ae45b4f814107e3b1c12358d588481b791f5c332af17fc35c10e5c84e0"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9556fec639f5a988d997d4ef2ace52c11b67961438d4e285b9dd89c4df6c7e53"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c26811ac73ee1a39ebde02bc8b8d0c5ac897a93802900efcca96aaf155748a6f"
  end

  depends_on "rabbitmq-c"

  def install
    args = %W[
      --with-amqp=shared
      --with-librabbitmq-dir=#{Formula["rabbitmq-c"].opt_prefix}
    ]
    inreplace %w[
      amqp_channel.c
      amqp_connection.c
      php_amqp.h
    ], "XtOffsetOf", "offsetof"
    %w[amqp_channel.c amqp_connection.c amqp_queue.c].each do |f|
      contents = File.read(f)
      inreplace f do |s|
        s.gsub! "INI_FLT(", "zend_ini_double_literal(" if contents.include?("INI_FLT(")
        s.gsub! "INI_INT(", "zend_ini_long_literal(" if contents.include?("INI_INT(")
        s.gsub! "INI_STR(", "zend_ini_string_literal(" if contents.include?("INI_STR(")
      end
    end
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
