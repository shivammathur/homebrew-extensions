# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT86 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "e956ae601e2aebbe7d07d1660ee0c93978609c0d4f9e1160b45170cdc5393727"
    sha256 cellar: :any, arm64_tahoe:       "dad2c7cdba03e21bc4e5708b85067d81a8fd3c7afcdbfddf1f4e1fc7fb44d3b2"
    sha256 cellar: :any, arm64_sequoia:     "04845d4cf58185f428f3d3291451499d3ca8e9383362f7ba3b57ee72ead776c6"
    sha256 cellar: :any, arm64_linux:       "42081ea9118121a12e5756ee9a6c7caa6efcd2d48125d32c6600ebb70ef21405"
    sha256 cellar: :any, x86_64_linux:      "03e9ac95b26c11f1811316d0944feb66c4d4d7cf296bdaff4d2fa37c4ce83838"
  end

  depends_on "libyaml"

  def install
    args = %W[
      --with-yaml=#{Utils::Path.formula_opt_prefix("libyaml")}
    ]
    Dir.chdir "yaml-#{version}"
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
