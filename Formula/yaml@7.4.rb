# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT74 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.2.2.tgz"
  sha256 "119052f0461d57d86f44c252f9c9b2dd743486c701c1a0aba0aebecdd0d8b82a"
  head "https://github.com/php/pecl-file_formats-yaml.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "f2db1a6fa92296ded5835dcf4c17aaf7abf07f3e6fb20e3ac31747d352eafd66"
    sha256 cellar: :any,                 big_sur:       "fbc69185219e7f0ebbf6aad5b2ce4b9ffd3fe0a3857e5ca18cf34260609bbcf3"
    sha256 cellar: :any,                 catalina:      "a8f314545b03034c3253dcf58d581b1669af17e74c30fb2fcd781730845c14bf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0776e8ac0955f7303ff0a907931c6c7e1016bf72b48b506e8d1017ceddae1458"
  end

  depends_on "libyaml"

  def install
    args = %W[
      --with-yaml=#{Formula["libyaml"].opt_prefix}
    ]
    Dir.chdir "yaml-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
