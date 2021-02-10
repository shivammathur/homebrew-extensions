# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT81 < AbstractPhp81Extension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.1.tgz"
  sha256 "da3566db17422e5ef08b7ff144162952aabc14cb22407cc6b1d2a2d095812bd0"
  head "https://github.com/m6w6/ext-raphf.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 6
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "6b71d8a5469542090f024e246eb42355b37de76fd628ad323db740ba97c86d3a"
    sha256 cellar: :any_skip_relocation, big_sur:       "a3b8ae90b8275cff39877e39e0af7796e146b4a9ebbb712cd154163bbc4f245e"
    sha256 cellar: :any_skip_relocation, catalina:      "4a4e1bc292d47188ea57119ae26ae134d1f6bffa81291b0d7edb149081fa3079"
  end

  def install
    Dir.chdir "raphf-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
    add_include_files
  end
end
