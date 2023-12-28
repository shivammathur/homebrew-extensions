# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT80 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.5.0.tgz"
  sha256 "cb68e8c4d082b0e3c4d0ee3d108d68dbc93880a7a581c4c492070a345f2226c3"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "93cda7b07b0194f06d0535bd7204a84037ec22bdb6a00bf00a80f0067060ca58"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "f94d7dac7bf4180e7105e65a5992232ad116ad45d174dea097042c6c759f7c2a"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5805a39e757cb6fd3707cf7f85b3a02017312b086ebf2186dd5020e21b5f07b0"
    sha256 cellar: :any_skip_relocation, ventura:        "2dbd1c34c726959cbe2880fcca40f849955454bfda612aec8b006302839582d4"
    sha256 cellar: :any_skip_relocation, monterey:       "ded0ab3ef8abe606d85070f3681f87d669b705ddc6c03ea35e316fdfaef2056d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f573e35fe03c2856a4b98b225a16b91f7aed2ada3fd77331512ceb2dff4e321b"
  end

  depends_on "pcre"

  def install
    Dir.chdir "phalcon-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
