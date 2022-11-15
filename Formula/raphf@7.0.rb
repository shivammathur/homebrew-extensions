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
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e723201c0a8ee835632d1ee7ed7e7597e2e287dd37fa9689b4e4f86c4c19d097"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "2ddc66d01e20c0b4daaa3206c008a7f406c876ca248c4ae6ef6f044ce7c6802f"
    sha256 cellar: :any_skip_relocation, monterey:       "3847387b89b598b04dd38d4eaead27043a1174472772c3a86368156a36b34dbd"
    sha256 cellar: :any_skip_relocation, big_sur:        "2c3a8154663f97b609a8bf0dc105b2bb9debde33d1a56948590549ad427d53f1"
    sha256 cellar: :any_skip_relocation, catalina:       "df68e41e5785ddb75b595c7801a025569fdb616ae64c66568d9357e760f52994"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "80d1b57c34625f5b863d1463ec62e3912ec0385695ef900d6fde6bf732febe4d"
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
