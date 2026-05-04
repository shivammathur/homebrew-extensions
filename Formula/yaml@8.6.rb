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
  revision 1
  head "https://github.com/php/pecl-file_formats-yaml.git", branch: "php7"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/yaml/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "2661eb54335f228a4a49399d861c9e35bbf30e4bfd3b5e8699398aa5b6e0a7c6"
    sha256 cellar: :any,                 arm64_sequoia: "ce2813170cee519eb7c5f5c25681a3e90b39cc5991c90ef2915e4e884542e06d"
    sha256 cellar: :any,                 arm64_sonoma:  "c61dab36a43edc608d99029991c559599fd544d7f16321b3fe023875f8aaed60"
    sha256 cellar: :any,                 sonoma:        "4b37b91fda0a96755fd1ca103503f396c75e3130a333717ddf46ceb7b76b17ed"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e262b2e22b12a7e9cdb0516d6ff5e3b9716c5ff60fc5128d3310e623f470caaa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "63dc25221a3f9dada7efed7f991276031e1fa208d578c7998470f359bd87cf6a"
  end

  depends_on "libyaml"

  def install
    args = %W[
      --with-yaml=#{Formula["libyaml"].opt_prefix}
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
