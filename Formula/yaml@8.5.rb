# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT85 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.2.5.tgz"
  sha256 "0c751b489749fbf02071d5b0c6bfeb26c4b863c668ef89711ecf9507391bdf71"
  head "https://github.com/php/pecl-file_formats-yaml.git", branch: "php7"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/yaml/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "8ccbaee3c950e1a521dfde6714e8b44083abed1e4c5f5824f095350758380af0"
    sha256 cellar: :any,                 arm64_sonoma:  "2657b2c10ae49e5d4b3192aa9fb41d4fb0d12ff319774d2900f446889ce1d6b1"
    sha256 cellar: :any,                 arm64_ventura: "1c7848a058e59fb7a2ddf46ae6396d52cf2575c44f01e298fedd108da09e1c5b"
    sha256 cellar: :any,                 ventura:       "14ea02b27f3a591efd6ff965d6cdbfb420fb4bf9e740ce809965d9ab5472c2cd"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4481902e0878172d4f4314c81b9bf328299ef25c39f1f209171599afacd0ef82"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9447017960b9125f9501dddc9c168b3103881ced8b0c7a80f96f3629191e135a"
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
