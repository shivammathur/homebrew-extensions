# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT73 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_big_sur: "581ab11ee640e3a38340c5b6c60d25ae802e1b2cb147db06ebdbf26bac66be66"
    sha256 cellar: :any,                 big_sur:       "f950d2d2b04501f65da873f64309e0393f8670e0a11c7712a2430c9bd9d2dca8"
    sha256 cellar: :any,                 catalina:      "28cf861949d419a75e9995c63234925786700da25973e526dbd2990f639068b7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "df9c61b7a510fcc59d71165f0395564f656323b4a9309c9b7a9491a808444692"
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
