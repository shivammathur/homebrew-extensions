# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT82 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://github.com/shivammathur/apcu/archive/90279ca8fe062a8c595ceebac339a3e4c9a3ebab.tar.gz"
  sha256 "b0e3b1ede3fdc98d56d40952600405bb69ba23f3d39c2a6821af8be09b6110eb"
  version "5.1.20"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "3b34deb7efed95a9ab33234dcf8c7d7bd66b4eefbcdde3d9ddb63da1166b61f9"
    sha256 cellar: :any_skip_relocation, big_sur:       "2122d8f1612f663a7f17d0e8f49f05dab4c15fba2e6745252321be927b6ffaf3"
    sha256 cellar: :any_skip_relocation, catalina:      "a64f6cf9dcde52181ac527acec7d47c4a10df5b3fa01e16bb842adb8b2b15ed3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "50c4f23d2ae3fcce387c2512b9e3519fdbc75e86fd92635944e8da767b838ecd"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
