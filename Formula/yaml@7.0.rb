# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT70 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.0.4.tgz"
  sha256 "9786b0386e648f12cc18a038358bd57bee4906e350a2e9ab776d6a5f18fc6680"
  head "https://github.com/php/pecl-file_formats-yaml.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia:  "284089c7a1788c2e4cb6488faa06edc4fea6cad58de4ab61df99b5d7bbcb6667"
    sha256 cellar: :any,                 arm64_ventura:  "8d82351ea87d7c5986398e9bce39a52695095f2c6345abf9224a281123b56d20"
    sha256 cellar: :any,                 arm64_monterey: "e9215339046ecb30bb185cf14e05bdca9f497538e59bd69a05f071a25aa2ab17"
    sha256 cellar: :any,                 arm64_big_sur:  "7dc63852d7b05ccecd1b7421c29114af4b39ccdbdbc015b960c3148e03590ba9"
    sha256 cellar: :any,                 ventura:        "bac5e501e58dab8aec544791874906e4e954943485afe529e85f4648dda589f1"
    sha256 cellar: :any,                 big_sur:        "b73ef6d2a0f3d1095c5de474d07eec9347dadf3dba79126b25f0b18e47b66664"
    sha256 cellar: :any,                 catalina:       "57df8f5421356bf1cd4750e5d771da933807d49a160fdc4085db41b73c36461e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3f42d9b2f483ae926e80d118ba80746fef1133eabc76e4bb2984b5bd3545d6c1"
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
