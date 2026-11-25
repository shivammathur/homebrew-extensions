# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT87 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.3.0.tgz"
  sha256 "bc8404807a3a4dc896b310af21a7f8063aa238424ff77f27eb6ffa88b5874b8a"
  revision 3
  head "https://github.com/php/pecl-file_formats-yaml.git", branch: "php7"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/yaml/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    manifest_sha256 "e42a64a5dd99455829a778e07f29339f13176ee1e0fbdf7535ea9fbef204ec2e"
    sha256 cellar: :any, arm64_golden_gate: "c06ef5ea811bd68e1c6bd89e483109284169fe62aa8d98391ff6f8e02ffc7170"
    sha256 cellar: :any, arm64_tahoe:       "ac36e61d0d4def8a8f2028efc8e34716e7af545447f3fbeed93d99004c5dbf01"
    sha256 cellar: :any, arm64_sequoia:     "02582e127ebc3cbb6101f38c0b0f14532ed8d00657f0d352e6716bfbe1a49710"
    sha256 cellar: :any, arm64_linux:       "fbffd2c565b7b1a1e1a2f4a9b58625d4fb372695f76f237a22fb862e5d27808e"
    sha256 cellar: :any, x86_64_linux:      "6ab30d27ee11dbb9e4b20b37706465f90b60b5959277bc7b1ede6e74824a57cc"
  end

  depends_on "libyaml"

  def install
    args = %W[
      --with-yaml=#{Utils::Path.formula_opt_prefix("libyaml")}
    ]
    Dir.chdir "yaml-#{version}"
    # PHP 8.7 removed ZEND_RETURN_VALUE; arginfo uses 0 for return-by-value.
    inreplace "yaml.c", "ZEND_RETURN_VALUE", "0"
    inreplace "detect.c", "ZEND_ATOL(*lval, buf)", "*lval = ZEND_ATOL(buf)"
    %w[
      yaml.c
      parse.c
    ].each do |f|
      inreplace f, "zval_dtor", "zval_ptr_dtor_nogc"
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
