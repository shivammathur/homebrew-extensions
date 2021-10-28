# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT71 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.2.2.tgz"
  sha256 "119052f0461d57d86f44c252f9c9b2dd743486c701c1a0aba0aebecdd0d8b82a"
  head "https://github.com/php/pecl-file_formats-yaml.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "513f16f6dc95b565453efc51ba083d1dfbe5c2673cc515085b59fb657c5e8ff8"
    sha256 cellar: :any,                 big_sur:       "17b45b4fb4d66bfc0830cb4b5eef5f90d70d61b3484f35e231353b4bb2127510"
    sha256 cellar: :any,                 catalina:      "f89cc7476ef7316267b2319142cad3208d092d638710cb8a9303e57ebea739bf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f09f243efd9fc0a5c035266165ebf5ce090f950c9a04cb270be152cb8b17eaa1"
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
