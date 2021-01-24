# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT71 < AbstractPhp71Extension
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
    sha256 "b019d6504070c5835a23c80d1f21b47bdb073d7dc8f22959dc1192837fdf4992" => :big_sur
    sha256 "685973d805adaed8c58360f7bbb8e24afb5a71b24a4d72579c29e27ace35141c" => :arm64_big_sur
    sha256 "926a7e35b08ab75bfccf324684b9fa070cf30f0895e177ba7b0dd72fb8af5779" => :catalina
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
