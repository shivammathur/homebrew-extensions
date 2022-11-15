# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT70 < AbstractPhpExtension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.1.tgz"
  sha256 "da3566db17422e5ef08b7ff144162952aabc14cb22407cc6b1d2a2d095812bd0"
  head "https://github.com/m6w6/ext-raphf.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d3fb6ad8241d3cc5450c70a5dab1bff44e79134a71e17c2ce776b02f4276c5ab"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "1abba2eb73a0322df35086a3b1e7435b608eb836fff751bbd66794936613ca6c"
    sha256 cellar: :any_skip_relocation, monterey:       "ce1aa02bda0a6c529529cf1b85496bb7b91f6f1ea128631395916847ccec242e"
    sha256 cellar: :any_skip_relocation, big_sur:        "a7bad6113e3b5c0ad47ad56af457ad9b74d472c4d0ae8275cc982a393fc21e26"
    sha256 cellar: :any_skip_relocation, catalina:       "712b6152fcaa43a8f5174ba6a3e0b58d6f23dcb8f7828cd6e03e177f9102f710"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8bfddf2f9791b162c6abc277ccf6fb18f3df2e150aaf3d5c02f7a97f27610bf1"
  end

  def install
    Dir.chdir "raphf-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
