# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT73 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "2eeb4e994198dd31bef621aec4c8cb8d1b7286ba867e13fb8d742a484ef6c157"
    sha256 cellar: :any,                 big_sur:       "560d0c16331eb63ff4f051056d1941ef0d1816ce71e0fb7c7908ed3234a9b6f1"
    sha256 cellar: :any,                 catalina:      "099a1af0e219ac07a94dd96765a86d84de96f09299a404c07c721250126ef4c6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d41c0bf061d81611cb4894106a16be7c3c72ecd4cd51589cb944737efb428ede"
  end

  depends_on "vips"

  def install
    args = %W[
      --with-vips=#{Formula["vips"].opt_prefix}
    ]
    Dir.chdir "vips-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
