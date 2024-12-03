# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT81 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.2.4.tgz"
  sha256 "8eb353baf87f15b1b62ac6eb71c8b589685958a1fe8b0e3d22ac59560d0e8913"
  head "https://github.com/php/pecl-file_formats-yaml.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "da44329fe1e3a9b8a1ebad4b2698488e102544a944febf82841ecf00088bd712"
    sha256 cellar: :any,                 arm64_ventura:  "f490c3c7fcc371de249767943e4d749c918b229b9246e45e937d2fa4ff8d79eb"
    sha256 cellar: :any,                 arm64_monterey: "41758b48678d755df596097ba4e78fdee605aefb0b6f7334542ea8fb5b35fa88"
    sha256 cellar: :any,                 arm64_big_sur:  "07f967d8342db49aeeadbc9572f7aecd66b69cd682d88b0b08e1bb1fc4ea9237"
    sha256 cellar: :any,                 ventura:        "4b9b976e2217091a27b3f4ce150072098d6154866c4680308c9e50236c1bdeef"
    sha256 cellar: :any,                 monterey:       "9ebd71cb12774d47695564162362c1c06c43153715a70fd29ea2a54d191c9a3a"
    sha256 cellar: :any,                 big_sur:        "73db7719068c8faa239db861526ee23deb5d37ceebe965e2e75b4d0f5bb664bc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "316197e6e3aa4d4e96da052f364ec07eb7d6c78ddba9d553fd72f5e5e896f04a"
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
