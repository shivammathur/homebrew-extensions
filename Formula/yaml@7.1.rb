# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT71 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.2.3.tgz"
  sha256 "5937eb9722ddf6d64626799cfa024598ff2452ea157992e4e67331a253f90236"
  head "https://github.com/php/pecl-file_formats-yaml.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "0870b56c31359791b5e3be5dacddbd8235374ba738749e90dd1b5ffedb5869b3"
    sha256 cellar: :any,                 arm64_ventura:  "6a6e2257d41a7a000c4172c378c060f02511b1c03892e82b8ad4919615eee14a"
    sha256 cellar: :any,                 arm64_monterey: "4383356fe10be74fee619f66db6cec7d1ee5133e3ad28a8d75dbee1e75bec74e"
    sha256 cellar: :any,                 arm64_big_sur:  "a6b4a833d94b5c36aac527c89dda41aedc3816fbce298c5f6199757f25b2851c"
    sha256 cellar: :any,                 ventura:        "cde2ef9c9ae8db5efe4b43593a6814fa772708d8d9c0b57788577b883a0ce066"
    sha256 cellar: :any,                 monterey:       "f38f9e224d805471f374395ab1bcc16c365848f2ca5b0bf970223bba44d5741f"
    sha256 cellar: :any,                 big_sur:        "d6d72fd6588c830cba8c5883bf7ae85a039ee6db25845351c08b8763a1933de5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "80191f4d9ded0fba5b171a471b7df046b3311bce85bc103b8621ec7b55cc462a"
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
