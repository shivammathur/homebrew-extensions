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
    rebuild 4
    sha256 cellar: :any,                 arm64_sequoia: "6af0ff733858fa8f5e9ec62e45d0c1ad6f879d39c18a82a08cecc575f9319780"
    sha256 cellar: :any,                 arm64_sonoma:  "748cba70e5ab5e4bf117ca9fe0a55e1f05992200566f5f40eec5582cbc358d1f"
    sha256 cellar: :any,                 arm64_ventura: "658bba0ce8de91c03c05907442545ab90eadfc120584110e33acb371268c2af6"
    sha256 cellar: :any,                 ventura:       "df48f13118ae5a8ca3c5299e8c1bdcaf4a3d5dafef21c79ecb7eee75c6138d1b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1f55d121ca65071796bb7dd8c57ccbbe9ac9dd78d7a422c30682693b109a4a8a"
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
