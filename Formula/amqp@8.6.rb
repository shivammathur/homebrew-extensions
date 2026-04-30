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
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "e032630b58cbd049396f8d9d9d0d37f594091777b34c9802d4eae35a3ee3207d"
    sha256 cellar: :any,                 arm64_sequoia: "39ecc21a04c4463b5779398ea659d066214d31ccfea01c0931f586230a410b68"
    sha256 cellar: :any,                 arm64_sonoma:  "e82df556e75570b93a21488b332fa08f565e1ae614c522fbbe5a854deee9c1aa"
    sha256 cellar: :any,                 sonoma:        "abb583c29e295d21dc693682069d8e70337417778620c03d501c8eeb2b74862f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e9215d75d5237bd057af6d0990c370e47e5db0dd945209aa8d1afb566ae7c6f0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2a467b5234fc54ea881d200588d22d9679528eb3262be20f07fb1dd4921511ac"
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
