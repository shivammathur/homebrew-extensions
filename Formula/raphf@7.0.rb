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
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "48212f432f9b73d5ed9ba299d6be6439cd13186a25ed5cbf10e5e9f30cfa6357"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "7cc2c9764010ff3190cf8a61716544174526d5c1791bc67f1538d586e0420ffd"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e723201c0a8ee835632d1ee7ed7e7597e2e287dd37fa9689b4e4f86c4c19d097"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "2ddc66d01e20c0b4daaa3206c008a7f406c876ca248c4ae6ef6f044ce7c6802f"
    sha256 cellar: :any_skip_relocation, ventura:        "d541042dfcb3ac12e4b7f138f424c26ae6df41292e78ee077842ac0e4224a453"
    sha256 cellar: :any_skip_relocation, monterey:       "d364411e07d2a99069b50f6501d65bf4f70623e53505fda475735dce1614fbf7"
    sha256 cellar: :any_skip_relocation, big_sur:        "2c3a8154663f97b609a8bf0dc105b2bb9debde33d1a56948590549ad427d53f1"
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
