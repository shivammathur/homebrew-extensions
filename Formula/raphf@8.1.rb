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
    rebuild 8
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "27b3e028c50921042020f6d2ccdd00da273d08d86eebecbc5ba3cb8c412b2040"
    sha256 cellar: :any_skip_relocation, big_sur:       "c3e121a737196ea58522ed16af855c03cdaf5c7008c2d552522bae64f665d563"
    sha256 cellar: :any_skip_relocation, catalina:      "d10c27277d7887aae7f2a12e50191e543747ca00a115c493e49e3f050776b286"
  end

  def install
    Dir.chdir "raphf-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
    add_include_files
  end
end
