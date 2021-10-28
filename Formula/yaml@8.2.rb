# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT82 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.2.2.tgz"
  sha256 "119052f0461d57d86f44c252f9c9b2dd743486c701c1a0aba0aebecdd0d8b82a"
  head "https://github.com/php/pecl-file_formats-yaml.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "673f81188d54855b7ce81bce6f414ec9a66c426318a70a28ae5c53268b03b3e3"
    sha256 cellar: :any,                 big_sur:       "b38f41f4a3d40f0d68d7cbd47224cbfac7383719c4f051bd34f88e8b8fafc87a"
    sha256 cellar: :any,                 catalina:      "e4ef2c08e8731fc951b17cd0e462e4bbb97a8fdf14940d939afd8879025534cb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5c2f3318220f2d5c0cf547db1d3195e82f40e9294dd1c83c93982f08a2a5c901"
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
