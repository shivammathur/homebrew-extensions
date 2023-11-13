# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT84 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.2.3.tgz"
  sha256 "5937eb9722ddf6d64626799cfa024598ff2452ea157992e4e67331a253f90236"
  head "https://github.com/php/pecl-file_formats-yaml.git", branch: "php7"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_ventura:  "0bdcc420839f6a3160d18e5b2a63f29408fb434042a54b9857ea62ad83304760"
    sha256 cellar: :any,                 arm64_monterey: "4c44fc4cc767274414f1c61f729b77d4c64d83bb917038e0e5a6fa694a1cc6b1"
    sha256 cellar: :any,                 arm64_big_sur:  "f24528001e8dc497146abd649a3848b340cae10e0d7d29f701510473e22e1809"
    sha256 cellar: :any,                 ventura:        "6ea92da2a3d351c7c7d8bc2e88eb1169136a7441c2c3a4689ac7197a583d39a4"
    sha256 cellar: :any,                 monterey:       "3b01b075172490ef84f83e2cd122782401e2f87176037268002f628bef94e832"
    sha256 cellar: :any,                 big_sur:        "4a5217b8adb58f083fc18c3424ab42560f98e3f9778c2cd3cdaa14228074a52c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "687ce3c23e3d721a6b363efadf6be6327dc48d456d72f80e654f770f51a57ab0"
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
