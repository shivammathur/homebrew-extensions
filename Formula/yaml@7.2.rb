# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT72 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.2.4.tgz"
  sha256 "8eb353baf87f15b1b62ac6eb71c8b589685958a1fe8b0e3d22ac59560d0e8913"
  head "https://github.com/php/pecl-file_formats-yaml.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "4ab4b65dfd8da1838a811f111b24ab5fc63366d71e6491c139ea243f484a3ba8"
    sha256 cellar: :any,                 arm64_ventura:  "5ac1df79285a3ba775b638396967cffdabb72d512a1d6e2f53e6048561983596"
    sha256 cellar: :any,                 arm64_monterey: "2551568ece180be434d78d00fae78344367979a086765fe1fa7aed5a02ba9bd3"
    sha256 cellar: :any,                 arm64_big_sur:  "fed1b6bbaa7504f3af7762a6b4be2f0156b9f0cded8fd409a5983b35647ca6c7"
    sha256 cellar: :any,                 ventura:        "965df25856f7fc9fdb46fbc209ccb2e550978f2ef95a9279c2f86412815ccc8b"
    sha256 cellar: :any,                 monterey:       "4db09de02a0533d467233f05baefb98989ada9f02c757ed4a7067697b715149a"
    sha256 cellar: :any,                 big_sur:        "fa60989d2d81414aed56c1e436232194896155308db21b9e02288b944658a8be"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "354735f0da8c9bc5ca0d7fe9816856aec002250b1f0fe43cc99997f8ef646123"
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
