# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT72 < AbstractPhp72Extension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.1.tgz"
  sha256 "da3566db17422e5ef08b7ff144162952aabc14cb22407cc6b1d2a2d095812bd0"
  head "https://github.com/m6w6/ext-raphf.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    cellar :any_skip_relocation
    sha256 "9c89f8bfdda1481c9368113591d65c2b61c74a42d377d564de3adec1fcb5f4cc" => :big_sur
    sha256 "3517af4e0eb8c7b625fa9e2deed9788fac1b377738b186670c7a3b5275fadcc4" => :arm64_big_sur
    sha256 "d3ec37c822e6bacc4abbc78ed41aa98f4267d342941f0ac5955b690dd67f06bc" => :catalina
  end

  def install
    Dir.chdir "raphf-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/raphf.so"
    write_config_file
  end
end
