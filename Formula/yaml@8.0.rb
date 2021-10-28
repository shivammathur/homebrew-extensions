# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT80 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.2.2.tgz"
  sha256 "119052f0461d57d86f44c252f9c9b2dd743486c701c1a0aba0aebecdd0d8b82a"
  head "https://github.com/php/pecl-file_formats-yaml.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "fc033c81261130407c16e653770afaabee6eac5042c50532d06e12466fd12f2e"
    sha256 cellar: :any,                 big_sur:       "fe030db9fe5e20357a566cb2eb7c10d8ff68f080577e5c87519ddca7d6af57b0"
    sha256 cellar: :any,                 catalina:      "7b8fe7118a30590384443b79413fd07b327efbca79e59e0d5ca1c69232b50435"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b61be37cf11e471f0714eb3f6385044e9d44d3bd08704ceaf1c2cfcc6336a7bd"
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
