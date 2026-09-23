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
  head "https://github.com/php/pecl-file_formats-yaml.git", branch: "php7"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/yaml/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "dc1ad08234db9616c955ad4bb851ed726beacb686d38bc94b20fca0037584f97"
    sha256 cellar: :any, arm64_tahoe:       "a02a8dd78a6a9d24ccff7eb87b0b32c1427e8d4a8ab862ee84ea0345e4802da6"
    sha256 cellar: :any, arm64_sequoia:     "8f2390398c78ececd48a3fbcf4f4c33dbe391cda76e122676000dd63ecec4995"
    sha256 cellar: :any, arm64_linux:       "231fa5cf0d1c90e7ab78a329ce092eea0d5a234be3e6e6b45cb81a3753b36ee7"
    sha256 cellar: :any, x86_64_linux:      "32fd4c3961180b527351d08b0e487df5f9ff93e1a9bc6d70e1267a3bacde28f1"
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
