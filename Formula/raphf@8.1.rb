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
    rebuild 7
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "d78ef4499be766fad3bd7c2f09441d309d1cfdf8f62765788fd0f213ff9e29d8"
    sha256 cellar: :any_skip_relocation, big_sur:       "6ea5f916b24de37dea4be7285ada7c81fa64ea918a1245f31fdd359e68d629b7"
    sha256 cellar: :any_skip_relocation, catalina:      "c8ae3026c0160367da9165dab4225c6f320d640f5580c75302efbf93ba627e17"
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
