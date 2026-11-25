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
  revision 2
  head "https://github.com/php/pecl-file_formats-yaml.git", branch: "php7"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/yaml/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "3bf682cfcda1dd8442af7bb8b7f9e20fb0ae5d14d040c72701c4a2ed3fa1b520"
    sha256 cellar: :any, arm64_tahoe:       "835ce9e4ca5059d91fef312bfca9a2b0a976d355718f5b1766ff4694658b5c10"
    sha256 cellar: :any, arm64_sequoia:     "83c02ddd848042449c25c824f311f36323eabb942464ef711c3ed7f3c9cb0e03"
    sha256 cellar: :any, arm64_linux:       "2ee8deee27e66f788ec9e1df711a77c77b9c40a19806e220c6f910659fb6bb96"
    sha256 cellar: :any, x86_64_linux:      "a850241901678504a126ee6af5753e7f5e73b0b69ebfc5dff6d135528a6a3ac6"
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
