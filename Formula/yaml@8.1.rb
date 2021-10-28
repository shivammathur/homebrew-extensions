# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT81 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.2.2.tgz"
  sha256 "119052f0461d57d86f44c252f9c9b2dd743486c701c1a0aba0aebecdd0d8b82a"
  head "https://github.com/php/pecl-file_formats-yaml.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_big_sur: "1c9af33385bd20fa3fa26e8ca9934484a2da91f598dedc65dab7a4b85e47111d"
    sha256 cellar: :any,                 big_sur:       "24527b29d04384b3b6bdc7461d3369446e1493168a39656f94539ba97d9d583e"
    sha256 cellar: :any,                 catalina:      "ab8a267b710942dbdfe7b4b4c879acde22379b02ff46711d09dc3ecda460baac"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2840fb9736bf5fac7c9f5a936f355b1e3f99994e727df7b0650dee691316a14b"
  end

  depends_on "libyaml"

  def install
    args = %W[
      --with-yaml=#{Formula["libyaml"].opt_prefix}
    ]
    Dir.chdir "yaml-#{version}"
    inreplace "detect.c", "ZEND_ATOL(*lval, buf)", "*lval = ZEND_ATOL(buf)"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
