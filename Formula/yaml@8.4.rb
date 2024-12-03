# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT84 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.2.4.tgz"
  sha256 "8eb353baf87f15b1b62ac6eb71c8b589685958a1fe8b0e3d22ac59560d0e8913"
  head "https://github.com/php/pecl-file_formats-yaml.git", branch: "php7"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "68bdb2fc92587e753739e4eeb8e093589081fee6e677487e386dfb17969b73ef"
    sha256 cellar: :any,                 arm64_sonoma:  "32fa284df5b93c0060bb4cd5d3195d9c8dc6002cd8d9db7fa2973f1a59c72368"
    sha256 cellar: :any,                 arm64_ventura: "855b928ee5f9c404106e4f56ac96ef4a9c92dab6a25ddd29455526d5cae45c61"
    sha256 cellar: :any,                 ventura:       "9ca62c4b948de7c1417bacbd16f180e26ae78ced8607adcc7075b4fc4186bdf9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8a022102458b20d65c523cf699fd39b49b81193f73bad36a94089387b0d369b3"
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
