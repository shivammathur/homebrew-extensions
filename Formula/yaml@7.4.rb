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
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "184cf065f25860e570432b9955474cc48dd702ecb1024743ab37e44bc768b7d3"
    sha256 cellar: :any,                 big_sur:       "334638eaef4b9e0db86d2a7c1189b87899f14735567bf9c135a3cb5d7d5828ca"
    sha256 cellar: :any,                 catalina:      "0526f0929dd0613b4d026cf735b43c94c83c6b6981d640810961b58d956ed0b2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1ba387e9701dee7aebf4af852adf15d060eda92b56f1c6eb61bb59bd324d69b9"
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
