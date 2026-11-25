# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT87 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://github.com/php-amqp/php-amqp/archive/refs/tags/v2.2.0.tar.gz"
  sha256 "0fc9a23b54010a9ba475a1988d590b578942dbdf14c19508fd47dd09e852ab0f"
  revision 3
  head "https://github.com/php-amqp/php-amqp.git", branch: "latest"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/amqp/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    manifest_sha256 "6c913e659d3158a2bc0a0446f39e173060e45eb0b2a03b71f75ac001212a73e8"
    sha256 cellar: :any, arm64_golden_gate: "d330c44019edf94eea2fd9f9224aa7772f49d9bc0e8de00b7753ec0eebee42ae"
    sha256 cellar: :any, arm64_tahoe:       "7c3493e7bb75ac2c6406f754965b9af98bd35ed8ecd685faeb29be62eabc2b3e"
    sha256 cellar: :any, arm64_sequoia:     "bdba83922fcc32ad815fce7784f0c5aa9c21929510d28428583b95840734e8fd"
    sha256 cellar: :any, arm64_linux:       "66a28f62c0ce69936ba135426797e02aadb00739b6f89849a633412ea49fde0a"
    sha256 cellar: :any, x86_64_linux:      "2536f8ab8c120b60a3da47d8251f4802de88c2285b40487df9b2fac789fa8fc0"
  end

  depends_on "rabbitmq-c"

  def install
    args = %W[
      --with-amqp=shared
      --with-librabbitmq-dir=#{Utils::Path.formula_opt_prefix("rabbitmq-c")}
    ]
    inreplace %w[
      amqp_channel.c
      amqp_connection.c
      php_amqp.h
    ], "XtOffsetOf", "offsetof"
    # PHP 8.7 removed ZEND_RETURN_VALUE; arginfo uses 0 for return-by-value.
    inreplace %w[
      amqp_basic_properties.c
      amqp_channel.c
      amqp_connection.c
      amqp_decimal.c
      amqp_envelope.c
      amqp_exchange.c
      amqp_queue.c
      amqp_timestamp.c
      amqp_value.c
    ], "ZEND_RETURN_VALUE", "0"
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
