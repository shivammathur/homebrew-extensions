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
  revision 2
  head "https://github.com/php/pecl-file_formats-yaml.git", branch: "php7"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/yaml/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "3bfbb5cd905c58dea61bfc0c27d72351b70d21603135790e3ed23f4cae32a748"
    sha256 cellar: :any, arm64_tahoe:       "38997b260b386b065d6f25ccc08f0aebac4f283d03e38066d4d7522ac4c9137b"
    sha256 cellar: :any, arm64_sequoia:     "cdbaa952b5d48e03134c7ab6d5b29ab4d97cfd4df1667e3344c9b580ba257755"
    sha256 cellar: :any, arm64_linux:       "4856f720e5f67b0c53b0aa2680fb775932a5321088975a27a34be47face4a941"
    sha256 cellar: :any, x86_64_linux:      "f0ecb2552fa5dff644ed2f361c0728bf51236356ce0509bede52f2a76956bf91"
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
